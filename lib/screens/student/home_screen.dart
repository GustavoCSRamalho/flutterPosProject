import 'package:gerenciador_de_massa/components/drawer_navigation.dart';
import 'package:gerenciador_de_massa/routes/route_paths.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget progressIndicator() =>
      const Center(child: CircularProgressIndicator());

  Widget centeredText(String text) => Center(
        child: Text('Error: $text'),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Controle de massa'),
      ),
      body: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text('Bem vindo ao aplicativo de controle de massa!'),
            )
          ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.of(context).pushNamed(RoutePaths.StudentInsertScreen),
        child: const Icon(Icons.add),
      ),
      drawer: DrawerNavigation(),
    );
  }
}
