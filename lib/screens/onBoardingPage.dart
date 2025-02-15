import 'package:firebase_auth_example/screens/logInPage.dart';
import 'package:firebase_auth_example/screens/signUpPage.dart';
import 'package:firebase_auth_example/widgets/colors.dart';
import 'package:flutter/material.dart';

class onBoardingPage extends StatefulWidget {
  const onBoardingPage({super.key});

  @override
  State<onBoardingPage> createState() => _onBoardingPageState();
}

class _onBoardingPageState extends State<onBoardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        color: Color(0xFF437D28),
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: 60, left: 25, right: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 80,
                      child: Image.asset(
                        "assets/images/m-Photoroom.png",
                        width: 80,
                        height: 80,
                        color: Color(0xFFF2FEED),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: SizedBox(
                        height: 50,
                        child: Text(
                          "EZYTASK",
                          style: TextStyle(
                              fontSize: 28,
                              color: Color(0xFFF2FEED),
                              fontFamily: "Shippori",
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: Text(
                    "GÜNÜNÜ PLANLA, VERİMLİLİĞİNİ ARTTIR!",
                    style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFFF2FEED),
                        fontFamily: "Shippori",
                        fontWeight: FontWeight.normal),
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 60,
                        width: 150,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => LogInPage())));
                          },
                          style: ElevatedButton.styleFrom(
                              side: BorderSide(
                                color: MyColors.white,
                              ),
                              backgroundColor: Color(0xFF437D28),
                              shadowColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          child: Text(
                            "Log In",
                            style: TextStyle(
                                color: Color(0xFFF2FEED),
                                fontFamily: "Shippori",
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                        height: 60,
                        width: 150,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => SignUpPage())));
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                color: Color(0xFF437D28),
                                fontFamily: "Shippori",
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
