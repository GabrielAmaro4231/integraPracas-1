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
    return Container(
      padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.shade600,
                    width: 1,
                  ),
                ),
                padding: EdgeInsets.fromLTRB(20, 10, 20, 40),
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
                      Container(child: Text(doc['texto'])),
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
