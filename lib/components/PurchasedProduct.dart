import 'package:flutter/material.dart';

class PurchasedProduct extends StatefulWidget {
  const PurchasedProduct({Key? key}) : super(key: key);

  @override
  State<PurchasedProduct> createState() => _PurchasedProductState();
}

class _PurchasedProductState extends State<PurchasedProduct> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 130,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            border: Border.all(color: Colors.grey[300]!, width: 1.0),
          ),
          child: Stack(
            children: [
              Row(
                children: [
                  Container(
                    height: 100,
                    width: 110,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    child: Image.asset(
                      'assets/img/nuocruachen.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(8, 12, 8, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nước rửa chén Lix siêu sạch hương chanh túi 3.43 lít',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '55.000đ',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 8,
                right: 12,
                child: SizedBox(
                  width: 100,
                  height: 35,
                  child: TextButton(
                    onPressed: () {
                      // Xử lý sự kiện khi nhấn
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13.0),
                          side:
                              const BorderSide(color: Colors.black, width: 1.0),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Mua lại',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
