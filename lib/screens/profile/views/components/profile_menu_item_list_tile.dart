import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../components/list_tile/divider_list_tile.dart';

class ProfileMenuListTile extends StatelessWidget {
  const ProfileMenuListTile({
    super.key,
    required this.text,
    required this.svgSrc,
    required this.press,
    this.isShowDivider = true,
  });

  final String text, svgSrc;
  final VoidCallback press;
  final bool isShowDivider;

  @override
  Widget build(BuildContext context) {
    return DividerListTile(

      minLeadingWidth: 24,
      leading: SvgPicture.asset(
        svgSrc,
        height: 30,
        width: 30,
        colorFilter: ColorFilter.mode(
          Theme.of(context).iconTheme.color!,
          BlendMode.srcIn,
        ),
      ),
      title: Text(
        text,
        style: const TextStyle(fontSize: 16, height: 1,fontWeight: FontWeight.w500),
      ),
      press: press,
      isShowDivider: isShowDivider,
    );
  }
}
