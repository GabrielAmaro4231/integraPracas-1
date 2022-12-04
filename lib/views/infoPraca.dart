import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:integrapracas/models/praca.dart';
import 'package:integrapracas/views/cardComentario.dart';

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

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '${dadosPraca.nome}',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Image.network(dadosPraca.capa),
          Container(
            padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
            child: SizedBox(
                height: 100,
                width: double.infinity,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: GestureDetector(
                          onTap: () {
                            print("Sugestão de Melhorias!");
                          },
                          child: Container(
                            // color: Colors.purple,
                            child: Icon(
                              Icons.upgrade,
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: GestureDetector(
                          onTap: () {
                            print("Manutenção!");
                          },
                          child: Container(
                            // color: Colors.purple,
                            child: Icon(
                              Icons.construction,
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: GestureDetector(
                          onTap: () {
                            print("Evento!");
                          },
                          child: Container(
                            // color: Colors.purple,
                            child: Icon(
                              Icons.celebration,
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
          Expanded(
            child: Container(
                decoration: BoxDecoration(color: Color(0xFFF5F1E0)),
                // padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: StreamBuilder<QuerySnapshot>(
                    stream: _firestore
                        .collection('eventos')
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .pushNamed('/selecionaCategoria', arguments: dadosPraca);
        },
        backgroundColor: Colors.brown,
        child: const Icon(Icons.add),
      ),
    );
  }
}
