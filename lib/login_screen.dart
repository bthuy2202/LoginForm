import 'package:flutter/material.dart';
import 'package:login/common/common_textfield.dart';
import 'package:login/constant/colors.dart';
import 'package:login/constant/strings.dart';
import 'package:login/homepage_screen.dart';


class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String errorEmail = "";
  String errorPassword = "";
  bool invalidEmail = false;
  bool invalidPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Container(
          constraints: const BoxConstraints.expand(),
          color: AppColors.blue.shade700,
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("assets/images/logo.png"),
                const SizedBox(height: 55),
                const Text(TextApp.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 27),
                const Text(TextApp.subTitle,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 16
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      CommonTextField(
                        textEditingController: emailController,
                        obscureText: false,
                        textInputAction: TextInputAction.next,
                        hintText: TextApp.email,
                        errorText: invalidEmail ? errorEmail : null,
                        onEditingComplete: (){
                          FocusManager.instance.primaryFocus?.nextFocus();
                        },
                      ),
                      const SizedBox(height: 16),
                      CommonTextField(
                        textEditingController: passwordController,
                        obscureText: true,
                        hintText: TextApp.password,
                        errorText: invalidPassword ? errorPassword : null,
                        onEditingComplete: (){
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                      ),
                      const SizedBox(height: 25),
                      ConstrainedBox(
                        constraints: const BoxConstraints.tightFor(height: 58),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(
                              AppColors.green.shade400,
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          onPressed: () {
                            onClickLogin();
                          },
                          child: const Align(
                            alignment: Alignment.center,
                            child: Text(
                              TextApp.btnLogin,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
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
  bool validateEmail(String value){
    String patternEmail = TextApp.regexEmail;
    String patternPhone = TextApp.regexPhone;
    RegExp regEmail = RegExp(patternEmail);
    RegExp regPhone = RegExp(patternPhone);
    return regEmail.hasMatch(value) || regPhone.hasMatch(value);
  }
  void onClickLogin(){
    setState(() {
      if(emailController.text.isEmpty){
        invalidEmail = true;
        errorEmail = TextApp.emptyText;
      }
      else if(!validateEmail(emailController.text)){
        invalidEmail = true;
        errorEmail = TextApp.errorEmail;
      }else{
        invalidEmail = false;
      }
      if(passwordController.text.isEmpty){
        invalidPassword = true;
        errorPassword = TextApp.emptyText;
      }
      else if(passwordController.text.length < 8){
        invalidPassword = true;
        errorPassword = TextApp.errorPassword;
      }else{
        invalidPassword = false;
      }
      if(!invalidEmail && !invalidPassword){
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomePage(),), (route) => false);
      }
    });
  }
}