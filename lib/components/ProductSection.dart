import 'package:doandidongappthuongmai/components/ProductItem.dart';
import 'package:flutter/material.dart';

class SectionList extends StatefulWidget {
  final List<String> buttonTexts;

  const SectionList({Key? key, required this.buttonTexts}) : super(key: key);

  @override
  _ButtonListState createState() => _ButtonListState();
}

class _ButtonListState extends State<SectionList> {
  int selectedButtonIndex = 0;

  // Sample product data
  List<List<Map<String, dynamic>>> productData = [
    [
      {'image': 'assets/img/Manboc1.png', 'name': 'Giấy chống dính', 'price': '26.500','promotion':20000},
      {'image': 'assets/img/Manboc2.png', 'name': '120 Túi thực phẩm', 'price': '28.000','promotion':17000},
      {'image': 'assets/img/Manboc3.png', 'name': 'Màng bọc thực phẩm inochi', 'price': '132.000','promotion':120000},
      {'image': 'assets/img/Manboc4.png', 'name': 'Màng bọc nhôm', 'price': '45.000','promotion':25000},
      {'image': 'assets/img/Manboc5.png', 'name': '20 túi zipper khóa kéo', 'price': '47.000','promotion':43000},
    ],
    [
      {'image': 'assets/img/Noi1.png', 'name': 'Nồi inox đáy Anpha Cook', 'price': '295.000','promotion':260000},
      {'image': 'assets/img/Noi2.png', 'name': 'Bộ nồi xửng inox đáy Rainy', 'price': '399.000','promotion':0},
      {'image': 'assets/img/Noi3.png', 'name': 'Quánh inox 3 đáy Rainy', 'price': '299.000','promotion':288000},
    ],
    [
      {'image': 'assets/img/Chao1.png', 'name': 'Chảo nhôm chống dính 2 quai Rainy 22cm', 'price': '99.000','promotion':0},
      {'image': 'assets/img/Chao2.png', 'name': 'Chảo nhôm chống dính Rainy FRIENDLY 24cm', 'price': '140.000','promotion':99000},
      {'image': 'assets/img/Chao3.png', 'name': 'Chảo nhôm chống dính vân đá Rainy 20cm', 'price': '260.000','promotion':250000},
      {'image': 'assets/img/Chao4.png', 'name': 'Chảo nhôm chống dính Rainy FRIENDLY 16cm', 'price': '99.000','promotion':0},
      {'image': 'assets/img/Chao5.png', 'name': 'Chảo xào trơn chống dính Rainy 30cm', 'price': '120.000','promotion':0},
    ],
     [
      {'image': 'assets/img/Chen1.png', 'name': 'Chén cơm xứ 11cm Minh Châu', 'price': '15.000','promotion':0},
      {'image': 'assets/img/Chen2.png', 'name': '5 Chén cơm xứ 12 cm ', 'price': '60.000','promotion':55000},
      {'image': 'assets/img/Dia.png', 'name': 'Dĩa tròn 23cm', 'price': '100.000','promotion':0},
    ],
    [
      {'image': 'assets/img/RuaChen1.png', 'name': 'Miếng rửa chén 2 lớp Samran 11cm', 'price': '10.000','promotion':7000},
      {'image': 'assets/img/Ruachen2.png', 'name': 'Miếng rửa chén siêu sạch Scotch Brite 10cm', 'price': '14.000','promotion':0},
      {'image': 'assets/img/Ruachen3.png', 'name': 'Gói 2 miếng cọ nồi cước inox nén', 'price': '19.500','promotion':12000},
      {'image': 'assets/img/Ruachen4.png', 'name': 'Lưới rửa chén Minitool', 'price': '12.000','promotion':0},
    ]
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 60),
        Container(
          height: 45,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.buttonTexts.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedButtonIndex = index;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: selectedButtonIndex == index ? Colors.blue[200] : Colors.grey[100],
                    side: BorderSide(color: Colors.black),
                  ),
                  child: Text(
                    widget.buttonTexts[index],
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 8),
          height: 210,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
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
        Text("Xem thêm sản phẩm bán chạy", style: TextStyle(decoration: TextDecoration.underline, color: Colors.green)),
      ],
    );
  }
}
