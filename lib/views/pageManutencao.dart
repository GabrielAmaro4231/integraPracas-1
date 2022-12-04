import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:integrapracas/models/praca.dart';
import 'package:integrapracas/views/cardComentario.dart';

class PageManutencao extends StatelessWidget {
  const PageManutencao({
    Key? key,
    required this.dadosPraca,
    required FirebaseFirestore firestore,
  })  : _firestore = firestore,
        super(key: key);

  final Praca dadosPraca;
  final FirebaseFirestore _firestore;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(dadosPraca.capa),
        Expanded(
          child: Container(
              decoration: BoxDecoration(color: Color(0xFFF5F1E0)),
              // padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: StreamBuilder<QuerySnapshot>(
                  stream: _firestore
                      .collection('manutencao')
                      .where('praca', isEqualTo: dadosPraca.id)
                      .snapshots(),
                  builder: (_, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                          heightFactor: double.infinity,
                          widthFactor: double.infinity,
                          child: CircularProgressIndicator());
                    }
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (_, index) {
                          var doc = snapshot.data!.docs[index];
                          var categoria = doc['categoria'];
                          return CardComentario(
                            doc: doc,
                            categoria: categoria,
                          );
                        });
                  })),
        )
      ],
    );
  }
}
