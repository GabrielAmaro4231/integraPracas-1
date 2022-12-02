import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CardComentario extends StatelessWidget {
  const CardComentario({
    Key? key,
    required this.doc,
    required this.categoria,
  }) : super(key: key);

  final QueryDocumentSnapshot<Object?> doc;
  final categoria;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 20),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(doc['usuario'],
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Container(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            decoration: BoxDecoration(
                                borderRadius: new BorderRadius.all(
                                    Radius.elliptical(50, 50)),
                                color: Colors.greenAccent),
                            child: Text(categoria))
                      ],
                    ),
                    SizedBox(height: 15),
                    Container(child: Text(doc['comentario'])),
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
