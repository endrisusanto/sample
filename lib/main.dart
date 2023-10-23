import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

//stateless
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

//statefull root
class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoginScreen(),
    );
  }
}

//statefull LoginScreen
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //title app
          const Text(
            "Login Dulu Bang",
            style: TextStyle(
              color: Colors.black,
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          //input field email
          const SizedBox(
            height: 44.0,
          ),
          const TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                hintText: "Email",
                prefixIcon: Icon(
                  Icons.mail,
                  color: Colors.grey,
                )),
          ),
          //input field password
          const SizedBox(
            height: 44.0,
          ),
          const TextField(
            obscureText: true,
            decoration: InputDecoration(
                hintText: "Password",
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.grey,
                )),
          ),
          //link lupa password
          const SizedBox(
            height: 20.0,
          ),
          const Text(
            "Lupa password?",
            style: TextStyle(color: Colors.blue),
          ),
          //tombol login
          const SizedBox(
            height: 30.0,
          ),
          Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    50.0), // Atur nilai sesuai kebutuhan Anda
              ),
              child: RawMaterialButton(
                fillColor: Colors.blue,
                onPressed: () {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      15.0), // Sesuaikan nilai ini sesuai kebutuhan Anda
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              )),
        ],
      ),
    );
  }
}
