import 'package:doandidongappthuongmai/view/ProductDeatailScreen.dart';
import 'package:flutter/material.dart';

class ItemProduct extends StatelessWidget {
  final String image;
  final String Name;
  final String price;
  final int promotion;

  const ItemProduct({
    Key? key,
    required this.image,
    required this.Name,
    required this.price,
    required this. promotion
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showProductDetails(context);
      },
      child:
     Container(
      width: (MediaQuery.of(context).size.width / 2) - 20,
      height: MediaQuery.of(context).size.height / 3 - 20,
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
           width: (MediaQuery.of(context).size.width / 2) - 20,
           height: MediaQuery.of(context).size.height / 4 - 20,
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
                if (promotion > 0)
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
                if (( promotion == 0) && price != null)
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
  void _showProductDetails(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ProductDetailsScreen(
        image: image,
        productName: Name,
        price: price,
      ),
    ),
  );
}
}
