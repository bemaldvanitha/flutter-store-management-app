import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  Map<String,String> _authData = {
    'email': '',
    'password': '',
  };
  bool _isLogin = true;
  bool _isLoading = false;

  void _showErrorDialog(String err){
    showDialog(
      context: context,
      builder: (ctx){
        return AlertDialog(
          title: Text('Auth Error'),
          content: Text(err),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: (){
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }

  void authentication() async {
    var _isValid = _formKey.currentState.validate();
    if(!_isValid){
      return;
    }
    _formKey.currentState.save();

    setState(() {
      _isLoading = true;
    });

    try{
      if(_isLogin){
       await Provider.of<Auth>(context,listen: false).signIn(_authData['email'], _authData['password']);
      }else{
        await Provider.of<Auth>(context,listen: false).signUp(_authData['email'], _authData['password']);
      }
      Navigator.of(context).pushReplacementNamed('/main');
    }catch(err){
      var errorMessage = 'Auth Error';
      if(err.toString().contains('EMAIL_EXISTS')){
        errorMessage = 'This email already used';
      }else if(err.toString().contains('INVALID_EMAIL')){
        errorMessage = 'This email invalid';
      }else if(err.toString().contains('WEAK_PASSWORD')){
        errorMessage = 'This password too weak';
      }else if(err.toString().contains('EMAIL_NOT_FOUND')){
        errorMessage = 'This email not found';
      }else if(err.toString().contains('INVALID_PASSWORD')){
        errorMessage = 'Invalid password';
      }
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authentication'),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.yellow[200].withOpacity(0.5),Colors.redAccent[200].withOpacity(0.5)],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft
          )
        ),
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.purple[100],
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 7,
                  blurRadius: 10,
                )
              ]
            ),
            width: double.infinity,
            height: 400,
            margin: EdgeInsets.symmetric(vertical: 100,horizontal: 20),
            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        _isLoading ? Center(
                          child: CircularProgressIndicator(),
                        ): Container(),
                        TextFormField(
                          validator: (value){
                            if(value.isEmpty || value.length < 8){
                              return 'enter email';
                            }
                            if(!value.endsWith('.com') || !value.contains('@')){
                              return 'email not valid';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Enter Email',
                            labelStyle: TextStyle(
                              fontFamily: 'Architect',
                            ),
                            icon: Icon(Icons.email),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (value){
                            _authData['email'] = value;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (value){
                            if(value.isEmpty || value.length < 5){
                              return 'enter valid password';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Enter Password',
                              labelStyle: TextStyle(
                                fontFamily: 'Architect',
                              ),
                            icon: Icon(Icons.text_rotation_angledown)
                          ),
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          onSaved: (value){
                            _authData['password'] = value;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        RaisedButton(
                          color: Colors.orange[200],
                          splashColor: Colors.orange[400],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Text(
                            _isLogin ? 'Sign In': 'Sign Up',
                            style: TextStyle(
                              fontFamily: 'Fredoka',
                              fontSize: 15
                            ),
                          ),
                          onPressed: authentication,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        RaisedButton(
                          color: Colors.pink[100],
                          splashColor: Colors.pinkAccent[200],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Text(
                            _isLogin ? 'Switch to Sign Up' : 'Switch to Sign In',
                            style: TextStyle(
                                fontFamily: 'Fredoka',
                                fontSize: 15
                            ),
                          ),
                          onPressed: (){
                            setState(() {
                              _isLogin = !_isLogin;
                            });
                          },
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

        )
      )
    );
  }
}

