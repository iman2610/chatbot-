import 'dart:convert';
import 'package:firstapp/logic/cubit/change_pw_cubit.dart';
import 'package:firstapp/models/loginmodel.dart';
import 'package:firstapp/presentations/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/constants.dart';
import 'localizations.dart';

Widget heightSpacer(double myHeight) => SizedBox(height: myHeight);
final TextEditingController _oldpasswordController = TextEditingController();
final TextEditingController _newpasswordController = TextEditingController();
final TextEditingController _newpassword2Controller = TextEditingController();
// bool _isLoading = false;
Widget widthSpacer(double myWidth) => SizedBox(width: myWidth);

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => ChangePasswordState();
}

class ChangePasswordState extends State<ChangePassword> {
  Widget buildoldPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
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
              padding: EdgeInsets.only(left: 5), // Adjust the value as needed
              child: TextField(
                controller: _oldpasswordController,
                obscureText: true,
                style: TextStyle(color: kContentColorLightTheme),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14),
                    prefixIcon: Icon(Icons.password,
                        color: Color.fromARGB(255, 115, 82, 28)),
                    hintText:
                        AppLocalizations.of(context)!.translate('Old password'),
                    hintStyle: TextStyle(color: kContentColorLightTheme)),
              ),
            ))
      ],
    );
  }

  Widget buildnewPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
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
              padding: EdgeInsets.only(left: 5), // Adjust the value as needed
              child: TextField(
                controller: _newpasswordController,
                obscureText: true,
                style: TextStyle(color: kContentColorLightTheme),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14),
                    prefixIcon: Icon(Icons.lock,
                        color: Color.fromARGB(255, 115, 82, 28)),
                    hintText:
                        AppLocalizations.of(context)!.translate('New password'),
                    hintStyle: TextStyle(color: kContentColorLightTheme)),
              ),
            ))
      ],
    );
  }

  Widget buildnewPassword2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
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
              padding: EdgeInsets.only(left: 5), // Adjust the value as needed
              child: TextField(
                controller: _newpassword2Controller,
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
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.translate('Change password')),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30),
                buildoldPassword(),
                SizedBox(height: 20),
                buildnewPassword(),
                SizedBox(height: 20),
                buildnewPassword2(),
                SizedBox(height: 20),
                const SizedBox(height: 16.0),
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
                        child: BlocConsumer<ChangePwCubit, ChangePwState>(
                          listener: (context, state) {
                            if (state is ChangePwSuccess) {
                              Navigator.pop(context);
                            } else if (state is ChangePwError) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(AppLocalizations.of(context)!
                                      .translate(state.errorMessage)),
                                ),
                              );
                            }
                          },
                          builder: (context, state) {
                            return ElevatedButton(
                              onPressed: () {
                                context.read<ChangePwCubit>().changepw(
                                      _oldpasswordController.text,
                                      _newpasswordController.text,
                                      _newpassword2Controller.text,
                                    );
                              },
                              style: ElevatedButton.styleFrom(
                                primary: kPrimaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              child: BlocBuilder<ChangePwCubit, ChangePwState>(
                                builder: (context, state) {
                                  if (state is ChangePwLoading) {
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    );
                                  } else {
                                    return Text(AppLocalizations.of(context)!
                                        .translate('Confirmer'));
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
    );
  }
}
