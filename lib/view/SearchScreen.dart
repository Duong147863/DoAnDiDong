import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreen1State();
}

class _SearchScreen1State extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<String> searchHistory = [];
 List<Map<String, dynamic>> specialOffers = [
    {'image': 'assets/img/combo1.png', 'text': 'Giảm sốc nhiều combo gia dụng lên đến 50%'},
    {'image': 'assets/img/combo2.png', 'text': 'Vệ sinh nhà cửa giảm đến 40% '},
    {'image': 'assets/img/combo3.jpg', 'text': 'Ưu đãi hoàn tiền mua sắm 20% '},
  ];

  @override
  void initState() {
    super.initState();
    loadSearchHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.pink[50],
        iconTheme: const IconThemeData(color: Colors.black),
        title: Container(
          padding: EdgeInsets.only(left: 10),
          width: 300,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 1.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: _searchController,
            onChanged: (value) {
              setState(() {});
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Nhập tên sản phẩm cần tìm',
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: Icon(Icons.clear, color: Colors.black,),
                      onPressed: () {
                        setState(() {
                          _searchController.clear();
                        });
                      },
                    )
                  : null,
            ),
          ),
        ),
        actions: [
          IconButton(
            padding: EdgeInsets.only(right: 20),
            icon: Icon(Icons.search, size: 35),
            onPressed: () {
              updateSearchHistory(_searchController.text);
              _searchController.clear();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const  SizedBox(height: 30),
            const Text("Lịch sử tìm kiếm", style: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.bold),),
            SizedBox(height: 10),
            Wrap(
              spacing: 10.0,
              children: List.generate(
                searchHistory.length > 5 ? 5 : searchHistory.length,
                (index) => Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ElevatedButton(
                    onPressed: () {
                      _searchController.text = searchHistory[index];
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey[200],
                      side: BorderSide(color: Colors.black),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text(
                      searchHistory[index],
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ),
                ),
              ),
            ),
            Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height:15),
                const Text("Ưu đãi đặc biệt", style: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.bold),),
                SizedBox(height: 10),
                Container(
                  height: 500,
                  child: ListView.builder(
                    itemCount: specialOffers.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black), 
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        margin: EdgeInsets.only( right: 10, bottom: 5),
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 2 - 30,
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.grey[200],
                              ),
                              child: Image.asset(specialOffers[index]['image'], fit: BoxFit.fill,),
                            ),
                            SizedBox(width: 8),
                            Container(
                              width: MediaQuery.of(context).size.width / 2 - 30,
                              height: 150,
                              child: Text(
                                  specialOffers[index]['text'],
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                  style: TextStyle(color: Colors.black, fontSize: 25, ),       
                                ),
                            )
                           
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
              ],
              
            ),
         

      ),
    );
  }

  void updateSearchHistory(String searchText) {
    setState(() {
      if (searchText.isNotEmpty && !searchHistory.contains(searchText)) {
        searchHistory.insert(0, searchText);
        if (searchHistory.length > 5) {
          searchHistory.removeLast();
        }
        saveSearchHistory();
      }
    });
  }

  void saveSearchHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('searchHistory', searchHistory);
  }

  void loadSearchHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      searchHistory = prefs.getStringList('searchHistory') ?? [];
    });
  }
}
