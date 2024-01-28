import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  void showSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      duration: const Duration(seconds: 2),
    ));
  }

  Future<bool> _register() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    setState(() {
      _isLoading = true;
    });
    try {
      final signUp = _auth.createUserWithEmailAndPassword;
      UserCredential userCredential =
          await signUp(email: email, password: password);
      User? user = userCredential.user;
      showSnackBar('Cadastro realizado com sucesso!');
      return true;
    } catch (e) {
      showSnackBar('Erro ao realizar cadastro.');
    }
    setState(() {
      _isLoading = false;
    });
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(
              height: 16.0,
            ),
            _isLoading
                ? const CircularProgressIndicator()
                : SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: const Text('Cadstrar'),
                      onPressed: () {
                        _register().then((isCreated) {
                          if (isCreated) {
                            Navigator.of(context).pop();
                          }
                        });
                      },
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
