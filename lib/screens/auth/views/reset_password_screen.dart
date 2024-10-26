import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';
import 'login_screen.dart';


class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  Map<String,String> formValues ={"email":"", "OTP": "", "password":""};
  bool isLoading = false;

  inputOnChange(mapKey, textValue){
    setState(() {
      formValues.update(mapKey, (value) => textValue);
    });

  }



  final _resetPasswordFormKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 82,),
              Text("Set Password",style: textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w500),),
              const SizedBox(height: 8,),
              Text("Minimum number of password should be 8 character",style: textTheme.titleSmall?.copyWith(color: Colors.grey),),
              const SizedBox(
                height: 24,
              ),
              _buildResetPasswordForm(),
              const SizedBox(
                height: 48,
              ),
              Center(
                child: _buildHaveAccountSection(),
              ),



            ],),
        ),
      ),
    );
  }


  Widget _buildResetPasswordForm() {
    return Form(
      key: _resetPasswordFormKey,
      child: Column(
        children: [
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value){
              if(value!.isEmpty){
                return "Password is required";

              }
              if(value!.length <= 6){
                return "Password should be 6 character";
              }
              return null;
            },


            onChanged: (textValue){
              inputOnChange("password", textValue);
            },

            keyboardType: TextInputType.emailAddress,
            decoration:  InputDecoration(
                hintText: "Password",
              prefixIcon: Padding(
                padding:
                 EdgeInsets.symmetric(vertical: defaultPadding * 0.75),
                child: SvgPicture.asset(
                  "assets/icons/Lock.svg",
                  height: 24,
                  width: 24,
                  colorFilter: ColorFilter.mode(
                      Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .color!
                          .withOpacity(0.3),
                      BlendMode.srcIn),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value){
              if(value!.isEmpty){
                return "Password is required";

              }
              if(value!.length <= 6){
                return "Password should be 6 character";
              }
              return null;
            },


            onChanged: (textValue){
              inputOnChange("password", textValue);
            },

            keyboardType: TextInputType.emailAddress,
            decoration:  InputDecoration(hintText: "Confirm Password", prefixIcon: Padding(
              padding:
              EdgeInsets.symmetric(vertical: defaultPadding * 0.75),
              child: SvgPicture.asset(
                "assets/icons/Lock.svg",
                height: 24,
                width: 24,
                colorFilter: ColorFilter.mode(
                    Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .color!
                        .withOpacity(0.3),
                    BlendMode.srcIn),
              ),
            ),),
          ),

          const SizedBox(
            height: 24,
          ),
          ElevatedButton(
              onPressed:_onTapNextButton,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text("Submit")),
        ],
      ),
    );
  }
  Widget _buildHaveAccountSection() {
    return RichText(
        text: TextSpan(
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 16,
                letterSpacing: 0.5),
            text: "Have account? ",
            children: [
              TextSpan(
                  text: "Sign In",
                  style: const TextStyle(color: Colors.green),
                  recognizer: TapGestureRecognizer()..onTap = _onTapSignIn)
            ]));
  }
  void _onTapSignIn() {
    // TODO: implement on tap signup screen
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginScreen(),), (route) => false);
  }

  void _onTapNextButton(){
    if(!_resetPasswordFormKey.currentState!.validate()){
      return;
    }


    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginScreen(),), (route) => false);

  }
}
