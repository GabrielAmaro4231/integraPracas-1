import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SideDrawer extends StatelessWidget {
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: Center(
              child: Column(
                children: [
                  Container(
                    child: Text(
                      '${auth.currentUser?.displayName}',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                  Text(
                    '${auth.currentUser?.email}',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: Color(0xFF3D3129),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    ListTile(
                        leading: Icon(Icons.edit),
                        title: Text('Editar Dados'),
                        onTap: () async {
                          Navigator.of(context).pushNamed('/edita');
                        }),
                    ListTile(
                        leading: Icon(Icons.chat_bubble),
                        title: Text('Meus Comentários'),
                        onTap: () {
                          Navigator.of(context).pushNamed('/my-comments');
                        }),
                    ListTile(
                      leading: Icon(Icons.exit_to_app),
                      title: Text('Sair'),
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.of(context).pushNamed('/');
                      },
                    )
                  ],
                ),
                ListTile(
                    leading: Icon(
                      Icons.delete_forever,
                      color: Colors.red.shade400,
                    ),
                    title: Text('Apagar conta',
                        style: TextStyle(color: Colors.red.shade400)),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                                title: Text(
                                    'Tem certeza que deseja apagar a sua conta? Todos os seus dados serão perdidos.',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16)),
                                actions: [
                                  TextButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.white),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        'Não',
                                        style: TextStyle(color: Colors.black),
                                      )),
                                  TextButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.white),
                                      onPressed: () async {
                                        await auth.currentUser!.delete();
                                        Navigator.of(context).pushNamed('/');
                                      },
                                      child: Text('Sim, tenho certeza',
                                          style: TextStyle(
                                              color: Colors.red.shade400)))
                                ],
                              ));
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
