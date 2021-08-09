import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:move_in/controller/login_controller.dart';
import 'package:move_in/model/user.dart';
import 'package:move_in/utilities/commons.dart';
import 'package:move_in/utilities/constants.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController number = TextEditingController();
  TextEditingController password = TextEditingController();
  LoginController loginCon= LoginController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Image.asset('assets/images/login_bg.png'),
              height: 300,
            ),
            Center(
              child: Text(
                'Welcome Back!!',
                style: TextStyle(
                  fontFamily: 'Itim',
                  fontSize: 35,
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
                          controller: number,
                          keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            decoration: Commons.buildInputDecoration(
                                Icons.phone, 'Enter Phone Number')),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20, left: 20),
                        child: TextFormField(
                          controller: password,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            decoration: Commons.buildInputDecoration(
                                Icons.lock, 'Password')),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 200, right: 10),
                        child: InkWell(
                          onTap: () {
                            print("Clicked");
                          },
                          child: Text(
                            'Forget Password ?',
                            style: TextStyle(
                              fontFamily: 'Itim',
                            ),
                          ),
                        ),
                      ),
                      _buildLoginBtn(),
                      _buildSignInWithText(),
                      _buildSocialBtnRow(),
                      _buildSignupBtn(),
                      SizedBox(
                        height: 20,
                      ),
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


  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30,vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed:() async{
          if (_formKey.currentState.validate()) {

            Map map = await loginCon.login(new User(
                id: null,
                email: null,
                number: number.text,
                password: password.text));

            if (map==null || map.isEmpty) {
              print('Invalid Credentials');
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('Invalid Credentials. Please enter again.')));
            } else {
              print("User Successfully Logged In");
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('Welcome')));
              Navigator.pushNamed(context, Constants.homeScreenRoute, arguments: User.fromJson(map));
            }
          }
        },
        padding: EdgeInsets.only(top:12,left: 30,right: 30,bottom: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.black,
        child: Text(
          'LOGIN',
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

  Widget _buildSignInWithText() {
    return Column(
      children: <Widget>[
        Text(
          '- OR -',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 20.0),
        Text(
          'Login with',
          style: Constants.kLabelStyle,
        ),
      ],
    );
  }

  Widget _buildSocialBtn(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialBtnRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildSocialBtn(
                () => print('Login with Facebook'),
            AssetImage(
              'assets/logos/facebook.jpg',
            ),
          ),
          _buildSocialBtn(
                () => print('Login with Google'),
            AssetImage(
              'assets/logos/google.jpg',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () {
        print('Register button pressed');
        Navigator.pushNamed(context, Constants.signupRoute);
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account? ',
              style: TextStyle(
                fontFamily: 'Itim',
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Register',
              style: TextStyle(
                fontFamily: 'Itim',
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
