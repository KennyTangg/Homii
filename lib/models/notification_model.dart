class NotificationModel {
  final String id;
  final String type; // 'like', 'comment'
  final String username;
  final String postTitle;
  final String? comment;
  final DateTime timestamp;

  NotificationModel({
    required this.id,
    required this.type,
    required this.username,
    required this.postTitle,
    this.comment,
    required this.timestamp,
  });

  // Helper method to check if notification is from today
  bool get isToday {
    final now = DateTime.now();
    return timestamp.year == now.year &&
        timestamp.month == now.month &&
        timestamp.day == now.day;
  }

  // Helper method to check if notification is from yesterday
  bool get isYesterday {
    final now = DateTime.now();
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    return timestamp.year == yesterday.year &&
        timestamp.month == yesterday.month &&
        timestamp.day == yesterday.day;
  }
}
