import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:move_in/controller/signup.dart';
import 'package:move_in/model/user.dart';
import 'package:move_in/utilities/commons.dart';
import 'package:move_in/utilities/constants.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  Signup signupCon = Signup();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController number = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Image.asset('assets/images/signup_bg.png'),
              height: 200,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 65, bottom: 5),
                child: Text(
                  'Register Yourself!!',
                  style: TextStyle(
                    fontFamily: 'Itim',
                    fontSize: 35,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5, right: 5, top: 10),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 15,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 20, left: 20, top: 30),
                        child: TextFormField(
                            controller: email,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            decoration: Commons.buildInputDecoration(
                                Icons.email, 'Enter Email Id')),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20, left: 20),
                        child: TextFormField(
                            controller: password,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            decoration: Commons.buildInputDecoration(
                                Icons.phone, 'Password')),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20, left: 20),
                        child: TextFormField(
                            controller: number,
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            decoration: Commons.buildInputDecoration(
                                Icons.lock, 'Enter Phone Number')),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      _buildSignupBtn(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignupBtn() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          User user = User(
              id: null,
              email: email.text,
              number: number.text,
              password: password.text);

          int flag = await signupCon.saveDataInDB(user);
          if (flag == 0) {
            print('User Already Exists');
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('This email is already registered')));
          } else {
            print("User Successfully Registered");
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Registration Completed Successfully')));
            Navigator.pushNamed(context, Constants.loginRoute);
          }
        },
        padding: EdgeInsets.only(top: 12, left: 30, right: 30, bottom: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.black,
        child: Text(
          'SIGN UP',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Itim',
          ),
        ),
      ),
    );
  }
}
