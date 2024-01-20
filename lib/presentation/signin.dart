import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:management_homework/firebase/firebase_auth_services.dart';
import 'package:management_homework/widgets/bar/appbar.dart';
import 'package:management_homework/widgets/toast.dart';
import '../presentation/home.dart';
import '../widgets/actions/submit_button.dart';
import '../widgets/actions/text_link.dart';
import '../widgets/fields/text_field.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuthService _auth = FirebaseAuthService();

  bool _isSigning= false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signInWithGoogle() async {

    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

    try {
      final GoogleSignInAccount?  googleSignInAccount = await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        //await _auth.signInWithCredential(credential);
        Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => HomePage()), (route) => false);

      }
    } catch (e) {
      showToast(message: "some error occured $e");
    }
  }

  void _signIn() async {

    String email = _emailController.text;
    String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      showToast(message: 'Some fields are empty');
    } else {

      setState(() {
        _isSigning = true;
      });

      User? user = await _auth.signInWithEmailAndPassword(email, password) ;
      Future.delayed(const Duration(seconds: 3));

      setState(() {
        _isSigning = false;
      });

      if (user!= null) {
        showToast(message: "User is connected");
        print("good auth (sign in)");
        Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
      } else {
        showToast(message: "You can't connect");
        print("bad auth (sign in)");
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BuildAppBar(title: 'Sign In'),
      body: Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    BuildTextField(controller: _emailController, hintText: 'Email', prefixIcon: Icons.email),
                    const SizedBox(height: 15),
                    BuildTextField(controller: _passwordController, hintText: 'Password', prefixIcon: Icons.password, obscured: true),
                    const SizedBox(height: 30),
                    //_buildForgetPasswordLink(),
                    SubmitButton(text: 'Connect', onPressed: _signIn, processAction: _isSigning),
                    const SizedBox(height: 10),
                    SubmitButton(text: 'Sign with Google', onPressed: _signInWithGoogle, processAction: _isSigning, icon: FontAwesomeIcons.google),
                    const SizedBox(height: 30),
                    TextLink(
                        prefix: 'Does not have account ? ', suffix: 'Sign up',
                        navigator: () => Navigator.pushNamed(context, '/register')
                    )
                  ],
                ),
                ),
              ),
        ),
    );
  }

  Widget _buildForgetPasswordLink() {
    return ElevatedButton(
      onPressed: () {},
      child: Text("Forget Password", style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}


