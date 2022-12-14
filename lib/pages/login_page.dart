import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'forgot_pw_page.dart';

class LoginPage extends StatefulWidget {

  final VoidCallback showRegisterPage;
  const LoginPage({Key? key, required this.showRegisterPage}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
  }

  @override
  dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Put Integrity Brewing icon here.
                Image.asset(
                  //  'assets/images/image001.jpg',
                  'assets/images/IntegrityBrewingTransparent_75x75.png',
                  //'assets/images/IB_I_Logo_Black_Vector_10PCT.png',
                  width: 326,
                  height: 126,
                  fit: BoxFit.cover,
                ),
                //https://stackoverflow.com/questions/50198885/how-to-use-an-image-instead-of-an-icon-in-flutter

/*              Icon(
                  Icons.android,
                  size: 100,
                ),*/

                //Hello again!
                SizedBox(height: 10),
                Text('Keg Tracker',
                  style: GoogleFonts.bebasNeue(
                    fontSize: 52,
                  )
/*              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 36,
                  ),*/
                ),
                SizedBox(height: 10),
                Text(
                  'Sign in to track kegs.',
                   style: TextStyle(
                      fontSize: 20,
                    ),
                ),
                SizedBox(height:50),
                //email textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: _emailController,
                        autofocus: false,
                        decoration:InputDecoration(
                          border: InputBorder.none,
                          hintText:'Email',
                        )
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),

                //password textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                          decoration:InputDecoration(
                            border: InputBorder.none,
                            hintText:'Password',
                          )
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap:() {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return ForgotPasswordPage();
                          }));
                        },
                        child: Text('Forgot password',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                  )),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),


                //sign in button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: signIn,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(12)
                      ),
                      child: Center(
                        child: Text('Sign in',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          )
                        ),
                      )
                    ),
                  ),
                ),
                SizedBox(height: 25),

                //not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        'Not a member?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )
                    ),
                    GestureDetector(
                      onTap: widget.showRegisterPage,
                      child: Text(
                          ' Register now',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      )),
                    ),
                  ],
                ),
              ],
            ),
          ),
      )
    ));
  }
}