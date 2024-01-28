import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gerenciador_de_massa/routes/route_paths.dart';

class DrawerNavigation extends StatelessWidget {
  DrawerNavigation({super.key});

  final List<Map<String, dynamic>> menuItens = [
    {
      'label': 'Alunos',
      'action': RoutePaths.StudentsListScreen,
      'icon': Icons.person_2_sharp
    }
  ];

  Widget generateMenuItem(Map<String, dynamic> item, BuildContext context) {
    return ListTile(
      leading: Icon(item['icon']),
      title: Text(item['label']),
      trailing: const Icon(Icons.arrow_right),
      onTap: () {
        Navigator.of(context).pushNamed(item['action']);
      },
    );
  }

  List<Widget> generateMenuList(BuildContext context) {
    return menuItens.map((item) => generateMenuItem(item, context)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: Column(
              children: [
                const Text(
                  'Controle de massa',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
                Text(FirebaseAuth.instance.currentUser?.email ?? '')
              ],
            ),
          ),
          ...generateMenuList(
            context,
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('sair'),
            trailing: const Icon(Icons.arrow_right),
            onTap: () {
              final auth = FirebaseAuth.instance;
              auth.signOut().then((_) {
                Navigator.of(context)
                    .pushReplacementNamed(RoutePaths.SignInScreen);
              });
            },
          )
        ],
      ),
    );
  }
}
