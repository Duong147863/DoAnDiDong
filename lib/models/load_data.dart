
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

class Category {
  String id;
  String name;
  String description;

  Category({required this.id,required this.name,required this.description,});

  factory Category.fromJson(String id,Map<dynamic, dynamic> json) {
    return Category(
      id: json['id'].toString(),
      name:json['name'] ??"",
      description: json['description'] ?? "",
    );
  }
  static DatabaseReference getCategoryReference() {
    return FirebaseDatabase.instance.ref().child('categories');
  }
  static Future<List<Category>> GetCategory() async {
    DatabaseReference roomReference = getCategoryReference();
    DatabaseEvent event = await roomReference.once();
    DataSnapshot dataSnapshot = event.snapshot;
    Map<dynamic, dynamic>? value = dataSnapshot.value as Map<dynamic, dynamic>?;

    List<Category> _categories = [];
    if (value != null) {
      value.forEach((key, value) {
       _categories.add(Category.fromJson(key,value));
      });
    }
    return _categories;
  }
   static Future<List<Product>> getProductsByCategory(String categoryId) async {
    DatabaseReference productsReference = FirebaseDatabase.instance.ref().child('products');
    DatabaseEvent event = await productsReference.once();
    DataSnapshot dataSnapshot = event.snapshot;
    Map<dynamic, dynamic>? values = dataSnapshot.value as Map<dynamic, dynamic>?;

    List<Product> productsByCategory = [];
    if (values != null) {
      values.forEach((key, value) {
        Product products =Product.fromJson(key, value);
        if(products.category == categoryId)
        {
          productsByCategory.add(products);
        }
      });
    }
    return productsByCategory;
  }
}

class Product {
  String id;
  String category;
  String name;
  String description;
  String idproduct;
  String image;
  String producer;
  int price;
  int promotion;
  int quantity;
  bool sell;
  bool suggest;
  Product({
   required this.id,required this.category,required this.name,required this.description,required this.idproduct,
   required this.image,required this.price,required this.producer,required this.quantity, required this.promotion, required this.sell, required this.suggest
  });

  factory Product.fromJson(String id, Map<dynamic, dynamic> json) {
    return Product(
      id: id,
      idproduct: json['idproduct'] ?? "",
      name: json['name'] ?? "",
      category: json['categoryId'] ?? "",
      description: json['description'] ??"",
      image: json['image']??"",
      price: json['price']?? 0,
      promotion: json['promotion']?? 0,
      producer: json['producer']??"",
      quantity: json['quantity']?? 0 ,
      sell:json['sell']?? false,
      suggest: json['suggets']?? false,
    );
  }
  static  getProductReference() {
    return FirebaseDatabase.instance.ref().child('products');
  }
  static Future<void> deleteProduct(String idPro) async {
    DatabaseReference productRef =
        FirebaseDatabase.instance.ref().child('products').child(idPro);
    await productRef.remove();
  }

  static Future<List<Product>> fetchProductSuggests() async {
  try {
    Query productsReference = getProductReference().orderByChild('suggets').equalTo(true);
    DatabaseEvent event =await productsReference.once();
    DataSnapshot dataSnapshot = event.snapshot;
    Map<dynamic, dynamic>? values = dataSnapshot.value as Map<dynamic, dynamic>?;

    List<Product> productSellList = [];

    if (values != null) {
      values.forEach((idproduct, productData) {
        Product product = Product.fromJson(idproduct, productData);
        productSellList.add(product);
      });
    }

    return productSellList;
  } catch (e) {
    print("Error fetching products for selling: $e");
    return [];
  }
}

  static Future<List<Product>> fetchProducts() async {
    DatabaseReference productsReference = getProductReference();
    DatabaseEvent event = await  productsReference.once();
    DataSnapshot dataSnapshot = event.snapshot;
    Map<dynamic, dynamic>? values = dataSnapshot.value as Map<dynamic, dynamic>?;

    List<Product> products = [];
    if (values != null) {
      values.forEach((key, value) {
        products.add(Product.fromJson(key, value));
      });
    }
    return products;
  }
  static Future<List<Product>> fecthProductSell(String categoriesId) async {
  try {
    Query _productSell = await getProductReference().orderByChild('sell').equalTo(true);
    DatabaseEvent event = await _productSell.once();
    DataSnapshot dataSnapshot = event.snapshot;
     Map<dynamic, dynamic>? values = dataSnapshot.value as Map<dynamic, dynamic>?;
    List<Product> productSellList = [];
  
  if(values!=null)
  {
    values.forEach((key, value) {
          Product product = Product.fromJson(key, value);
          if (product.category == categoriesId) {
            productSellList.add(product);
          }
        });
  }
  return productSellList;
  } catch (e) {
    print("Error loading suggested products: $e");
    return [];
  }
}
static Future<List<Product>> fetchProductsWithPromotion() async {
  try {
   Query productsReference = getProductReference().orderByChild('promotion').startAt(1);
    DatabaseEvent event= await productsReference.once();
    DataSnapshot dataSnapshot = event.snapshot;
    Map<dynamic, dynamic>? values = dataSnapshot.value as Map<dynamic, dynamic>?;

    List<Product> productsWithPromotionList = [];

    if (values != null) {
      values.forEach((idproduct, productData) {
        int promotion = productData['promotion'] ?? 0;

        // Lọc sản phẩm có giảm giá (promotion > 0)
        if (promotion > 0) {
          Product product = Product.fromJson(idproduct, productData);
          productsWithPromotionList.add(product);
        }
      });
    }

    return productsWithPromotionList;
  } catch (e) {
    print("Error fetching products with promotion: $e");
    return [];
  }
}
  @override
  String toString() {
    return 'Product{id: $id, name: $name, price: $price, promotion: $promotion}';
  }
}

class Users {
  String name;
  String email;
  String phone;
  String address;
  bool typeaccount;
  bool status;
  String image;


  Users({
    required this.name,
    required this.email,
    required this.phone,
    required this.typeaccount,
    required this.status,
    required this.address,
    required this.image,
  });

  factory Users.fromSnapshot(DataSnapshot snapshot) {
    Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
    return Users(
      name: data['displayName'] ?? "",
      email: data['email'] ?? "",
      phone: data['phoneNumber'] ?? "",
      address: data['address'] ?? "",
      typeaccount: data['persission'] ?? false,
      status: data['status'] ?? true,
      image: data['image'] ??"",

    );
  }
   Future<void> updateInformation(String newUsername, String newPhone, String newAddress,String id) async {
    DatabaseReference userReference = FirebaseDatabase.instance.ref().child('users').child(id);
    await userReference.update({
      'displayName': newUsername,
      'phoneNumber': newPhone,
      'address': newAddress,
    });
    
  }

  

  static Future<Users> fetchUser(String userId) async {
    DatabaseReference reference = FirebaseDatabase.instance.ref().child("users").child(userId);
    DatabaseEvent event = await reference.once() ;
    DataSnapshot snapshot= event.snapshot;
    

    if (snapshot.value != null) {
      return Users.fromSnapshot(snapshot);
    } else {
      throw Exception("User not found");
    }
  }
}
class Cart {
  final String CartId;
  final String productName;
  final int price;
  final int quantity;
  final String image;
  final int promotion;
  final String userId;
  final String idproduct;
  bool isSelected= false;
  

  Cart({required this.CartId, required this.image, required this.productName, required this.price, 
  required this.quantity, required this.promotion,required this.userId, required this.isSelected, required this.idproduct});
  
  factory Cart.fromJson(String id, Map<dynamic, dynamic> json) {
    return Cart(
      CartId: id,
      productName: json['productname'] ?? "",
      image: json['image']??"",
      price: json['price']?? 0,
      promotion: json['promotion']?? 0,
      quantity: json['quantity']?? 0 ,
      userId: json['userId']??"",
      isSelected: false,
      idproduct: json['idproduct']??""
    );
  }
 

  static DatabaseReference getCartReference() {
    return FirebaseDatabase.instance.ref().child('carts');
  }

 static Future<List<Cart>> fetchCart(String userId) async {
    DatabaseReference cartReference = getCartReference();

    // Sử dụng orderByChild để lọc theo userId
    Query query = cartReference.orderByChild('userId').equalTo(userId);
    
    DataSnapshot dataSnapshot = (await query.once()).snapshot;
    Map<dynamic, dynamic>? values = dataSnapshot.value as Map<dynamic, dynamic>?;

    List<Cart> carts = [];
    if (values != null) {
      values.forEach((key, value) {
        carts.add(Cart.fromJson(key, value));
      });
    }
    return carts;
  }
}
class Purchased {
  String name;
  String price;

  Purchased({
    required this.price,
    required this.name,
  });

  factory Purchased.fromJson(String id, Map<dynamic, dynamic> json) {
    return Purchased(
      name: json['productName'] ?? "",
      price: json['price'] ?? "",
    );
  }
  static DatabaseReference getPrReference() {
    return FirebaseDatabase.instance.ref().child('orders').child('products');
  }

//   static Future<List<PurchasedProduct>> fetchProducts() async {
//   DatabaseReference productsReference = PurchasedProduct.getCategoryReference();
//   DatabaseEvent event = await productsReference.once();
//   DataSnapshot dataSnapshot = event.snapshot;
//   Map<dynamic, dynamic>? values = dataSnapshot.value as Map<dynamic, dynamic>?;

//   List<PurchasedProduct> products = [];
//   if (values != null) {
//     values.forEach((key, value) {
//       products.add(PurchasedProduct.fromJson(key, value));
//     });
//   }
//   return products;
// }

  static Future<List<Purchased>> getP() async {
    DatabaseReference roomReference = getPrReference();
    DatabaseEvent event = await roomReference.once();
    DataSnapshot dataSnapshot = event.snapshot;
    Map<dynamic, dynamic>? value = dataSnapshot.value as Map<dynamic, dynamic>?;

    List<Purchased> purchasedProducts = []; //_
    if (value != null) {
      value.forEach((key, value) {
        purchasedProducts.add(Purchased.fromJson(key, value));
      });
    }
    return purchasedProducts;
  }
}
class NotificationData {
  
  final String userId;
  final String title;
  final String description;
  final DateTime time;
  final String AdminId;

  NotificationData({
    required this.userId,
    required this.title,
    required this.description,
    required this.time,
    required this.AdminId
  });

  factory NotificationData.fromJson(String id, Map<dynamic, dynamic> json) {
  return NotificationData(
    userId: json['userId'],
    time: json['time'] != null
        ? DateTime.fromMillisecondsSinceEpoch(json['time'])
        : DateTime.now(),
    title: json['title'],
    description: json['description'],
    AdminId: json['AdminId'],
  );
}


  static DatabaseReference getNotiReference() {
    return FirebaseDatabase.instance.ref().child('notifications');
  }

 static Future<List<NotificationData>> fetchNotifications(String adminId) async {
    DatabaseReference notiReference = getNotiReference();

    // Sử dụng orderByChild để lọc theo userId
    Query query = notiReference.orderByChild('AdminId').equalTo(adminId);
    
    DataSnapshot dataSnapshot = (await query.once()).snapshot;
    Map<dynamic, dynamic>? values = dataSnapshot.value as Map<dynamic, dynamic>?;

    List<NotificationData> notifications = [];
    if (values != null) {
      values.forEach((key, value) {
        notifications.add(NotificationData.fromJson(key, value));
      });
    }
    return notifications;
  }
  static Future<void> deleteNotifications(String adminId) async {
  DatabaseReference notiReference = getNotiReference();

  // Sử dụng orderByChild để lọc theo userId
  Query query = notiReference.orderByChild('AdminId').equalTo(adminId);

  DataSnapshot dataSnapshot = (await query.once()).snapshot;
  Map<dynamic, dynamic>? values = dataSnapshot.value as Map<dynamic, dynamic>?;

  if (values != null) {
    values.forEach((key, value) async {
      await notiReference.child(key).remove();
    });
  }
}
}
class OrderDetails {
  final String OrderId;
  final List<Cart> products; // Thêm danh sách sản phẩm
  final String name;
  final String phone;
  final String address;
  final String typePayment;
  final String productmoney;
  final String deliverycharges;
  final String totalPayment;
  final String status;

  OrderDetails({
    required this.OrderId,
    required this.products,
    required this.name,
    required this.phone,
    required this.address,
    required this.typePayment,
    required this.productmoney,
    required this.deliverycharges,
    required this.totalPayment,
    required this.status,
  });
}
class Order {
  final String orderId;
  final String address;
  final String name;
  final String phone;
  final String productMoney;
  final List<Product> products;
  final String status;

  Order({
    required this.orderId,
    required this.address,
    required this.name,
    required this.phone,
    required this.productMoney,
    required this.products,
    required this.status,
  });

  factory Order.fromJson(String orderId, Map<dynamic, dynamic> json) {
    List<Product> products = [];

    if (json['products'] != null) {
      List<dynamic> producValues = json['products'];

      producValues.forEach((productKey, productValue) {
        Product product = Product.fromJson(productKey, productValue);
        products.add(product);
      } as void Function(dynamic element));
    }

    return Order(
      orderId: orderId,
      address: json['address'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      productMoney: json['productMoney'] ?? '',
      products: products,
      status: json['status'] ?? '',
    );
  }

  static DatabaseReference getOrderReference() {
    return FirebaseDatabase.instance.reference().child('orders');
  }

  static Future<List<Order>> fetchOrders() async {
    DatabaseReference ordersReference = getOrderReference();
    DatabaseEvent event = await ordersReference.once();
    DataSnapshot dataSnapshot = event.snapshot;
    Map<dynamic, dynamic>? values =
        dataSnapshot.value as Map<dynamic, dynamic>?;

    List<Order> orders = [];
    if (values != null) {
      values.forEach((key, value) {
        if (value is Map<dynamic, dynamic> && !value.containsKey('products')) {
          orders.add(Order.fromJson(key, value));
        }
      });
    }
    return orders;
  }

  @override
  String toString() {
    return 'Order{name: $name, customerId: $orderId, status: $status, total: $productMoney}';
  }
}