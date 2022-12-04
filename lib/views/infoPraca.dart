import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:integrapracas/models/praca.dart';
import 'package:integrapracas/views/pageEvento.dart';
import 'package:integrapracas/views/pageManutencao.dart';
import 'package:integrapracas/views/pageMelhorias.dart';

class InfoPracaView extends StatefulWidget {
  const InfoPracaView({Key? key}) : super(key: key);

  @override
  _InfoPracaViewState createState() => _InfoPracaViewState();
}

class _InfoPracaViewState extends State<InfoPracaView> {
  @override
  Widget build(BuildContext context) {
    final _firestore = FirebaseFirestore.instance;
    var dadosPraca = ModalRoute.of(context)!.settings.arguments as Praca;

    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            '${dadosPraca.nome}',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.keyboard_double_arrow_up),
              ),
              Tab(
                icon: Icon(Icons.construction),
              ),
              Tab(
                icon: Icon(Icons.celebration),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Center(
              child:
                  PageMelhorias(dadosPraca: dadosPraca, firestore: _firestore),
            ),
            Center(
              child:
                  PageManutencao(dadosPraca: dadosPraca, firestore: _firestore),
            ),
            Center(
              child: PageEvento(dadosPraca: dadosPraca, firestore: _firestore),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .pushNamed('/selecionaCategoria', arguments: dadosPraca);
          },
          backgroundColor: Colors.brown,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
