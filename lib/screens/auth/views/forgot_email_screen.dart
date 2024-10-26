

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';
import '../../../route/route_constants.dart';
import 'forgot_password_otp_screen.dart';


class ForgotPasswordEmailScreen extends StatefulWidget {
  const ForgotPasswordEmailScreen({super.key});

  @override
  State<ForgotPasswordEmailScreen> createState() => _ForgotPasswordEmailScreenState();
}

class _ForgotPasswordEmailScreenState extends State<ForgotPasswordEmailScreen> {
  Map<String,String> formValues ={"email":"",};
  bool isLoading = false;

  inputOnChange(mapKey, textValue){
    setState(() {
      formValues.update(mapKey, (value) => textValue);
    });

  }


  final _forgotEmailFormKey = GlobalKey<FormState>();

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
              Text("Your Email Address",style: textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w500),),
              const SizedBox(height: 8,),
              Text("A 6 digit verification otp will be sent to your email address",style: textTheme.titleSmall?.copyWith(color: Colors.grey),),
              const SizedBox(
                height: 24,
              ),
              _buildVerifyEmailForm(),
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


  Widget _buildVerifyEmailForm() {
    return Form(
      key: _forgotEmailFormKey,
      child: Column(
        children: [
          TextFormField(


            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value){
              if(value!.isEmpty){
                return "Email is required";
              }
              return null;
            },
            onChanged: (textValue){
              inputOnChange("email", textValue);
            },
            keyboardType: TextInputType.emailAddress,

            decoration:  InputDecoration(hintText: "Email",
                prefixIcon: Padding(
                padding:
                const EdgeInsets.symmetric(vertical: defaultPadding * 0.75),
        child: SvgPicture.asset(
          "assets/icons/Message.svg",
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
              child: Text("Next")),
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
    Navigator.pop(context);
  }

  void _onTapNextButton(){
    if(!_forgotEmailFormKey.currentState!.validate()){
      return;
    }

    Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPasswordOtpScreen(),));
   // Navigator.pushNamed(context, passwordRecoveryScreenRoute);



  }
}
