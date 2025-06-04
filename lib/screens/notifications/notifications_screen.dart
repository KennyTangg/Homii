import 'package:flutter/material.dart';
import 'package:homii/models/notification_model.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  // Sample notification data
  final List<NotificationModel> _notifications = [
    // Today's notifications
    NotificationModel(
      id: '1',
      type: 'comment',
      username: 'Seola',
      postTitle: 'tried this, soo yummy!!!',
      timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
    ),
    NotificationModel(
      id: '2',
      type: 'milk_expiry',
      username: 'Homii',
      postTitle: 'Your milk is about to expire! Click here to search for recipes with milk.',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    NotificationModel(
      id: '3',
      type: 'like',
      username: 'Seola',
      postTitle: 'Baked Crunchy Hot Honey Chicken',
      timestamp: DateTime.now().subtract(const Duration(hours: 3)),
    ),
    NotificationModel(
      id: '4',
      type: 'like',
      username: 'Nicole',
      postTitle: 'Baked Crunchy Hot Honey Chicken',
      timestamp: DateTime.now().subtract(const Duration(hours: 4)),
    ),

    // Yesterday's notifications
    NotificationModel(
      id: '5',
      type: 'like',
      username: 'Stacey',
      postTitle: 'Baked Crunchy Hot Honey Chicken',
      timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
    ),
    NotificationModel(
      id: '6',
      type: 'like',
      username: 'Randy',
      postTitle: 'Baked Crunchy Hot Honey Chicken',
      timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 4)),
    ),
    NotificationModel(
      id: '7',
      type: 'like',
      username: 'Andy',
      postTitle: 'Baked Crunchy Hot Honey Chicken',
      timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 6)),
    ),
    NotificationModel(
      id: '8',
      type: 'comment',
      username: 'Andy',
      postTitle: 'Delicious, but a bit dry.',
      timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 8)),
    ),

    // Last 7 days notifications
    NotificationModel(
      id: '9',
      type: 'like',
      username: 'user2315',
      postTitle: 'Baked Crunchy Hot Honey Chicken',
      timestamp: DateTime.now().subtract(const Duration(days: 3)),
    ),
    NotificationModel(
      id: '10',
      type: 'follow',
      username: 'user2315',
      postTitle: 'started following you.',
      timestamp: DateTime.now().subtract(const Duration(days: 4)),
    ),
    NotificationModel(
      id: '11',
      type: 'like',
      username: 'user2315',
      postTitle: 'Baked Crunchy Hot Honey Chicken',
      timestamp: DateTime.now().subtract(const Duration(days: 5)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Filter notifications by day
    final todayNotifications = _notifications.where((n) => n.isToday).toList();
    final yesterdayNotifications = _notifications.where((n) => n.isYesterday).toList();
    final lastSevenDaysNotifications = _notifications.where((n) => n.isLastSevenDays).toList();

    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        title: Text(
          'Notifications',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView(
                  children: [
                    if (todayNotifications.isNotEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'Today',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ),
                      ...todayNotifications.map((notification) =>
                        _buildNotificationItem(notification, colorScheme)
                      ),
                    ],
                    if (yesterdayNotifications.isNotEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'Yesterday',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ),
                      ...yesterdayNotifications.map((notification) =>
                        _buildNotificationItem(notification, colorScheme)
                      ),
                    ],
                    if (lastSevenDaysNotifications.isNotEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'Last 7 days',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ),
                      ...lastSevenDaysNotifications.map((notification) =>
                        _buildNotificationItem(notification, colorScheme)
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationItem(NotificationModel notification, ColorScheme colorScheme) {
    IconData iconData;
    Color iconColor;

    switch (notification.type) {
      case 'like':
        iconData = Icons.favorite;
        iconColor = Colors.red;
        break;
      case 'comment':
        iconData = Icons.chat_bubble;
        iconColor = colorScheme.primary;
        break;
      case 'follow':
        iconData = Icons.person_add;
        iconColor = colorScheme.secondary;
        break;
      case 'milk_expiry':
        iconData = Icons.warning;
        iconColor = Colors.orange;
        break;
      default:
        iconData = Icons.person;
        iconColor = colorScheme.primary;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: notification.type == 'milk_expiry'
                ? Colors.orange.withAlpha(51)
                : colorScheme.primary.withAlpha(51),
            child: Icon(
              iconData,
              color: iconColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildNotificationText(notification, colorScheme),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationText(NotificationModel notification, ColorScheme colorScheme) {
    if (notification.type == 'milk_expiry') {
      return Text(
        notification.postTitle,
        style: TextStyle(
          fontSize: 14,
          color: colorScheme.onSurface,
          height: 1.4,
        ),
      );
    }

    if (notification.type == 'follow') {
      return RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: 14,
            color: colorScheme.onSurface,
            height: 1.4,
          ),
          children: [
            TextSpan(
              text: notification.username,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            TextSpan(
              text: ' ${notification.postTitle}',
            ),
          ],
        ),
      );
    }

    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 14,
          color: colorScheme.onSurface,
          height: 1.4,
        ),
        children: [
          TextSpan(
            text: notification.username,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          TextSpan(
            text: notification.type == 'like'
              ? ' liked your post '
              : ' commented on your post: ',
          ),
          TextSpan(
            text: '"${notification.postTitle}"',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: notification.type == 'like'
                ? colorScheme.secondary
                : colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
