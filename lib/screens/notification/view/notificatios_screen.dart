import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../models/notification_model.dart';
import 'notification_item.dart';

class NotificationsScreen extends StatelessWidget {
  final List<NotificationModel> notifications = [
    NotificationModel(
      title: 'Molestie libero neque sem cras enim, amet.',
      time: '2 min ago',
      icon: Icons.settings,
      color: Colors.redAccent,
    ),
    NotificationModel(
      title: 'Egestas nisl sapien amet lectus molestie id euismod.',
      time: '6 hours ago',
      icon: Icons.store,
      color: Colors.orangeAccent,
    ),
    NotificationModel(
      title: 'Ullamcorper ac ornare ipsum ut sed integer turpis felis viverra…',
      time: '4 days ago',
      icon: Icons.build,
      color: Colors.blueAccent,
    ),
    NotificationModel(
      title: 'Facilisis in proin ultrices in tincidunt adipiscing turpis praesent non.',
      time: '5 days ago',
      icon: Icons.location_on,
      color: Colors.greenAccent,
    ),
    NotificationModel(
      title: 'Pellentesque proin risus pellentesque odio a.',
      time: '1 week ago',
      icon: Icons.inventory,
      color: Colors.deepOrangeAccent,
    ),
    NotificationModel(
      title: 'Enim, proin ac ut nullam nec.',
      time: '1 week ago',
      icon: Icons.settings,
      color: Colors.redAccent,
    ),
  ];

   NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              "assets/icons/DotsV.svg",
              colorFilter: ColorFilter.mode(
                Theme.of(context).iconTheme.color!,
                BlendMode.srcIn,
              ),
            ),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return NotificationItem(notification: notifications[index]);
        },
      ),
    );
  }
}
