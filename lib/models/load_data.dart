import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';

// CollectionReference collectionRef = FirebaseFirestore.instance.collection('orders');

// // Lấy tất cả các tài liệu trong collection "orders"
// collectionRef.get().then((QuerySnapshot querySnapshot) {
//   if (querySnapshot.size > 0) {
//     // Lặp qua từng tài liệu và lấy thông tin về "productName" và "price"
//     querySnapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
//       // Lấy giá trị của "productName" và "price"
//       String productName = documentSnapshot.data()['productName'];
//       int price = documentSnapshot.data()['price'];

//       // Sử dụng dữ liệu
//       print('Product Name: $productName');
//       print('Price: $price');
//     });
//   } else {
//     print('No documents found');
//   }
// }).catchError((error) {
//   print('Error getting documents: $error');
// });

class Category {
  String id;
  String name;
  String description;

  Category({
    required this.id,
    required this.name,
    required this.description,
  });

  factory Category.fromJson(String id, Map<dynamic, dynamic> json) {
    return Category(
      id: json['id'].toString(),
      name: json['name'] ?? "",
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

    List<Category> categories = []; //_
    if (value != null) {
      value.forEach((key, value) {
        categories.add(Category.fromJson(key, value));
      });
    }
    return categories;
  }

  static Future<List<Product>> getProductsByCategory(String categoryId) async {
    DatabaseReference productsReference =
        FirebaseDatabase.instance.ref().child('products');
    DatabaseEvent event = await productsReference.once();
    DataSnapshot dataSnapshot = event.snapshot;
    Map<dynamic, dynamic>? values =
        dataSnapshot.value as Map<dynamic, dynamic>?;

    List<Product> productsByCategory = [];
    if (values != null) {
      values.forEach((key, value) {
        Product products = Product.fromJson(key, value);
        if (products.category == categoryId) {
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
  int valueScuggestedProduts;
  int valueSaleProducts;
  Product(
      {required this.id,
      required this.category,
      required this.name,
      required this.description,
      required this.idproduct,
      required this.image,
      required this.price,
      required this.producer,
      required this.quantity,
      required this.promotion,
      required this.valueSaleProducts,
      required this.valueScuggestedProduts});

  factory Product.fromJson(String id, Map<dynamic, dynamic> json) {
    return Product(
        id: id,
        idproduct: json['idproduct'] ?? "",
        name: json['name'] ?? "",
        category: json['categoryId'] ?? "",
        description: json['description'] ?? "",
        image: json['image'] ?? "",
        price: json['price'] ?? 0,
        promotion: json['promotion'] ?? 0,
        producer: json['producer'] ?? "",
        quantity: json['quantity'] ?? 0,
        valueSaleProducts: json['sale'] ?? 0,
        valueScuggestedProduts: json['suggest'] ?? 0);
  }
  static getProductReference() {
    return FirebaseDatabase.instance.ref().child('products');
  }

  static Future<void> deleteProduct(String idPro) async {
    DatabaseReference productRef =
        FirebaseDatabase.instance.reference().child('products').child(idPro);
    await productRef.remove();
  }

  static Future<List<Product>> fetchProducts() async {
    DatabaseReference productsReference = getProductReference();
    DatabaseEvent event = await productsReference.once();
    DataSnapshot dataSnapshot = event.snapshot;
    Map<dynamic, dynamic>? values =
        dataSnapshot.value as Map<dynamic, dynamic>?;

    List<Product> products = [];
    if (values != null) {
      values.forEach((key, value) {
        products.add(Product.fromJson(key, value));
      });
    }
    return products;
  }

  @override
  String toString() {
    return 'Product{id: $id, name: $name, price: $price, promotion: $promotion}';
  }
}

class Order {
  String orderId;
  String address;
  String name;
  String phone;
  String productMoney;
  String status;
  List<OrderProduct> products;

  Order({
    required this.orderId,
    required this.address,
    required this.name,
    required this.phone,
    required this.productMoney,
    required this.status,
    required this.products,
  });

  factory Order.fromJson(String orderId, Map<dynamic, dynamic> json) {
    List<OrderProduct> products = [];
    if (json['products'] != null) {
      json['products'].forEach((product) {
        products.add(OrderProduct.fromJson(product));
      });
    }

    return Order(
      orderId: orderId,
      address: json['address'] ?? "",
      name: json['name'] ?? "",
      phone: json['phone'] ?? "",
      productMoney: json['productmoney'] ?? "",
      status: json['status'] ?? "",
      products: products,
    );
  }

  @override
  String toString() {
    return 'Order{orderId: $orderId, address: $address, name: $name, phone: $phone, productMoney: $productMoney, status: $status, products: $products}';
  }
}

class OrderProduct {
  int price;
  String productName;
  int quantity;

  OrderProduct({
    required this.price,
    required this.productName,
    required this.quantity,
  });

  factory OrderProduct.fromJson(Map<dynamic, dynamic> json) {
    return OrderProduct(
      price: json['price'] ?? 0,
      productName: json['productName'] ?? "",
      quantity: json['quantity'] ?? 0,
    );
  }

  @override
  String toString() {
    return 'OrderProduct{price: $price, productName: $productName, quantity: $quantity}';
  }
}

class FirebaseHelper {
  static DatabaseReference getOrderReference() {
    return FirebaseDatabase.instance.reference().child('orders');
  }

  static Future<List<Order>> fetchOrders() async {
    DatabaseReference ordersReference = getOrderReference();
    DataSnapshot dataSnapshot = (await ordersReference.once()) as DataSnapshot;

    List<Order> orders = [];
    Map<dynamic, dynamic>? values =
        dataSnapshot.value as Map<dynamic, dynamic>?;
    if (values != null) {
      values.forEach((key, value) {
        orders.add(Order.fromJson(key, value));
      });
    }

    return orders;
  }
}

class ProductSale {
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
  ProductSale(
      {required this.id,
      required this.category,
      required this.name,
      required this.description,
      required this.idproduct,
      required this.image,
      required this.price,
      required this.producer,
      required this.quantity,
      required this.promotion});

  factory ProductSale.fromJson(String id, Map<dynamic, dynamic> json) {
    return ProductSale(
        id: id,
        idproduct: json['idproduct'] ?? "",
        name: json['name'] ?? "",
        category: json['categoryId'] ?? "",
        description: json['description'] ?? "",
        image: json['image'] ?? "",
        price: json['price'] ?? 0,
        promotion: json['promotion'] ?? 0,
        producer: json['producer'] ?? "",
        quantity: json['quantity'] ?? 0);
  }
  static getProductSaleReference() {
    return FirebaseDatabase.instance.ref().child('productsales');
  }

  static Future<List<ProductSale>> fetchProductSales() async {
    DatabaseReference productsaleReference = getProductSaleReference();
    DatabaseEvent event = await productsaleReference.once();
    DataSnapshot dataSnapshot = event.snapshot;
    Map<dynamic, dynamic>? values =
        dataSnapshot.value as Map<dynamic, dynamic>?;

    List<ProductSale> productsales = [];
    if (values != null) {
      values.forEach((key, value) {
        productsales.add(ProductSale.fromJson(key, value));
      });
    }
    return productsales;
  }
}

class ProductSuggest {
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
  ProductSuggest(
      {required this.id,
      required this.category,
      required this.name,
      required this.description,
      required this.idproduct,
      required this.image,
      required this.price,
      required this.producer,
      required this.quantity,
      required this.promotion});

  factory ProductSuggest.fromJson(String id, Map<dynamic, dynamic> json) {
    return ProductSuggest(
        id: id,
        idproduct: json['idproduct'] ?? "",
        name: json['name'] ?? "",
        category: json['categoryId'] ?? "",
        description: json['description'] ?? "",
        image: json['image'] ?? "",
        price: json['price'] ?? 0,
        promotion: json['promotion'] ?? 0,
        producer: json['producer'] ?? "",
        quantity: json['quantity'] ?? 0);
  }

  static getProductSuggestReference() {
    return FirebaseDatabase.instance.ref().child('productsuggests');
  }

  static Future<List<ProductSuggest>> fetchProductSuggests() async {
    DatabaseReference ProductSuggestReference = getProductSuggestReference();
    DatabaseEvent event = await ProductSuggestReference.once();
    DataSnapshot dataSnapshot = event.snapshot;
    Map<dynamic, dynamic>? values =
        dataSnapshot.value as Map<dynamic, dynamic>?;

    List<ProductSuggest> productsuggests = [];
    if (values != null) {
      values.forEach((key, value) {
        productsuggests.add(ProductSuggest.fromJson(key, value));
      });
    }
    return productsuggests;
  }
}

class ProductSell {
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
  ProductSell(
      {required this.id,
      required this.category,
      required this.name,
      required this.description,
      required this.idproduct,
      required this.image,
      required this.price,
      required this.producer,
      required this.quantity,
      required this.promotion});

  factory ProductSell.fromJson(String id, Map<dynamic, dynamic> json) {
    return ProductSell(
        id: id,
        idproduct: json['idproduct'] ?? "",
        name: json['name'] ?? "",
        category: json['categoryId'] ?? "",
        description: json['description'] ?? "",
        image: json['image'] ?? "",
        price: json['price'] ?? 0,
        promotion: json['promotion'] ?? 0,
        producer: json['producer'] ?? "",
        quantity: json['quantity'] ?? 0);
  }

  static getProductSellReference() {
    return FirebaseDatabase.instance.ref().child('productsell');
  }

  static Future<List<ProductSell>> fetchProductSell() async {
    DatabaseReference ProductSellReference = getProductSellReference();
    DatabaseEvent event = await ProductSellReference.once();
    DataSnapshot dataSnapshot = event.snapshot;
    Map<dynamic, dynamic>? values =
        dataSnapshot.value as Map<dynamic, dynamic>?;

    List<ProductSell> productsell = [];
    if (values != null) {
      values.forEach((key, value) {
        productsell.add(ProductSell.fromJson(key, value));
      });
    }
    return productsell;
  }

  static Future<List<ProductSell>> getProductsell(String categoryId) async {
    DatabaseReference productsellReference =
        FirebaseDatabase.instance.ref().child('productsell');
    DatabaseEvent event = await productsellReference.once();
    DataSnapshot dataSnapshot = event.snapshot;
    Map<dynamic, dynamic>? values =
        dataSnapshot.value as Map<dynamic, dynamic>?;

    List<ProductSell> productsell = [];
    if (values != null) {
      values.forEach((key, value) {
        ProductSell products = ProductSell.fromJson(key, value);
        if (products.category == categoryId) {
          productsell.add(products);
        }
      });
    }
    return productsell;
  }
}

class User {
  String username;
  String image;
  String email;
  String phone;
  String id;
  String address;
  String typeaccount;
  bool status;
  String iduser;

  User(
      {required this.id,
      required this.iduser,
      required this.username,
      required this.phone,
      required this.image,
      required this.email,
      required this.address,
      required this.status,
      required this.typeaccount});

  factory User.fromJson(String id, Map<dynamic, dynamic> json) {
    return User(
        id: id,
        iduser: json['iduser'] ?? "",
        username: json['name'] ?? "",
        email: json['email'] ?? "",
        phone: json['phone'] ?? "",
        image: json['image'] ?? "",
        address: json['address'] ?? "",
        status: json['status'] ?? false,
        typeaccount: json['typeaccount'] ?? "");
  }

  static DatabaseReference getUserReference() {
    return FirebaseDatabase.instance.ref().child('users');
  }

  static Future<List<User>> fetchUsers() async {
    DatabaseReference userReference = getUserReference();
    DatabaseEvent event = await userReference.once();
    DataSnapshot dataSnapshot = event.snapshot;
    Map<dynamic, dynamic>? values =
        dataSnapshot.value as Map<dynamic, dynamic>?;

    List<User> users = [];
    if (values != null) {
      values.forEach((key, value) {
        users.add(User.fromJson(key, value));
      });
    }
    return users;
  }
}
