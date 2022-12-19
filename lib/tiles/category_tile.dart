import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dlabella_modas/screens/category_screen.dart';
import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile(this.snapshot, {super.key});

  final DocumentSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(snapshot.get('icon')),
      ),
      title: Text(
        snapshot.get('title'),
        style: TextStyle(color: Colors.pink.shade700),
      ),
      trailing: Icon(Icons.keyboard_arrow_right, color: Colors.pink.shade700,),
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => CategoryScreen(snapshot))
        );
      },
    );
  }
}