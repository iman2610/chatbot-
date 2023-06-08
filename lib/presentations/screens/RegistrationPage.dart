import 'dart:convert';
import 'package:firstapp/logic/cubit/regist_cubit.dart';
import 'package:firstapp/models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../constants/constants.dart';
import 'LoginScreen.dart';
import 'localizations.dart';

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
        SizedBox(height: 30),
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
            padding: EdgeInsets.only(left: 5), // Adjust the value as needed
            child: TextField(
              controller: _nameController,
              style: TextStyle(color: kContentColorLightTheme),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14),
                  prefixIcon: Icon(Icons.person,
                      color: Color.fromARGB(255, 115, 82, 28)),
                  hintText: AppLocalizations.of(context)!.translate('Name'),
                  hintStyle: TextStyle(color: kContentColorLightTheme)),
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
          SizedBox(height: 20),
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
              padding: EdgeInsets.only(left: 5), // Adjust the value as needed
              child: TextField(
                controller: _emailController,
                style: TextStyle(color: kContentColorLightTheme),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14),
                    prefixIcon: Icon(Icons.email,
                        color: Color.fromARGB(255, 115, 82, 28)),
                    hintText: AppLocalizations.of(context)!.translate('Email'),
                    hintStyle: TextStyle(color: kContentColorLightTheme)),
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
        SizedBox(height: 20),
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
            padding: EdgeInsets.only(left: 5), // Adjust the value as needed
            child: TextField(
              controller: _phoneController,
              style: TextStyle(color: kContentColorLightTheme),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14),
                  prefixIcon: Icon(Icons.phone,
                      color: Color.fromARGB(255, 115, 82, 28)),
                  hintText:
                      AppLocalizations.of(context)!.translate('Phone number'),
                  hintStyle: TextStyle(color: kContentColorLightTheme)),
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
        SizedBox(height: 20),
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
              padding: EdgeInsets.only(left: 5), // Adjust the value as needed
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                style: TextStyle(color: kContentColorLightTheme),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14),
                    prefixIcon: Icon(Icons.lock,
                        color: Color.fromARGB(255, 115, 82, 28)),
                    hintText:
                        AppLocalizations.of(context)!.translate('Password'),
                    hintStyle: TextStyle(color: kContentColorLightTheme)),
              ),
            )
            )
      ],
    );
  }

  Widget buildPassword2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 20),
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
              padding: EdgeInsets.only(left: 5), // Adjust the value as needed
              child: TextField(
                controller: _password2Controller,
                obscureText: true,
                style: TextStyle(color: kContentColorLightTheme),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14),
                    prefixIcon: Icon(Icons.lock,
                        color: Color.fromARGB(255, 115, 82, 28)),
                    hintText: AppLocalizations.of(context)!
                        .translate('Confirm password'),
                    hintStyle: TextStyle(color: kContentColorLightTheme)),
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
        title: Text(AppLocalizations.of(context)!.translate('Register')),
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
                                      SnackBar(
                                        content: Text(
                                            AppLocalizations.of(context)!
                                                .translate(
                                                    'Check your credentials')),
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
                                          return Text(
                                              AppLocalizations.of(context)!
                                                  .translate('Register'),
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
