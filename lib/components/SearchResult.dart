import 'package:doandidongappthuongmai/components/ListResultItem.dart';
import 'package:flutter/material.dart';
import 'package:tiengviet/tiengviet.dart';
class SearchResult extends StatelessWidget {
  const SearchResult({super.key, required this.Searchtext});
  final String Searchtext;

  @override
  Widget build(BuildContext context) {
    List<List<Map<String, dynamic>>> AllProduct = [    // tạo danh sách mặc định
    [
      {'image': 'assets/img/Manboc1.png', 'name': 'Giấy chống dính', 'price': '26.500','promotion':20000},
      {'image': 'assets/img/Manboc2.png', 'name': '120 Túi thực phẩm', 'price': '28.000','promotion':17000},
      {'image': 'assets/img/Manboc3.png', 'name': 'Màng bọc thực phẩm inochi', 'price': '132.000','promotion':120000},
      {'image': 'assets/img/Manboc4.png', 'name': 'Màng bọc nhôm', 'price': '45.000','promotion':25000},
      {'image': 'assets/img/Manboc5.png', 'name': '20 túi zipper khóa kéo', 'price': '47.000','promotion':43000},
      {'image': 'assets/img/Manboc4.png', 'name': 'Màng bọc nhôm', 'price': '45.000','promotion':25000},
      {'image': 'assets/img/Manboc5.png', 'name': '20 túi zipper khóa kéo', 'price': '47.000','promotion':43000},
      {'image': 'assets/img/Noi1.png', 'name': 'Nồi inox đáy Anpha Cook', 'price': '295.000','promotion':260000},
      {'image': 'assets/img/Noi2.png', 'name': 'Bộ nồi xửng inox đáy Rainy', 'price': '399.000','promotion':0},
      {'image': 'assets/img/Noi3.png', 'name': 'Quánh inox 3 đáy Rainy', 'price': '299.000','promotion':288000},
      {'image': 'assets/img/Chao1.png', 'name': 'Chảo nhôm chống dính 2 quai Rainy 22cm', 'price': '99.000','promotion':0},
      {'image': 'assets/img/Chao2.png', 'name': 'Chảo nhôm chống dính Rainy FRIENDLY 24cm', 'price': '140.000','promotion':99000},
      {'image': 'assets/img/Chao3.png', 'name': 'Chảo nhôm chống dính vân đá Rainy 20cm', 'price': '260.000','promotion':250000},
      {'image': 'assets/img/Chao4.png', 'name': 'Chảo nhôm chống dính Rainy FRIENDLY 16cm', 'price': '99.000','promotion':0},
      {'image': 'assets/img/Chao5.png', 'name': 'Chảo xào trơn chống dính Rainy 30cm', 'price': '120.000','promotion':0},
      {'image': 'assets/img/Chen1.png', 'name': 'Chén cơm xứ 11cm Minh Châu', 'price': '15.000','promotion':0},
      {'image': 'assets/img/Chen2.png', 'name': '5 Chén cơm xứ 12 cm ', 'price': '60.000','promotion':55000},
      {'image': 'assets/img/Dia.png', 'name': 'Dĩa tròn 23cm', 'price': '100.000','promotion':0},
      {'image': 'assets/img/RuaChen1.png', 'name': 'Miếng rửa chén 2 lớp Samran 11cm', 'price': '10.000','promotion':7000},
      {'image': 'assets/img/Ruachen2.png', 'name': 'Miếng rửa chén siêu sạch Scotch Brite 10cm', 'price': '14.000','promotion':0},
      {'image': 'assets/img/Ruachen3.png', 'name': 'Gói 2 miếng cọ nồi cước inox nén', 'price': '19.500','promotion':12000},
      {'image': 'assets/img/Ruachen4.png', 'name': 'Lưới rửa chén Minitool', 'price': '12.000','promotion':0},
    ],
  ];
   List<Map<String, dynamic>> searchResults = [];
   void searchProducts(String searchText) {
      searchResults.clear();   //tạo danh sách rỗng trước khi lấy danh sách sp mới

  // Chuyển đổi chuỗi tìm kiếm và tên sản phẩm thành không dấu
    String searchTermNormalized = TiengViet.parse(searchText);
    
    for (List<Map<String, dynamic>> productList in AllProduct) {
      for (Map<String, dynamic> product in productList) {
        String productNameNormalized = TiengViet.parse(product['name']);
        if (productNameNormalized.toLowerCase().contains(searchTermNormalized.toLowerCase())) {
          searchResults.add(product);
        }
      }
    }
  }
  searchProducts(Searchtext);

return Scaffold(
  backgroundColor: Colors.grey[200],
  appBar: AppBar(
    title: Text('Kết quả tìm kiếm cho "$Searchtext"',style: TextStyle(color: Colors.black, fontSize: 18),),
    iconTheme: IconThemeData(color: Colors.black),
    backgroundColor: Colors.pink[50],
  ),
  body: searchResults.isEmpty? 
      Center(
          child: Text('Không tìm thấy kết quả',style: TextStyle(color: Colors.black, fontSize: 18),),
        )
      :  SingleChildScrollView(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.all(10),
              child:   Row(
                children: [
                Text("Tìm thấy ${searchResults.length} kết quả phù hợp",style: TextStyle(color: Colors.black, fontSize: 18),)
              ],), 
              ),
              Container(
                // margin: EdgeInsets.only(top: 20),
                height: MediaQuery.of(context).size.height-140,
                child: ListView.builder(
                  itemCount: (searchResults.length / 2).ceil(),
                  itemBuilder: (context, index) {
                    if (searchResults.length % 2 != 0 && index == (searchResults.length / 2).ceil() - 1) {
                      return Row(
                        children: [
                         ProductResultItem(
                            image: searchResults[index * 2]['image'],
                            Name: searchResults[index * 2]['name'],
                            price: searchResults[index * 2]['price'],
                            promotion: searchResults[index * 2]['promotion'],
                          ),
                        ],
                      );
                    } else {
                      return Row(
                        children: [
                          ProductResultItem(
                            image: searchResults[index * 2]['image'],
                            Name: searchResults[index * 2]['name'],
                            price: searchResults[index * 2]['price'],
                            promotion: searchResults[index * 2]['promotion'],
                          ),
                          ProductResultItem(
                            image: searchResults[index * 2 + 1]['image'],
                            Name: searchResults[index * 2 + 1]['name'],
                            price: searchResults[index * 2 + 1]['price'],
                            promotion: searchResults[index * 2 + 1]['promotion'],
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
    );
  }
}