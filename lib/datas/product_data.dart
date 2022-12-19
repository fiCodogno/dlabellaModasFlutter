import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {
  late String category;
  late String title;
  late String id;
  late String description;
  late double price;
  late List images;
  late List sizes;

  ProductData.fromDocument(DocumentSnapshot snapshot){
    id = snapshot.id;
    title = snapshot.get('title');
    description = snapshot.get('description');
    price = snapshot.get('price') + 0.0;
    sizes = snapshot.get('sizes');
    images = snapshot.get('images');
  }

  Map<String, dynamic> toResumedMap(){
    return {
      "title" : title,
      "description" : description,
      "price" : price
    };
  }
}