import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../constants.dart';



class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
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
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //const SizedBox(height: 82,),
              Text("Change Password",style: textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w500),),
              const SizedBox(height: 8,),
              Text("Minimum number of password should be 8 character",style: textTheme.titleSmall?.copyWith(color: Colors.grey),),
              const SizedBox(
                height: 24,
              ),
              _buildResetPasswordForm(),
              const SizedBox(
                height: 48,
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
              hintText: "Old Password",
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
            decoration:  InputDecoration(hintText: "New Password", prefixIcon: Padding(
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



  void _onTapNextButton(){
    if(!_resetPasswordFormKey.currentState!.validate()){
      return;
    }


    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const ChangePasswordScreen(),), (route) => false);

  }
}
