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
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    NotificationModel(
      id: '2',
      type: 'like',
      username: 'Seola',
      postTitle: 'Baked Crunchy Hot Honey Chicken',
      timestamp: DateTime.now().subtract(const Duration(hours: 4)),
    ),
    NotificationModel(
      id: '3',
      type: 'like',
      username: 'Nicole',
      postTitle: 'Baked Crunchy Hot Honey Chicken',
      timestamp: DateTime.now().subtract(const Duration(hours: 6)),
    ),

    // Yesterday's notifications
    NotificationModel(
      id: '4',
      type: 'like',
      username: 'Stacey',
      postTitle: 'Baked Crunchy Hot Honey Chicken',
      timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
    ),
    NotificationModel(
      id: '5',
      type: 'like',
      username: 'Randy',
      postTitle: 'Baked Crunchy Hot Honey Chicken',
      timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 4)),
    ),
    NotificationModel(
      id: '6',
      type: 'like',
      username: 'Andy',
      postTitle: 'Baked Crunchy Hot Honey Chicken',
      timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 6)),
    ),
    NotificationModel(
      id: '7',
      type: 'comment',
      username: 'Andy',
      postTitle: 'Delicious, but a bit dry.',
      timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 8)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Filter notifications by day
    final todayNotifications = _notifications.where((n) => n.isToday).toList();
    final yesterdayNotifications = _notifications.where((n) => n.isYesterday).toList();

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

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: colorScheme.primary.withAlpha(51), // 0.2 opacity
            child: Icon(
              Icons.person,
              color: colorScheme.primary,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
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
            ),
          ),
        ],
      ),
    );
  }
}
