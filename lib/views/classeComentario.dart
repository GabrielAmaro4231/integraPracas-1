import 'package:flutter/material.dart';
import 'package:integrapracas/models/praca.dart';

class ClasseComentario extends StatelessWidget {
  const ClasseComentario({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dadosPraca = ModalRoute.of(context)!.settings.arguments as Praca;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Selecione a categoria",
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      backgroundColor: Color(0xFFF5F1E0),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 3,
                    fixedSize: Size(MediaQuery.of(context).size.width * 0.7,
                        MediaQuery.of(context).size.height * 0.15)),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed('/add-evento', arguments: dadosPraca);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('EVENTO',
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.08,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 3,
                    fixedSize: Size(MediaQuery.of(context).size.width * 0.7,
                        MediaQuery.of(context).size.height * 0.15)),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed('/add-manutencao', arguments: dadosPraca);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("MANUTENÇÃO",
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.08,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 3,
                  fixedSize: Size(MediaQuery.of(context).size.width * 0.7,
                      MediaQuery.of(context).size.height * 0.15),
                ),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed('/add-melhoria', arguments: dadosPraca);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('SUGESTÃO DE MELHORIA',
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
