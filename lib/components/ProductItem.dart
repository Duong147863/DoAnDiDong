import 'package:doandidongappthuongmai/view/ProductDeatailScreen.dart';
import 'package:flutter/material.dart';


class ProductItem extends StatelessWidget {
  final String image;
  final String Name;
  final String price;
  final int promotion;

  const ProductItem({
    Key? key,
    required this.image,
    required this.Name,
    required this.price,
    required this. promotion
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {          //chuyển đến chi tiết sản phẩm
       Navigator.push(context,MaterialPageRoute(builder: (context) => ProductDetailsScreen(   
            image: image,
            productName: Name,
            price: price,
          ), 
        ),
      );
      },
      child:Container(
      width: 110,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black54, width: 1)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 108,
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
               image: AssetImage(image),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Text(
            Name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(height: 5,),
          Row(
              children: [
                if (promotion > 0)  //có giảm giá
                  Column(
                    children: [
                      Text('${promotion}đ',style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold)),             
                      Text(
                        '${price}đ',
                        style: const TextStyle(
                          fontSize: 16,
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                if (( promotion == 0) && price != null)  //không có giảm giá
                  Text(
                    '${price}đ',
                    style: const TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                  ),
              ],
            ),
        ],
      ),
     ),
    );
  }
 
}

