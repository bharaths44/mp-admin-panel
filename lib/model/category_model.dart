import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  final String? docID;
  final String? image;
  final String? name;

  CategoryModel({
    this.image,
    this.name,
     this.docID,
  });

  factory CategoryModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return CategoryModel(
      image: data?['image'],
      name: data?['name'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (image != null) "image": image,
      if (name != null) "name": name,
    };
  }
}
