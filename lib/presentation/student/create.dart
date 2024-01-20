import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:management_homework/firebase/firebase_auth_services.dart';
import 'package:management_homework/firebase/firebase_crud_services.dart';
import 'package:management_homework/widgets/actions/submit_button.dart';
import 'package:management_homework/widgets/bar/appbar.dart';
import 'package:management_homework/widgets/fields/text_field.dart';
import 'package:management_homework/widgets/toast.dart';

class CreateStudent extends StatefulWidget {
  const CreateStudent({super.key});
  @override
  State<CreateStudent> createState() => _CreateStudentState();
}

class _CreateStudentState extends State<CreateStudent> {
  // Contrôleurs pour les champs de texte
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _matriculeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final FirebaseAuthService _auth = FirebaseAuthService();
  final FirebaseCRUDService _crud = FirebaseCRUDService();


  // Valeur par défaut du choix Sexe
  String _selectedGender = 'Homme';
  Color firstNameColor = Colors.grey;
  Color lastNameColor = Colors.grey;
  Color matriculeColor = Colors.grey;
  Color userNameColor = Colors.grey;
  Color passwordColor = Colors.grey;
  Color confirmPasswordColor = Colors.grey;

  bool _isCreated= false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _matriculeController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future _createNewStudent() async {

    String email = _emailController.text;
    String password = _passwordController.text;

    try {
      setState(() {
        _isCreated = true;
      });

      User? user = await _auth.signUpWithEmailAndPassword(email, password) ;
      Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isCreated = false;
      });

      if (user!= null) {
        final userCollection = FirebaseFirestore.instance.collection('users');
        String id = userCollection.doc().id;

        await userCollection.doc(id).set(
            {
              "id": id,
              "nom": _firstNameController.text,
              "prénom": _lastNameController.text,
              "matricule": _matriculeController.text,
              "sexe": _selectedGender,
              "email": email,
              "mot_passe": password,
            }
        );
        Navigator.pushNamed(context, '/');
        showToast(message: 'Student is created');
      }

    } catch (e) {
      print(e.toString());
    }
  }

/*
  Future _createNewStudentN() async {

    final firseStore = FirebaseFirestore.instance;

    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _crud.createUser(
        new Etudiant(0, _firstNameController.text, _lastNameController.text, _matriculeController.text, (_selectedGender == 'Homme') as Sexe : Sexe.HOMME ? Sexe.Femme, 2024)
    ) ;

    setState(() {
      _isCreated = true;
    });

    try {

      User? user = await _auth.signUpWithEmailAndPassword(email, password) ;
      Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isCreated = false;
      });

      if (user!= null) {
        await firseStore.collection('users').doc('1').set(
            {
              "nom": _firstNameController.text,
              "prénom": _lastNameController.text,
              "matricule": _matriculeController.text,
              "sexe": _selectedGender,
              "email": email,
              "mot_passe": password,
            }
        );
        Navigator.pushNamed(context, '/');
        showToast(message: 'Student is created');
      }

    } catch (e) {
      print(e.toString());
    }
  }
 */

  // Fonction du contrôle
  void _handleSubmit() async {
    // Vérifiez chaque champ et affichez un message si nécessaire
    if (_firstNameController.text.isEmpty ||
        _lastNameController.text.isEmpty ||
        _matriculeController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      showToast(message: 'Some fields are empty');
    } else if (_passwordController.text != _confirmPasswordController.text) {
      showToast(message: 'confirmation is incorrect');
    } else {
      _createNewStudent();
    }
  }


  @override
  Widget build(BuildContext context) {
    // test d'exsitance de la session d'authentification
    if (FirebaseAuth.instance.currentUser == null) {
      Future.microtask(() => Navigator.pushReplacementNamed(context, '/auth'));
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      appBar: const BuildAppBar(title: 'Ajouter un nouveau étudiant'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // ligne 1
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(1.0),
                      child: BuildTextField(controller: _firstNameController, hintText: 'First Name', prefixIcon: Icons.person),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(1.0),
                      child: BuildTextField(controller: _lastNameController, hintText: 'Last Name', prefixIcon: Icons.person),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // ligne 2
              Container(
                padding: const EdgeInsets.all(1.0),
                child:  BuildTextField(controller: _matriculeController, hintText: 'Matricule', prefixIcon: Icons.perm_identity),
              ),
              const SizedBox(height: 16),
              // ligne 3
              const Text(
                'Sexe',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Radio(
                        value: 'Homme',
                        groupValue: _selectedGender,
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value.toString();
                          });
                        },
                      ),
                      const Text('Homme'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: 'Femme',
                        groupValue: _selectedGender,
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value.toString();
                          });
                        },
                      ),
                      const Text('Femme'),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // ligne 4
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(1.0),
                      child: BuildTextField(controller: _emailController, hintText: 'Email', prefixIcon: Icons.email),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // ligne 5
              Container(
                padding: const EdgeInsets.all(1.0),
                child: BuildTextField(controller: _passwordController, hintText: 'Password', prefixIcon: Icons.password,obscured: true),
              ),
              const SizedBox(height: 16),
              // ligne 6
              Container(
                padding: const EdgeInsets.all(1.0),
                child: BuildTextField(controller: _confirmPasswordController, hintText: 'Password Confirmation', prefixIcon: Icons.password,obscured: true),
              ),
              const SizedBox(height: 16),
              // ligne 7
              SubmitButton(text: 'Register', onPressed: _handleSubmit, processAction: _isCreated),
            ],
          ),
        ),
      ),
    );
  }
}
