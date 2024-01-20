import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:management_homework/widgets/bar/appbar.dart';
import 'package:management_homework/widgets/toast.dart';
import '../firebase/firebase_auth_services.dart';
import '../presentation/home.dart';
import '../widgets/actions/submit_button.dart';
import '../widgets/actions/text_link.dart';
import '../widgets/fields/text_field.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuthService _auth = FirebaseAuthService();

  bool _isSigning= false;

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signUp() async {

    String email = _emailController.text;
    String password = _passwordController.text;
      if (email.isEmpty || password.isEmpty) {
        showToast(message: 'Some fields are empty');
      } else {

        setState(() {
          _isSigning = true;
        });

        User? user = await _auth.signUpWithEmailAndPassword(email, password) ;
        Future.delayed(const Duration(seconds: 3));

        setState(() {
          _isSigning = false;
        });

        if (user!= null) {
          showToast(message: 'User is created');
          Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
        } else {
          showToast(message: 'User is not created');
        }
      }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BuildAppBar(title: 'Sign Up'),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                BuildTextField(controller: _userNameController, hintText: 'User Name', prefixIcon: Icons.person),
                const SizedBox(height: 15),
                BuildTextField(controller: _emailController, hintText: 'Email', prefixIcon: Icons.email),
                const SizedBox(height: 15),
                BuildTextField(controller: _passwordController, hintText: 'Password', prefixIcon: Icons.password,obscured: true),
                const SizedBox(height: 30),
                SubmitButton(text: 'Register', onPressed: _signUp, processAction: _isSigning),
                const SizedBox(height: 30),
                TextLink(
                    prefix: 'Do you want to return a register page ? ',
                    suffix: 'Sign in',
                    navigator: () => Navigator.pushNamed(context, '/auth')
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}

