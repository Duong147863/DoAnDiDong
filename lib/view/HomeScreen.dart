import 'package:doandidongappthuongmai/components/GetCart.dart';
import 'package:doandidongappthuongmai/components/ProductSuggestItem.dart';
import 'package:doandidongappthuongmai/components/ProductSaleItem.dart';
import 'package:doandidongappthuongmai/components/ProductSection.dart';
import 'package:doandidongappthuongmai/view/CategoryItemScreen.dart';
import 'package:doandidongappthuongmai/view/ProductCartScreen.dart';
import 'package:doandidongappthuongmai/view/SearchScreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:doandidongappthuongmai/models/load_data.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  final String Id;
  const MainScreen({super.key, required this.Id});
  
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
 
 List<Product> allProductsale=[];
 List<Product> randomProductsuggest=[];
 int selectedButtonIndex = 0;  

 void _loadProductsales() async {    //lấy danh sách sản phẩm khuyến mãi
  List<Product> productsale = await Product.fetchProductsWithPromotion();
    setState(() {
     allProductsale = productsale;
    });
    print("all productsale : ${allProductsale}");
  }
    void _loadProductSuggests() async {
    List<Product> productsuggest = await Product.fetchProductSuggests();
    productsuggest.shuffle();
    List<Product> randomProducts = productsuggest.take(8).toList();
    setState(() {
      randomProductsuggest = randomProducts;
    });
  }
  @override
  void initState() {
    super.initState();
    _loadProductsales();
    _loadProductSuggests();
     Provider.of<CartProvider>(context, listen: false).loadCartQuantity(widget.Id);  // cập nhật số lượng giỏ hàng đồng bộ vs productdetail
   
  }
  Future<void> _refreshData() async {
     _loadProductSuggests();
    setState(() {
     
     Provider.of<CartProvider>(context, listen: false).loadCartQuantity(widget.Id);  // cập nhật số lượng giỏ hàng đồng bộ vs productdetail
    });
    return Future.value();
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
    backgroundColor: Colors.grey[200],
      appBar: AppBar(
      backgroundColor: Colors.pink[50],
      title: InkWell(
        onTap: () {
        Navigator.push( context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => SearchScreen(id: widget.Id,),     // chuyển đến trang tìm kiếm
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);    // Điểm bắt đầu của hiệu ứng chuyển động (phải)
            const end = Offset.zero;           // Điểm kết thúc của hiệu ứng chuyển động (đến)
            const curve = Curves.easeInOut;    // Điều chỉnh đường cong của chuyển động
            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve)); //Tạo tween (chuyển động từ 'begin' đến 'end' với đường cong đã chọn)
            var offsetAnimation = animation.drive(tween);  // Ánh xạ chuyển động tween vào animation
            return SlideTransition(    // Áp dụng hiệu ứng Slide Transition sử dụng position và child
              position: offsetAnimation,
              child: child,
            );
          },
        ),
      );
      },
      child: Container(
        width: 300,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 1.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Row(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.search,color: Colors.grey,),
            ),
            Text('Tìm sản phẩm ....', style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),),
          ],
        ),
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.black), 
    elevation: 0.0,
    flexibleSpace: Container(
      padding: EdgeInsets.only(top: 35, right: 15),
      height: 200, 
      child: Stack(     /* tạo icon và cho ghi đè số lượng sp đang có trong giỏ hàng*/
        alignment: Alignment.center,
        children: [ Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton( 
                icon: const Icon(Icons.shopping_cart, color: Colors.red, size: 30),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  ShoppingCartScreen(Id: widget.Id,)    //chuyển đến giỏ hàng
                    ),
                  ).then((value) {
                        if (value != null && value) {
                          setState(() {
                             Provider.of<CartProvider>(context, listen: false).loadCartQuantity(widget.Id); 
                         });
                        }
                      });
                },
              ),
            ],
          ),
          Consumer<CartProvider>(       // lắng nghe sự thay đổi trong đối tượng CartProvider 
            builder: (context, cartProvider, child) {
              if (cartProvider.totalCartQuantity > 0) {
                return Positioned(
                  right: 10,
                  top: 5,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text( '${cartProvider.totalCartQuantity.toString()}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    ),
  ),
  body: RefreshIndicator(
    onRefresh: _refreshData,
    child: SingleChildScrollView(   /* tạo cuộn dọc màn hình */
     child: Column(
      children: [
          Image( image: AssetImage('assets/img/tmdt1.jpg'),
          width: MediaQuery.of(context).size.width,
          height: 180,
          fit: BoxFit.cover,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white, 
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
              ),
            ],
          ),
          child: Column(
            children: [
              Wrap(           // tạo danh mục sản phẩm co khoảng cách = nhau
                children: [
                  ProductCategory(image: "assets/img/chao.png",text: "Chảo",CategoryId: "4", id: widget.Id,),
                  ProductCategory(image: "assets/img/noi.png", text: "Nồi",CategoryId: "3", id: widget.Id),
                  ProductCategory(image: "assets/img/chen.jpg", text: "Chén, bát",CategoryId: "7", id: widget.Id),
                  ProductCategory(image: "assets/img/dua.png", text: "Đũa",CategoryId: "5", id: widget.Id),
                  ProductCategory(image: "assets/img/ly.png", text: "Ly",CategoryId: "2", id: widget.Id),
                  ProductCategory(image: "assets/img/manboc.png", text: "Màng bọc",CategoryId: "1", id: widget.Id),
                  ProductCategory(image: "assets/img/noicomdien.jpg", text: "Nồi cơm điện",CategoryId: "6", id: widget.Id),
                  ProductCategory(image: "assets/img/ruachen.png", text: "Đồ rửa chén",CategoryId: "8", id: widget.Id),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 5),
        Column(             
         children: [
          SizedBox(                //tạo khung bên ngoài chứa nội dung ,hình ảnh
            height: MediaQuery.of(context).size.height * 0.5,
            child: Stack(
            children: [
              Positioned(         // đặt vị trí khung
                top: 20,
                bottom: 55, 
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 1.2),
                    borderRadius:  BorderRadius.all( Radius.circular(20),),
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.6,
                ),
              ),
              SectionList(
                  categories: [
                    CategoryData(id: '1', name: 'Màng bọc thực phẩm'),
                    CategoryData(id: '3', name: 'Xoong, nồi'),
                    CategoryData(id: '4', name: 'Chảo'),
                    CategoryData(id: '7', name: 'Chén,bát'),
                    CategoryData(id: '8', name: 'Đồ rửa chén'),
                  ],
                  id: widget.Id,
                ),
              Positioned(        // đặt vị trí tiêu đề
                top:17,
                height: 40,
                left: 70,
                right: 70,
                child: ClipRRect(       //cắt góc bên dưới của 1 container
                  borderRadius:const BorderRadius.vertical(
                      bottom: Radius.circular(60),
                    ),
                  child: Card(         //thẻ chứa tiêu đề
                    child: Container(
                      color: Colors.green,
                      child: const Center(
                        child: Text('SẢN PHẨM BÁN CHẠY',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
             ],
            ),
          ),
        ],
        ),
        Column(
         children: [
          SizedBox(        //tạo khung bên ngoài chứa nội dung ,hình ảnh
          height: MediaQuery.of(context).size.height * 0.43,
          child: Stack(          
            children: [
              Positioned(           // đặt vị trí khung
                height: 300,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.red, width: 1.2),
                    borderRadius:  BorderRadius.all( Radius.circular(20),),),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.6,
                ),
              ),
              Positioned(         // đặt vị trí tiêu đề
                top: -10,
                height:50,
                left: 70,
                right: 70,
                child: ClipRRect(
                  borderRadius:const BorderRadius.vertical(bottom: Radius.circular(60),),
                  child: Card(
                    child: Container(
                      color: Colors.red[400],
                      child: const Center(
                        child: Text('SẢN PHẨM KHUYẾN MÃI',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.yellow,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Column(      // chứa danh sách sản phẩm 
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 40),
                    height: 210,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,     // cuộn ngang
                      itemCount: allProductsale.length,
                      itemBuilder: (context, index) {
                        var productsale =allProductsale[index] ;
                        return ProductSaleItem(ProductsaleReference: FirebaseDatabase.instance.ref().child('products').child(productsale.id.toString()),
                        id: widget.Id,
                        
                        );
                      },
                    ),
                  ),
                  // SizedBox(height: 10),
                  // Text("Xem thêm sản phẩm khuyến mãi", style: TextStyle(decoration: TextDecoration.underline, color: Colors.red)),
                ],
              )
             ],
            ),
          ),
        ],
        ),
        Column(
         children: [
          SizedBox(        //tạo khung bên ngoài chứa nội dung ,hình ảnh 
          height: ((MediaQuery.of(context).size.height / 2.52 ) * (randomProductsuggest.length/2).ceil()),
          child: Stack(          
            children: [
              Positioned(        // đặt vị trí khung
                bottom: 10,
                top:0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.green, width: 1.2),
                    borderRadius:  BorderRadius.all( Radius.circular(20),),),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.6,
                ),
              ),
              Positioned(      // đặt vị trí tiêu đề
                top: -10,
                height:50,
                left: 70,
                right: 70,
                child: ClipRRect(
                  borderRadius:const BorderRadius.vertical(
                      bottom: Radius.circular(60),
                    ),
                  child: Card(
                    child: Container(
                      color: Colors.green[100],
                      child: const Center(
                        child: Text('GỢI Ý HÔM NAY',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 40),
                    height: ((MediaQuery.of(context).size.height / 2.6 ) * (randomProductsuggest.length/2).ceil()),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: (randomProductsuggest.length/2).ceil(),   // làm tròn 
                      itemBuilder: (context, index) {
                        if(randomProductsuggest.length %2 !=0 && index == (randomProductsuggest.length/2).ceil()-1)
                        {
                          return Row(
                            children: [
                            ProductSuggestItem(key: ValueKey<String>(randomProductsuggest[index*2].id),
                              ProductsuggestReference:FirebaseDatabase.instance.ref().child('products').child(randomProductsuggest[index*2].id.toString()) ,
                             id: widget.Id,
                             ),
                            ],
                          );
                        }
                        else{
                          return Row(
                            children: [
                              ProductSuggestItem(
                                key: ValueKey<String>(randomProductsuggest[index*2].id),
                                ProductsuggestReference:FirebaseDatabase.instance.ref().child('products').child(randomProductsuggest[index*2].id.toString()) ,
                                id: widget.Id,
                                ),
                              ProductSuggestItem(
                                key:ValueKey<String>(randomProductsuggest[index*2+1].id),
                                ProductsuggestReference:FirebaseDatabase.instance.ref().child('products').child(randomProductsuggest[index*2+1].id.toString()) ,
                                id: widget.Id,
                                ),
                            ],
                          );
                        }
                      },
                    ),
                  )
                  ],
                  ),
                ],
              )
             
            
          ),
        ],
        ),
      ],
    )
    ),
    )
   );
  }
}
class ProductCategory extends StatelessWidget {
  final String image;
  final String text;
  final String CategoryId;
  final String id;
  const ProductCategory({Key? key, required this.image, required this.text, required this.CategoryId, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
        MaterialPageRoute(builder: (context) => CategoryItem(CategoryId: CategoryId, name: text,id:id,), ),); // chuyển đến 1 danh mục được chọn
        },  //
      child: Container(
        width: MediaQuery.of(context).size.width / 4.5,
        height: 70,
        margin: EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image,
              width: 51,
              height: 51,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 5),
            Text("${text}",
              softWrap: true,
              style: TextStyle(fontSize: 12),
            ),

          ],
        ),
      ),
    );
  }
}
