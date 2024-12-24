import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


import '../../../components/list_tile/divider_list_tile.dart';
import '../../../components/network_image_with_loader.dart';
import '../../../constants.dart';
import '../../../route/route_constants.dart';
import '../../bookmark/views/bookmark_screen.dart';
import '../../checkout/views/order_screen.dart';
import 'components/profile_card.dart';
import 'components/profile_menu_item_list_tile.dart';
import 'components/user_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(

        children: [
          Image.asset("assets/images/background.gif",height: context.height,width: context.width,fit: BoxFit.cover,),
          ListView(
            children: [
             // SizedBox(height: 20,),
              SizedBox(
                height: 150,
                width: context.width,
                child: Center(
                  child: ListTile(
                    onTap: (){},
                    leading: CircleAvatar(

                      radius: 28,
                      child: NetworkImageWithLoader(
                        "https://i.imgur.com/IXnwbLk.png",
                        radius: 110,
                      ),
                    ),
                    title: Row(
                      children: [
                        Text(
                           "Hi, Sepide" ,
                          style: const TextStyle(fontWeight: FontWeight.w500,color: Colors.black,fontSize: 21),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(width: defaultPadding / 2),

                      ],
                    ),
                    subtitle: Text("theflutterway@gmail.com",style:TextStyle(color: Colors.black,fontSize: 17)),
                    trailing:
                        SvgPicture.asset(
                      "assets/icons/miniRight.svg",
                      color: Colors.white,width: 36,
                    )
                        ,
                  ),
                ),
              ),




              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10,),
                child: Column(
                  children: [

                    Text("Account",style: TextStyle(color: Colors.black87,fontSize: 27,fontWeight: FontWeight.w500),),
                    SizedBox(height: 5,),
                    /*Center(
                      child: Text(
                        "Account",
                        style: TextStyle(color: Colors.cyan,fontSize: 35),
                      ),
                    ),*/
                    const SizedBox(height: defaultPadding / 2),
                    ProfileMenuListTile(
                      isShowDivider: false,
                      text: "Orders",
                      svgSrc: "assets/icons/Order.svg",
                      press: () {
                        //Navigator.pushNamed(context, ordersScreenRoute);
                        Get.to(()=> OrderScreen());
                      },
                    ),
                    /*ProfileMenuListTile(
                      text: "Returns",
                      svgSrc: "assets/icons/Return.svg",
                      press: () {},
                    ),*/
                    ProfileMenuListTile(
                      isShowDivider: false,
                      text: "Wishlist",
                      svgSrc: "assets/icons/Wishlist.svg",
                      press: () {
                        Get.to(()=>const BookmarkScreen());
                      },
                    ),
                    ProfileMenuListTile(
                      isShowDivider: false,
                      text: "Addresses",
                      svgSrc: "assets/icons/Address.svg",
                      press: () {
                        Navigator.pushNamed(context, addressesScreenRoute);
                      },
                    ),
                    /*
                    ProfileMenuListTile(
                      text: "Payment",
                      svgSrc: "assets/icons/card.svg",
                      press: () {
                        Navigator.pushNamed(context, emptyPaymentScreenRoute);
                      },
                    ),
                    ProfileMenuListTile(
                      text: "Wallet",
                      svgSrc: "assets/icons/Wallet.svg",
                      press: () {
                        Navigator.pushNamed(context, walletScreenRoute);
                      },
                    ),*//*
                    const SizedBox(height: defaultPadding),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding, vertical: defaultPadding / 2),
                      child: Text(
                        "Personalization",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    DividerListTileWithTrilingText(
                      svgSrc: "assets/icons/Notification.svg",
                      title: "Notification",
                      trilingText: "Off",
                      press: () {
                        Navigator.pushNamed(context, enableNotificationScreenRoute);
                      },
                    ),
                    ProfileMenuListTile(
                      text: "Preferences",
                      svgSrc: "assets/icons/Preferences.svg",
                      press: () {
                        Navigator.pushNamed(context, preferencesScreenRoute);
                      },
                    ),
                    const SizedBox(height: defaultPadding),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding, vertical: defaultPadding / 2),
                      child: Text(
                        "Settings",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    ProfileMenuListTile(
                      text: "Language",
                      svgSrc: "assets/icons/Language.svg",
                      press: () {
                        Navigator.pushNamed(context, selectLanguageScreenRoute);
                      },
                    ),
                    */
                    ProfileMenuListTile(
                      isShowDivider: false,
                      text: "Location",
                      svgSrc: "assets/icons/Location.svg",
                      press: () {},
                    ),
                    ProfileMenuListTile(
                      isShowDivider: false,
                      text: "Get Help",
                      svgSrc: "assets/icons/Help.svg",
                      press: () {
                        Navigator.pushNamed(context, getHelpScreenRoute);
                      },
                    ),
                    ProfileMenuListTile(

                      text: "FAQ",
                      svgSrc: "assets/icons/FAQ.svg",
                      press: () {},
                      isShowDivider: false,
                    ),
                    const SizedBox(height: defaultPadding),


                  ],
                ),
              ),
              SizedBox(height: 30,),


              Row(
                children: [
                  SizedBox(width: 120,),
                  TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        fixedSize: const Size(150, 50),
                        side: BorderSide(
                            color: Colors.blue
                        ),
                        shape: RoundedRectangleBorder(

                            borderRadius: BorderRadius.circular(8)),
                      ),

                      onPressed: (){}, child: Text("Log out",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),)),
                ],
              ),

              // Log Out
             /* ListTile(
                onTap: () {},
                minLeadingWidth: 24,
                leading: SvgPicture.asset(
                  "assets/icons/Logout.svg",
                  height: 24,
                  width: 24,
                  colorFilter: const ColorFilter.mode(
                    errorColor,
                    BlendMode.srcIn,
                  ),
                ),
                title: const Text(
                  "Log Out",
                  style: TextStyle(color: errorColor, fontSize: 14, height: 1),
                ),
              )*/
            ],
          ),
        ],
      ),
    );
  }
}
