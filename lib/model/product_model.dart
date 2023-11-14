import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String? docID;
  final String? category;
  final String? image;
  final String? name;

  final int? price;
  final int? stock;

  ProductModel(
      {this.docID,
      this.category,
      this.image,
      this.name,
      this.price,
      this.stock});

  factory ProductModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return ProductModel(
        docID: snapshot.id,
        category: data?['category'],
        image: data?['image'],
        name: data?['name'],
        price: data?['price'],
        stock: data?['stock']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (category != null) "category": category,
      if (image != null) "image": image,
      if (name != null) "name": name,
      if (price != null) "price": price,
      if (stock != null) "stock": stock,
    };
  }
}
