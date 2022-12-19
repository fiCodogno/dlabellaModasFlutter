import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceTile extends StatelessWidget {
  const PlaceTile(this.snapshot, {super.key});

  final DocumentSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 100,
            child: Image.network(
              snapshot.get("image"),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  snapshot.get("title"),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                  textAlign: TextAlign.start,
                ),
                Text(
                  snapshot.get("address"),
                  style: const TextStyle(
                      fontWeight: FontWeight.w400, fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {
                    launchUrl(Uri.parse(
                        "https://www.google.com/maps/search/?api=1&query=${snapshot.get("lat")},${snapshot.get("long")}"));
                  },
                  style: const ButtonStyle(
                    overlayColor: MaterialStatePropertyAll(
                        Color.fromARGB(52, 194, 24, 92)),
                    padding: MaterialStatePropertyAll(EdgeInsets.zero),
                  ),
                  child: Text(
                    "Ver no Mapa",
                    style: TextStyle(
                        color: Colors.pink.shade700,
                        fontWeight: FontWeight.bold),
                  )),
              const SizedBox(
                width: 10,
              ),
              TextButton(
                  onPressed: () {
                    launchUrl(Uri.parse("tel:${snapshot.get("phone")}"));
                  },
                  style: const ButtonStyle(
                    overlayColor: MaterialStatePropertyAll(
                        Color.fromARGB(52, 194, 24, 92)),
                    padding: MaterialStatePropertyAll(EdgeInsets.zero),
                  ),
                  child: Text(
                    "Ligar",
                    style: TextStyle(
                        color: Colors.pink.shade700,
                        fontWeight: FontWeight.bold),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
