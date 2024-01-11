import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class CategoryItem extends StatelessWidget {
  CategoryItem({super.key, required this.name});

  final String name;
  final List<String> genderItems = [
  'Giá giảm dần',
  'Giá tăng dần',
  'Bỏ chọn',
];

String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[350],
      appBar: AppBar(
        backgroundColor: Colors.pink[50],
        iconTheme: IconThemeData(color: Colors.black),
        title:Column(
          children: [
              Text(name, style: TextStyle(color: Colors.black, fontSize: 22),),
          ],
        ),  
      ),
      body:SingleChildScrollView(
        child: Column(
         children:[
          Container(
            height: 50,
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.only(left: 10),
            width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 1,color: Colors.black),
                borderRadius: BorderRadius.circular(10.0)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                  Row(
                      children: [
                        Icon(Icons.filter_list_alt),
                        Text("Bộ lọc",style: TextStyle(fontSize: 20),)
                      ],
                    ),
                  Container(
                    height: 70,
                    width: 150,
                    child: Expanded(child: DropdownButtonFormField2<String>(
                    isExpanded: true,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    hint: const Text(
                      'Sắp xếp theo',
                      style: TextStyle(fontSize: 14),
                    ),
                    items: genderItems.map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(item,style: const TextStyle(fontSize: 14,), ),)).toList(),
                            validator: (value) {
                            if (value == null) {
                              return 'Sắp xếp theo';
                            }
                            return null;
                          },
                          onChanged: (value) {},
                          onSaved: (value) {
                            selectedValue = value.toString();
                          },
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.only(right: 8),
                        ),
                        iconStyleData: const IconStyleData(
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black45,
                          ),
                          iconSize: 24,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                        ),
                      ),
                  ),
                  ),
                
                ],
                
              ),
            ),
        ],
        ),
      )
    );
  }
}
