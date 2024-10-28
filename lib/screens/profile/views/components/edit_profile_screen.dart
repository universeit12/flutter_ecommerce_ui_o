import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../constants.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
        actions: [
          SvgPicture.asset(
            "assets/icons/info.svg",
            height: 32,
            width: 32,
            colorFilter: ColorFilter.mode(
                Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .color!
                    .withOpacity(0.3),
                BlendMode.srcIn),
          ),
          SizedBox(width: 12,),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
        
          children: [
            SizedBox(height: 10,),
            Center(
              child: Stack(
        
                children: [
                  Container(
                    height: 130,
                    width: 200,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage("https://i.imgur.com/IXnwbLk.png",),
        
                    ),
        
                  ),
                  Positioned(
                    right: 30,
                    bottom: 10,
                    child: Stack(
                      children: [
                        Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(45),
                          ),
        
                        ),
                        Positioned(
                          right: 2,
                          bottom: 2,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Icon(Icons.edit,color: Colors.white,),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 15,),
            Text("Edit Profile",style: TextStyle(color: Colors.blue,fontSize: 16),),
        
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  TextFormField(
                    onSaved: (emal) {
                      // Email
                    },
                    validator: emaildValidator.call,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Name",
                      prefixIcon: Padding(
                        padding:
                        const EdgeInsets.symmetric(vertical: defaultPadding * 0.75),
                        child: SvgPicture.asset(
                          "assets/icons/Profile.svg",
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
                  const SizedBox(height: defaultPadding),
                  TextFormField(
                    onSaved: (emal) {
                      // Email
                    },
                    validator: emaildValidator.call,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Email address",
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
                      ),
                    ),
                  ),
                  const SizedBox(height: defaultPadding),
                  TextFormField(
                    onSaved: (emal) {
                      // Email
                    },
                    validator: emaildValidator.call,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Date of Birth",
                      prefixIcon: Padding(
                        padding:
                        const EdgeInsets.symmetric(vertical: defaultPadding * 0.75),
                        child: SvgPicture.asset(
                          "assets/icons/Calender.svg",
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
                  const SizedBox(height: defaultPadding),
                  TextFormField(
                    onSaved: (emal) {
                      // Email
                    },
                    validator: emaildValidator.call,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Phone Number",
                      prefixIcon: Padding(
                        padding:
                        const EdgeInsets.symmetric(vertical: defaultPadding * 0.75),
                        child: SvgPicture.asset(
                          "assets/icons/Call.svg",
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
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
        
                    },
                    child: const Text("Done"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
