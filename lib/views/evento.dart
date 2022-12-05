import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:integrapracas/models/praca.dart';

class EventoPage extends StatefulWidget {
  const EventoPage({Key? key}) : super(key: key);

  @override
  _EventoPageState createState() => _EventoPageState();
}

class _EventoPageState extends State<EventoPage> {
  DateTime? date;

  String getText() {
    if (date == null) {
      return "Selecione a data";
    } else {
      return '${date!.day}/${date!.month}/${date!.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    var db = FirebaseFirestore.instance;
    var descricaoEvento = new TextEditingController();
    var dataEvento = new TextEditingController();
    var tituloEvento = new TextEditingController();
    var dadosPraca = ModalRoute.of(context)!.settings.arguments as Praca;

    Future _selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101),
        //locale: Locale('pt','BR')
      );

      if (picked == null) return;

      setState(() => date = picked);
    }

    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Evento',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          leading: BackButton(),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(children: [
            Container(
              padding: EdgeInsets.all(50),
              child: Column(
                children: [
                  Container(
                      alignment: Alignment.centerLeft,
                      child: Text('Data do evento:')),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.008,
                  ),
                  TextFormField(
                    onTap: () {
                      _selectDate(context);
                    },
                    controller: dataEvento,
                    readOnly: true,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      hintText: getText(),
                      filled: true,
                      focusColor: Color(0XFF7A9337),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0XFFBBCC8F), width: 2.0)),
                      suffixIcon: Icon(
                        Icons.calendar_today_outlined,
                        color: Color(0XFF7A9337),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      child: Text('Título do evento:')),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.008,
                  ),
                  TextFormField(
                      controller: tituloEvento,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          focusColor: Color(0XFF7A9337),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0XFFBBCC8F),
                                  width: 2.0,
                                  style: BorderStyle.solid)))),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      child: Text('Descrição do Evento:')),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.008,
                  ),
                  TextFormField(
                      controller: descricaoEvento,
                      maxLines: 5,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          focusColor: Color(0XFF7A9337),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0XFFBBCC8F), width: 2.0)))),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                  ),
                  ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(padding: EdgeInsets.all(30)),
                      child: const Text('Adicionar Comentário'),
                      onPressed: () {
                        db.collection('eventos').add({
                          'usuario': user!.displayName,
                          'userid': user.uid,
                          'categoria': 'Evento',
                          'texto': descricaoEvento.text,
                          'praca': dadosPraca.id,
                          'timestamp': Timestamp.now(),
                          'nomePraca': dadosPraca.nome,
                          'dataEvento': date,
                          'tituloEvento': tituloEvento.text
                        });
                        Navigator.of(context)
                            .pushNamed('/comments', arguments: dadosPraca);
                      }),
                ],
              ),
            )
          ]),
        )));
  }
}
