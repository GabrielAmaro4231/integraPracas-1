import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:integrapracas/models/praca.dart';
import 'package:integrapracas/views/sideDrawer.dart';

class ListaPracas extends StatefulWidget {
  const ListaPracas({Key? key}) : super(key: key);

  @override
  _ListaPracasState createState() => _ListaPracasState();
}

class _ListaPracasState extends State<ListaPracas> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final _firestore = FirebaseFirestore.instance;
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        key: _scaffoldKey,
        drawer: SideDrawer(),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Praças',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.menu,
              size: 35,
            ),
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('pracas').orderBy('nome').snapshots(),
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
                    return Container(
                      height: 184,
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            // border: Border.all(color: Colors.purple),
                            borderRadius: BorderRadius.circular(10)),
                        child: GestureDetector(
                          onTap: () {
                            var nomePraca = doc['nome'];
                            var idPraca = doc.id;
                            var capaPraca = doc['capa'];
                            Navigator.of(context).pushNamed('/comments',
                                arguments: Praca(
                                    id: idPraca,
                                    nome: nomePraca,
                                    capa: capaPraca));
                          },
                          child: Card(
                            elevation: 5,
                            child: Row(
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Container(
                                    width: 150,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      image: DecorationImage(
                                          image: NetworkImage(doc['capa']),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Container(
                                    height: double.infinity,
                                    width: double.infinity,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding:
                                              EdgeInsets.fromLTRB(15, 10, 0, 0),
                                          child: Center(
                                            child: Text(doc['nome'],
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                        ),
                                        Expanded(child: Container()),
                                        Container(
                                          padding: EdgeInsets.fromLTRB(
                                              15, 0, 10, 75),
                                          child: Text(
                                            doc['endereço'],
                                            style: TextStyle(fontSize: 10.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            }));
  }
}

class Pra {
  String id;
  String nome;
  String capa;

  get getId => this.id;

  get getNome => this.nome;

  get getCapa => this.capa;

  Pra(this.id, this.nome, this.capa);
}
