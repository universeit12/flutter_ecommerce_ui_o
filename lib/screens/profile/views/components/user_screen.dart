import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_ui_o/screens/profile/views/components/edit_profile_screen.dart';
import 'package:flutter_ecommerce_ui_o/screens/profile/views/components/profile_card.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../auth/views/components/change_password.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
        actions: [
          TextButton(onPressed: (){
            Get.to(()=>EditProfileScreen());
          }, child: Text("Edit")),
          SizedBox(width: 15,),
        ],
      ),
      body: Column(children: [
        SizedBox(height: 10,),
        Center(
          child: Stack(

            children: [
              Container(
                height: 90,
                width: 150,
                child: CircleAvatar(
                  backgroundImage: NetworkImage("https://i.imgur.com/IXnwbLk.png",),

                ),

              ),

            ],
          ),
        ),
        SizedBox(height: 5,),
        Text("Wali Ullah Ripon",style: TextStyle(color: Colors.black),),
        SizedBox(height: 5,),
        Text("waliullah8328@gmail.com",style: TextStyle(color: Colors.black),),

        SizedBox(height: 30,),

        Align(
          alignment: Alignment.center,
            child: Text("Personal Information",style: TextStyle(color: Colors.black26,fontWeight: FontWeight.w500,fontSize: 27),)),
        SizedBox(height: 30,),

        _buildProfileInfo(title: "Name",value: "Wali Ullah Ripon",),
        _buildProfileInfo(title: "Date of Birth",value: "15/12/2002",),
        _buildProfileInfo(title: "Phone Number",value: "01751138328",),
        _buildProfileInfo(title: "Gender",value: "Male",),
        _buildProfileInfo(title: "Email",value: "waliullah8328@gmail.com",),
        Padding(
          padding: const EdgeInsets.only(left: 28,right: 28,bottom: 8),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Text("Password",style: const TextStyle(fontSize: 15),),
                  TextButton(onPressed: (){
                    Get.to(()=>ChangePasswordScreen());
                  }, child: Text("Change Password")),
                ],),

            ],
          ),
        )
      ],),
    );
  }
}

class _buildProfileInfo extends StatelessWidget {
  const _buildProfileInfo({
    super.key, this.title, this.value,
  });
  final String? title,value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 28,right: 28,bottom: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

            Text(title!,style: const TextStyle(fontSize: 15),),
            Text(value!,style: const TextStyle(fontSize: 16,color: Colors.black87),),
          ],),
          const SizedBox(height: 10,),
          const Divider(),
        ],
      ),
    );
  }
}
