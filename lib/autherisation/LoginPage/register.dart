import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:corporate_manager/models/user_class.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({super.key, required this.showLoginPage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  String _role = 'Employee';
  String _name = '';
  String _lastName = '';
  String _email = '';
  String _phoneNo = '';
  String _password = '';

  void _registerUser() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: _email,
          password: _password,
        );

        UserModel newUser = UserModel(
          uid: userCredential.user!.uid,
          role: _role,
          name: _name,
          lastName: _lastName,
          email: _email,
          phoneNo: _phoneNo,
        );

        FirebaseFirestore.instance
            .collection('users')
            .doc(newUser.uid)
            .set(newUser.toMap());

        // Navigate to another page or show success message
      } catch (e) {
        print(e);
        // Handle error (e.g., show a message to the user)
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("2a2438"),
      appBar: AppBar(title: const Text('Registration')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Role',labelStyle: TextStyle(color: Color.fromARGB(255, 241, 224, 208))),
                value: _role,
                items: ['Employee', 'Manager', 'Admin'].map((String role) {
                  return DropdownMenuItem<String>(
                    value: role,
                    child: Text(role,style: TextStyle(color: Color.fromARGB(255, 101, 67, 33)),),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _role = newValue!;
                  });
                },
                validator: (value) => value == null ? 'Select a role' : null,
                onSaved: (value) => _role = value!,
              ),
              TextFormField(
                
                decoration: const InputDecoration(labelText: 'First Name',labelStyle: TextStyle(color: Color.fromARGB(255, 241, 224, 208)),),
                validator: (value) =>
                    value!.isEmpty ? 'Enter first name' : null,
                onSaved: (value) => _name = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Last Name',labelStyle: TextStyle(color: Color.fromARGB(255, 241, 224, 208))),
                validator: (value) => value!.isEmpty ? 'Enter last name' : null,
                onSaved: (value) => _lastName = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Phone Number',labelStyle: TextStyle(color: Color.fromARGB(255, 241, 224, 208))),
                validator: (value) =>
                    value!.isEmpty ? 'Enter phone number' : null,
                onSaved: (value) => _phoneNo = value!,
                keyboardType: TextInputType.phone,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email',labelStyle: TextStyle(color: Color.fromARGB(255, 241, 224, 208))),
                validator: (value) => value!.isEmpty ? 'Enter email' : null,
                onSaved: (value) => _email = value!,
                keyboardType: TextInputType.emailAddress,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password',labelStyle: TextStyle(color: Color.fromARGB(255, 241, 224, 208))),
                validator: (value) =>
                    value!.length < 6 ? 'Enter a password 6+ chars long' : null,
                onSaved: (value) => _password = value!,
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _registerUser,
                child: const Text('Register'),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: InkWell(
                  onTap: widget.showLoginPage,
                  child: RichText(
                    text: const TextSpan(children: <TextSpan>[
                      TextSpan(text: "Already have an account? "),
                      TextSpan(
                          text: "Login Now",
                          style: TextStyle(color: Colors.lightBlue))
                    ]),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
