import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gerenciador_de_massa/routes/route_paths.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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

  Future<bool> _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    bool isAuth = false;
    setState(() {
      _isLoading = true;
    });
    try {
      final signIn = _auth.signInWithEmailAndPassword;
      UserCredential userCredential =
          await signIn(email: email, password: password);
      User? user = userCredential.user;
      showSnackBar('Usuario logado: ${user?.email}');
      isAuth = true;
    } catch (e) {
      showSnackBar('Erro ao fazer login: $e');
    }
    setState(() {
      _isLoading = false;
    });
    return isAuth;
  }

  Future<bool> _signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      final googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
      await _auth.signInWithCredential(credential);
      showSnackBar('Usuario logado!');
      return true;
    } catch (e) {
      showSnackBar('Erro ao fazer login: $e');
    }
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
                      child: const Text('login'),
                      onPressed: () {
                        _login().then((isAuth) {
                          if (isAuth) {
                            Navigator.of(context)
                                .pushReplacementNamed(RoutePaths.HomeScreen);
                          }
                        });
                      },
                    ),
                  ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(RoutePaths.SignUpScreen);
              },
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: const Text(
                  'Cadastrar-se',
                  style: TextStyle(
                      color: Colors.blue, decoration: TextDecoration.underline),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: const Text('Gmail'),
                onPressed: () {
                  _signInWithGoogle().then((isAuth) {
                    if (isAuth)
                      Navigator.of(context)
                          .pushReplacementNamed(RoutePaths.HomeScreen);
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
