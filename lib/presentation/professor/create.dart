import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:management_homework/widgets/actions/submit_button.dart';
import 'package:management_homework/widgets/bar/appbar.dart';
import '../../model/professeur.dart';
import '../../model/sexe.dart';
import '../../main.dart';

class CreateProfessor extends StatefulWidget {
  const CreateProfessor({super.key});
  @override
  State<CreateProfessor> createState() => _CreateProfessorState();
}

class _CreateProfessorState extends State<CreateProfessor> {
  // Contrôleurs pour les champs de texte
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _matriculeController = TextEditingController();
  final TextEditingController _matiereController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // Valeur par défaut du choix Sexe
  String _selectedGender = 'Homme';
  Color firstNameColor = Colors.grey;
  Color lastNameColor = Colors.grey;
  Color matriculeColor = Colors.grey;
  Color matiereColor = Colors.grey;
  Color userNameColor = Colors.grey;
  Color passwordColor = Colors.grey;
  Color confirmPasswordColor = Colors.grey;


  bool _isCreated= false;

  // Fonction du contrôle
  void _handleSubmit() {
    // Vérifiez chaque champ et affichez un message si nécessaire
    if (_firstNameController.text.isEmpty ||
        _lastNameController.text.isEmpty ||
        _matriculeController.text.isEmpty ||
        _matiereController.text.isEmpty ||
        _userNameController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez remplir tous les champs !!')),
      );
    } else if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('La confirmation du mot de passe est incorrecte !!')),
      );
    } else {
      professeurs.add(Professeur.compte(
          '',
          _firstNameController.text,
          _lastNameController.text,
          _matiereController.text,
          _selectedGender == 'Home' ? Sexe.HOMME : Sexe.FEMME,
          _matiereController.text,
          [],
          _userNameController.text,
          _passwordController.text));
      Navigator.pushNamed(context, '/');
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
      appBar: const BuildAppBar(title: 'Ajouter un nouveau professeur'),
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
                      color: Colors.grey,
                      child: TextField(
                        controller: _firstNameController,
                        decoration: const InputDecoration(
                          hintText: 'Nom',
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(1.0),
                      color: Colors.grey,
                      child: TextField(
                        controller: _lastNameController,
                        decoration: const InputDecoration(
                          hintText: 'Prénom',
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // ligne 2
              Container(
                padding: const EdgeInsets.all(1.0),
                color: Colors.grey,
                child: TextField(
                  controller: _matriculeController,
                  decoration: const InputDecoration(
                    hintText: 'Matricule',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // ligne 3
              Container(
                padding: const EdgeInsets.all(1.0),
                color: Colors.grey,
                child: TextField(
                  controller: _matiereController,
                  decoration: const InputDecoration(
                    hintText: 'Matière',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // ligne 4
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
              // ligne 5
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(1.0),
                      color: Colors.grey,
                      child: TextField(
                        controller: _userNameController,
                        decoration: const InputDecoration(
                          hintText: "Email",
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // ligne 6
              Container(
                padding: const EdgeInsets.all(1.0),
                color: Colors.grey,
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Mot de passe',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // ligne 7
              Container(
                padding: const EdgeInsets.all(1.0),
                color: Colors.grey,
                child: TextField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Confirmation du mot de passe',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // ligne 8
              SubmitButton(text: 'Register', onPressed: _handleSubmit, processAction: _isCreated),
            ],
          ),
        ),
      ),
    );
  }
}
