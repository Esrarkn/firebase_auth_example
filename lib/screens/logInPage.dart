import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_example/screens/homePage.dart';
import 'package:firebase_auth_example/screens/signUpPage.dart';
import 'package:firebase_auth_example/widgets/appBar.dart';
import 'package:flutter/material.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ValueNotifier<bool> _obscurePassword = ValueNotifier(true);
  bool isChecked = false;

  Future<bool> loginUserWithEmailAndPassword() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      return true; // Başarılı giriş
    } on FirebaseAuthException catch (e) {
      print("Giriş Hatası: ${e.message}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Giriş başarısız: ${e.message}")),
      );
      return false; // Giriş başarısız
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(),
        body: Center(
          child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Welcome Back !",
                  style: TextStyle(
                      color: Color(0xFF437D28),
                      fontFamily: "Shippori",
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: "Email address",
                    labelStyle: TextStyle(
                      color: Color(0xFF437D28),
                      fontFamily: "Shippori",
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    hintText: "Enter Your Email",
                    hintStyle: TextStyle(
                        color: Color(0xFF437D28),
                        fontFamily: "Shippori",
                        fontSize: 14),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF437D28)),
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: _obscurePassword,
                  builder: (context, obscure, child) {
                    return TextField(
                      controller: _passwordController,
                      obscureText: obscure,
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(
                          color: Color(0xFF437D28),
                          fontFamily: "Shippori",
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        hintText: "Enter your password",
                        hintStyle: TextStyle(
                            color: Color(0xFF437D28),
                            fontFamily: "Shippori",
                            fontSize: 14),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xFF3D7D28)), // Yeşil çerçeve
                          borderRadius: BorderRadius.circular(15),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(obscure
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            _obscurePassword.value = !obscure;
                          },
                        ),
                      ),
                    );
                  },
                ),
                Row(
                  children: [
                    Checkbox(
                        activeColor: Color(0xFF437D28),
                        value: isChecked,
                        onChanged: (val) {
                          setState(() {
                            isChecked = val!;
                          });
                        }),
                    Padding(
                      padding: EdgeInsets.only(),
                      child: Text("Remember Me?",
                          style: TextStyle(
                              color: Color(0xFF437D28),
                              fontFamily: "Shippori",
                              fontSize: 14)),
                    ),
                    SizedBox(
                      width: 80,
                    ),
                    Text("Forgot Password?",
                        style: TextStyle(
                            color: Color(0xFF437D28),
                            fontFamily: "Shippori",
                            fontSize: 14,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () async {
                      bool isSuccess = await loginUserWithEmailAndPassword();
                      if (isSuccess) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => MyHomePage()),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF437D28),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Shippori",
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        child: Divider(
                      color: Color(0xFF437D28),
                      thickness: 1,
                      indent: 20,
                      endIndent: 10,
                    )),
                    Text("Login with",
                        style: TextStyle(
                            color: Color(0xFF437D28),
                            fontFamily: "Shippori",
                            fontSize: 14)),
                    Expanded(
                        child: Divider(
                      color: Color(0xFF437D28),
                      thickness: 1,
                      indent: 10,
                      endIndent: 20,
                    )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset("assets/images/google.png", width: 40),
                    const SizedBox(width: 20),
                    Image.asset("assets/images/apple.png", width: 40),
                    const SizedBox(width: 20),
                    Image.asset("assets/images/linkedin.png", width: 40),
                    const SizedBox(width: 20),
                    Image.asset("assets/images/github.png", width: 40),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Dont't have an account?",
                        style: TextStyle(
                            color: Color(0xFF437D28),
                            fontFamily: "Shippori",
                            fontSize: 14)),
                    SizedBox(
                      width: 6,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpPage()));
                      },
                      child: Text("Sign Up",
                          style: TextStyle(
                              color: Color(0xFF437D28),
                              fontFamily: "Shippori",
                              fontSize: 14,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
