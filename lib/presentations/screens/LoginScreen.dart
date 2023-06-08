import 'dart:convert';
import 'package:firstapp/logic/cubit/auth_cubit.dart';
import 'package:firstapp/models/loginmodel.dart';
import 'package:firstapp/presentations/screens/RegistrationPage.dart';
import 'package:firstapp/logic/auth.dart';
import 'package:firstapp/presentations/screens/home.dart';
import 'package:firstapp/presentations/screens/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';
import 'RegistrationPage.dart';
import 'package:flutter/services.dart';

import 'localizations.dart';

// import 'package:flutter/sevices.dart';
Widget heightSpacer(double myHeight) => SizedBox(height: myHeight);
final TextEditingController _mailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
// bool _isLoading = false;
final GlobalKey<FormState> _globalKey = GlobalKey();
String? _errorMessage;
Widget widthSpacer(double myWidth) => SizedBox(width: myWidth);

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isRememberMe = false;
  Widget buildEmail() {
    return Form(
      key: _globalKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            AppLocalizations.of(context)!.translate('Email'),
            style: TextStyle(
                color: kContentColorDarkTheme,
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
            child: TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Whassup';
                }
              },
              controller: _mailController,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color: kContentColorLightTheme),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14),
                  prefixIcon: Icon(Icons.email,
                      color: Color.fromARGB(255, 115, 82, 28)),
                  hintText: AppLocalizations.of(context)!.translate('Email'),
                  hintStyle: TextStyle(color: kContentColorLightTheme)),
            ),
          )
        ],
      ),
    );
  }

  Widget buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          AppLocalizations.of(context)!.translate('Email'),
          style: TextStyle(
              color: kContentColorDarkTheme,
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
          child: TextField(
            controller: _passwordController,
            obscureText: true,
            style: TextStyle(color: kContentColorLightTheme),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon:
                    Icon(Icons.lock, color: Color.fromARGB(255, 115, 82, 28)),
                hintText: AppLocalizations.of(context)!.translate('Password'),
                hintStyle: TextStyle(color: kContentColorLightTheme)),
          ),
        )
      ],
    );
  }

  Widget buildRegistreBtn(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          AppLocalizations.of(context)!.translate("Don't have an account?"),
          style: TextStyle(
            color: kContentColorLightTheme,
          ),
        ),
        InkWell(
          onTap: () {
            navigateToRegisterPage(context);
          },
          child: Text(
            AppLocalizations.of(context)!.translate('Register'),
            style: TextStyle(
              decoration: TextDecoration.underline,
              color: kPrimaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 50),
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthSuccess) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ChatScreen(model: state.model);
                      },
                    ),
                  );
                } else if (state is AuthError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(
                      content: Text(AppLocalizations.of(context)!.translate('Check your credentials')),
                    ),
                  );
                }
              },
              builder: (context, state) {
                return PrimaryButton(
                  text: AppLocalizations.of(context)!.translate('Login'),
                  press: () {
                    if (_globalKey.currentState!.validate()) {
                      context.read<AuthCubit>().login(
                          _mailController.text, _passwordController.text);
                      _mailController.clear();
                      _passwordController.clear();
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kContentColorDarkTheme,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: SafeArea(
          bottom: false,
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  kContentColorDarkTheme,
                  kContentColorDarkTheme,
                  kContentColorDarkTheme,
                  kContentColorDarkTheme,
                ])),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 50.0,
                left: 20,
                right: 20,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 30),
                    Center(
                      child: Image.asset(
                        'Img/sw.png',
                        height: 200,
                      ),
                    ),
                    SizedBox(height: 40),
                    buildEmail(),
                    SizedBox(height: 10),
                    buildPassword(),
                    // buildForgotPassBtn(),
                    // buildRememberCb(),
                    buildLoginBtn(),
                    buildRegistreBtn(context),

                    // buildRegistreBtn(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void navigateToRegisterPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegistrationPage()),
    );
  }
}
