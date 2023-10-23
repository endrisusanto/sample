import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sample/profile_screen.dart';

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
  //initial firebase app
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return const LoginScreen();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
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
//LOGIN FUNCTION
  //LOGIN FUNCTION
  static Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("no user found for that email");
      }
      // Handle other FirebaseAuthExceptions here if needed
    } catch (e) {
      // Handle other exceptions here if needed
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    //CREATE TEXT FIELD CONTROLLER
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
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
          TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
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
          TextField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(
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
                elevation: 0.0,
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                onPressed: () async {
                  User? user = await loginUsingEmailPassword(
                    email: emailController.text,
                    password: passwordController.text,
                    context: context,
                  );
                  print(user);
                  if (user != null) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const ProfileScreen()));
                  }
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      15.0), // Sesuaikan nilai ini sesuai kebutuhan Anda
                ),
                child: const Text(
                  "LOGIN",
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
