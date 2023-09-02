import 'package:demo1/services/auth_service.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class LoginSignupEmail extends StatefulWidget {
  static const String routeName = '/login-signup';
  const LoginSignupEmail({super.key});

  @override
  State<LoginSignupEmail> createState() => _LoginSignupEmailState();
}

class _LoginSignupEmailState extends State<LoginSignupEmail> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController username = TextEditingController();
  bool isSignUpScreen = true;
  bool isRememberMe = true;
  final AuthService authService = AuthService();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    username.dispose();
    super.dispose();
  }

  void signup() {
    authService.signUpUser(
      name: username.text,
      email: emailController.text,
      password: passwordController.text,
      context: context,
    );
  }

  void signIn() {
    authService.signinUser(
        email: emailController.text,
        password: passwordController.text,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(91, 45, 44, 44),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                'assets/mainwa.jpg',
              ),
            ),
          ),
          child: Center(
            child: Text(
              'AnimeWalls',
              style: GoogleFonts.zcoolKuaiLe(
                  fontWeight: FontWeight.bold,
                  color: Colors.amber.shade100,
                  fontSize: 60),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          submitButton2(true),
          Positioned(
            top: isSignUpScreen ? 100 : 130,
            child: AnimatedContainer(
              duration: const Duration(microseconds: 900),
              curve: Curves.bounceOut,
              child: Container(
                padding: const EdgeInsets.all(20),
                height: isSignUpScreen ? 300 : 255,
                width: MediaQuery.of(context).size.width - 40,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(15),
                  // border: Border.all(color: Colors.white),
                  boxShadow: [
                    BoxShadow(
                        color: const Color.fromARGB(255, 222, 220, 220)
                            .withOpacity(0.3),
                        blurRadius: 9,
                        spreadRadius: 4),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSignUpScreen = false;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                'LOGIN',
                                style: GoogleFonts.poppins(
                                    color: !isSignUpScreen
                                        ? Colors.white
                                        : Colors.grey,
                                    fontSize: 16,
                                    fontWeight: isSignUpScreen
                                        ? FontWeight.normal
                                        : FontWeight.bold),
                              ),
                              if (!isSignUpScreen)
                                Container(
                                  margin: const EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 55,
                                  color: Colors.orange,
                                )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSignUpScreen = true;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                'SIGNUP',
                                style: GoogleFonts.poppins(
                                    color: isSignUpScreen
                                        ? Colors.white
                                        : Colors.grey,
                                    fontSize: 16,
                                    fontWeight: isSignUpScreen
                                        ? FontWeight.bold
                                        : FontWeight.normal),
                              ),
                              if (isSignUpScreen)
                                Container(
                                  margin: const EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 55,
                                  color: Colors.orange,
                                )
                            ],
                          ),
                        )
                      ],
                    ),
                    if (isSignUpScreen) buildSugnUpSection(),
                    if (!isSignUpScreen) buildSignInSection(),
                  ],
                ),
              ),
            ),
          ),
          submitButton2(false)
        ],
      ),
    );
  }

  Positioned submitButton2(bool shadows) {
    return Positioned(
      top: isSignUpScreen ? 353 : 339,
      //  454 : 440,
      right: 0,
      left: 0,
      child: Center(
        child: InkWell(
          onTap: () {
            isSignUpScreen ? signup() : signIn();
          },
          child: Container(
            padding: const EdgeInsets.all(15),
            height: 90,
            width: 90,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                if (shadows)
                  BoxShadow(
                      color: Colors.white.withOpacity(0.3),
                      offset: const Offset(0, 1),
                      spreadRadius: 1.5,
                      blurRadius: 8)
              ],
            ),
            child: !shadows
                ? Container(
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color.fromARGB(255, 252, 199, 120),
                              Color.fromARGB(255, 248, 84, 73)
                            ]),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 1,
                              offset: const Offset(0, 1))
                        ]),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  )
                : const Center(),
          ),
        ),
      ),
    );
  }

  Container buildSignInSection() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          buildTextField(Icons.mail_outline, 'abc@gmail.com', false, true,
              emailController),
          buildTextField(
              Icons.lock_outline, 'password', true, false, passwordController),
        ],
      ),
    );
  }

  Container buildSugnUpSection() {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          buildTextField(Icons.person, 'User Name', false, false, username),
          buildTextField(
              Icons.email_outlined, 'Email', false, true, emailController),
          buildTextField(
              Icons.lock_outline, 'Password', true, false, passwordController),
        ],
      ),
    );
  }

  Widget buildTextField(IconData icon, String hinttext, bool isPassword,
      bool isEmail, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        style: const TextStyle(color: Colors.white),
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white24,
          prefixIcon: Icon(
            icon,
            color: Colors.white24,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(35),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(35),
          ),
          contentPadding: const EdgeInsets.all(10),
          hintText: hinttext,
          hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ),
    );
  }
}
