import 'dart:convert';
import 'package:firstapp/logic/cubit/regist_cubit.dart';
import 'package:firstapp/models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../constants/constants.dart';
import 'LoginScreen.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _password2Controller = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey();

  Widget buildName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Name',
          style: TextStyle(
              color: kContentColorLightTheme,
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: kContentColorDarkTheme,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: kContentColorLightTheme,
                    blurRadius: 6,
                    offset: Offset(0, 2))
              ]),
          height: 60,
          child: Padding(
            padding: EdgeInsets.only(left: 15), // Adjust the value as needed
            child: TextField(
              controller: _nameController,
              style: TextStyle(color: kContentColorLightTheme),
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildEmail() {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Email',
            style: TextStyle(
                color: kContentColorLightTheme,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: kContentColorDarkTheme,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: kContentColorLightTheme,
                      blurRadius: 6,
                      offset: Offset(0, 2))
                ]),
            height: 60,
            child: Padding(
              padding: EdgeInsets.only(left: 15), // Adjust the value as needed
              child: TextField(
                controller: _emailController,
                style: TextStyle(color: kContentColorLightTheme),
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPhone() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Phone number',
          style: TextStyle(
              color: kContentColorLightTheme,
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: kContentColorDarkTheme,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: kContentColorLightTheme,
                    blurRadius: 6,
                    offset: Offset(0, 2))
              ]),
          height: 60,
          child: Padding(
            padding: EdgeInsets.only(left: 15), // Adjust the value as needed
            child: TextField(
              controller: _phoneController,
              style: TextStyle(color: kContentColorLightTheme),
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: TextStyle(
              color: kContentColorLightTheme,
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: kContentColorDarkTheme,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: kContentColorLightTheme,
                      blurRadius: 6,
                      offset: Offset(0, 2))
                ]),
            height: 60,
            child: Padding(
              padding: EdgeInsets.only(left: 15), // Adjust the value as needed
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                style: TextStyle(color: kContentColorLightTheme),
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ))
      ],
    );
  }

  Widget buildPassword2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Confirm password ',
          style: TextStyle(
              color: kContentColorLightTheme,
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: kContentColorDarkTheme,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: kContentColorLightTheme,
                      blurRadius: 6,
                      offset: Offset(0, 2))
                ]),
            height: 60,
            child: Padding(
              padding: EdgeInsets.only(left: 15), // Adjust the value as needed
              child: TextField(
                controller: _password2Controller,
                obscureText: true,
                style: TextStyle(color: kContentColorLightTheme),
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kContentColorDarkTheme,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text('Register'),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    kContentColorDarkTheme,
                    kContentColorDarkTheme,
                    kContentColorDarkTheme,
                  ])),
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 8,
                ),
                child: Form(
                  key: _globalKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 20),
                      buildName(),
                      SizedBox(height: 10),
                      buildEmail(),
                      SizedBox(height: 10),
                      buildPhone(),
                      SizedBox(height: 10),
                      buildPassword(),
                      SizedBox(height: 10),
                      buildPassword2(),
                      const SizedBox(height: 16.0),
                      SizedBox(height: 20),
                      Container(
                        width: 200,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: kPrimaryColor,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: BlocConsumer<RegistCubit, RegistState>(
                                listener: (context, state) {
                                  if (state is RegistSuccess) {
                                    Navigator.pop(context);
                                  } else if (state is RegistError) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Check your credentials'),
                                      ),
                                    );
                                  }
                                },
                                builder: (context, state) {
                                  return ElevatedButton(
                                    onPressed: () {
                                      context.read<RegistCubit>().register(
                                          _emailController.text,
                                          _nameController.text,
                                          _passwordController.text,
                                          _password2Controller.text,
                                          _phoneController.text);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: kPrimaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                    child:
                                        BlocBuilder<RegistCubit, RegistState>(
                                      builder: (context, state) {
                                        if (state is RegistLoading) {
                                          return const Center(
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                            ),
                                          );
                                        } else {
                                          return const Text('Register',
                                              style: TextStyle(
                                                  color: Colors.white));
                                        }
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
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
}
