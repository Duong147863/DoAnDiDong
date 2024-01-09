import 'package:doandidongappthuongmai/components/BuildListItem.dart';
import 'package:doandidongappthuongmai/components/ProductItem.dart';
import 'package:doandidongappthuongmai/components/ProductSection.dart';
import 'package:doandidongappthuongmai/view/CategoryItemScreen.dart';
import 'package:doandidongappthuongmai/view/ProductCartScreen.dart';
import 'package:doandidongappthuongmai/view/SearchScreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedButtonIndex = 0;  
  int QuantityInCart=0;         // số lượng sản phẩm trong giỏ hàng
  List<List<Map<String, dynamic>>> productData = [    // tạo danh sách mặc định
    [
      {'image': 'assets/img/Manboc1.png', 'name': 'Giấy chống dính', 'price': '26.500','promotion':20000},
      {'image': 'assets/img/Manboc2.png', 'name': '120 Túi thực phẩm', 'price': '28.000','promotion':17000},
      {'image': 'assets/img/Manboc3.png', 'name': 'Màng bọc thực phẩm inochi', 'price': '132.000','promotion':120000},
      {'image': 'assets/img/Manboc4.png', 'name': 'Màng bọc nhôm', 'price': '45.000','promotion':25000},
      {'image': 'assets/img/Manboc5.png', 'name': '20 túi zipper khóa kéo', 'price': '47.000','promotion':43000},
      {'image': 'assets/img/Manboc4.png', 'name': 'Màng bọc nhôm', 'price': '45.000','promotion':25000},
      {'image': 'assets/img/Manboc5.png', 'name': '20 túi zipper khóa kéo', 'price': '47.000','promotion':43000},
    ],
  ];
  @override
  Widget build(BuildContext context) {
   return Scaffold(
    backgroundColor: Colors.grey[200],
      appBar: AppBar(
      backgroundColor: Colors.pink[50],
      title: InkWell(
        onTap: () {
        Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => SearchScreen(),     // chuyển đến trang tìm kiếm
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);    // Điểm bắt đầu của hiệu ứng chuyển động (phải)
            const end = Offset.zero;           // Điểm kết thúc của hiệu ứng chuyển động (đến)
            const curve = Curves.easeInOut;    // Điều chỉnh đường cong của chuyển động

            // Tạo tween (chuyển động từ 'begin' đến 'end' với đường cong đã chọn)
            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            // Ánh xạ chuyển động tween vào animation
            var offsetAnimation = animation.drive(tween);

            // Áp dụng hiệu ứng Slide Transition sử dụng position và child
            return SlideTransition(
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
              child: Icon(
                Icons.search,
                color: Colors.grey,
              ),
            ),
            Text(
              'Tìm sản phẩm ....',
              style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
            ),
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
                      builder: (context) =>  ShoppingCartScreen()    //chuyển đến giỏ hàng
                    ),
                  );
                },
              ),
            ],
          ),
          if (QuantityInCart > 0)   //kiểm tra nếu không có sản phẩm sẽ ẩn số
            Positioned(
              right: 10,
              top: 5,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text('${QuantityInCart.toString()}',style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.black,),),
              ),
            ),
        ],
      ),
    ),
  ),
  body: SingleChildScrollView(   /* tạo cuộn dọc màn hình */
    child: Column(
      children: [
        Image.asset("assets/img/tmdt1.jpg",
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
          child:const Column(
            children: [
              Wrap(           // tạo danh mục sản phẩm co khoảng cách = nhau
                children: [
                  ProductContainer(image: "assets/img/chao.png",text: "Chảo",),
                  ProductContainer(image: "assets/img/noi.png", text: "Nồi"),
                  ProductContainer(image: "assets/img/chen.jpg", text: "Chén, bát"),
                  ProductContainer(image: "assets/img/dua.png", text: "Đũa"),
                  ProductContainer(image: "assets/img/ly.png", text: "Ly"),
                  ProductContainer(image: "assets/img/manboc.png", text: "Màng bọc"),
                  ProductContainer(image: "assets/img/noicomdien.jpg", text: "Nồi cơm điện"),
                  ProductContainer(image: "assets/img/ruachen.png", text: "Đồ rửa chén"),
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
              const SectionList(          //Danh sách các button trong Title Sản phẩm bán chạy
                buttonTexts: ['Màng bọc thực phẩm', 'Xoong, nồi', 'Chảo', 'Chén,bát', 'Nước rửa chén'],
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
          height: MediaQuery.of(context).size.height * 0.5,
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
                      itemCount: productData[selectedButtonIndex].length,
                      itemBuilder: (context, index) {
                        var productDetails = productData[selectedButtonIndex][index];
                        return ProductItem(
                          image: productDetails['image'],
                          Name: productDetails['name'],
                          price: productDetails['price'],
                          promotion: productDetails['promotion'],
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Text("Xem thêm sản phẩm khuyến mãi", style: TextStyle(decoration: TextDecoration.underline, color: Colors.red)),
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
          height: MediaQuery.of(context).size.height*0.75,
          child: Stack(          
            children: [
              Positioned(        // đặt vị trí khung
                bottom: 10,
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
                    height:MediaQuery.of(context).size.height*0.67,
                    child: ListView.builder(
                      itemCount: (productData[selectedButtonIndex].length/2).ceil(),   // làm tròn 
                      itemBuilder: (context, index) {
                        if( productData[selectedButtonIndex].length %2 !=0 && index == (productData[selectedButtonIndex].length/2).ceil()-1)
                        {
                          return Row(
                            children: [
                                  ItemProduct(
                                  image: productData[selectedButtonIndex][index*2]['image'],
                                  Name:productData[selectedButtonIndex][index*2]['name'],
                                  price: productData[selectedButtonIndex][index*2]['price'],
                                  promotion:productData[selectedButtonIndex][index*2]['promotion'],
                                ),
                            ],
                          );
                        }
                        else{
                          return Row(
                            children: [
                                  ItemProduct(
                                  image: productData[selectedButtonIndex][index*2]['image'],
                                  Name:productData[selectedButtonIndex][index*2]['name'],
                                  price: productData[selectedButtonIndex][index*2]['price'],
                                  promotion:productData[selectedButtonIndex][index*2]['promotion'],
                                ),
                                 ItemProduct(
                                  image: productData[selectedButtonIndex][index*2+1]['image'],
                                  Name:productData[selectedButtonIndex][index*2+1]['name'],
                                  price: productData[selectedButtonIndex][index*2+1]['price'],
                                  promotion:productData[selectedButtonIndex][index*2+1]['promotion'],
                                ),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                ],
              )
             ],
            ),
          ),
        ],
        ),
      ],
    )
    ),
   );
  }
}

class ProductContainer extends StatelessWidget {
  final String image;
  final String text;
  const ProductContainer({Key? key, required this.image, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
        MaterialPageRoute(builder: (context) => CategoryItem(name: text,), ),); // chuyển đến 1 danh mục được chọn
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
            Text(
              text,
              softWrap: true,
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
