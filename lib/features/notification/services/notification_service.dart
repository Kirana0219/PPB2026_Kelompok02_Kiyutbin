import 'package:flutter/material.dart';

import '../models/notification_model.dart';

class NotificationService {
  final List<NotificationModel> _notifications = [
    NotificationModel(
      id: "1",
      title: "Welcome to KIYUTBIN",
      message:
          "Thank you for joining KIYUTBIN. Let's learn and care for the environment together.",
      createdAt: DateTime.now().subtract(
        const Duration(minutes: 10),
      ),
      isRead: false,
      icon: Icons.waving_hand_rounded,
    ),

    NotificationModel(
      id: "2",
      title: "New Environmental Event",
      message:
          "Beach Cleanup will be held this Sunday. Don't miss it!",
      createdAt: DateTime.now().subtract(
        const Duration(hours: 2),
      ),
      isRead: false,
      icon: Icons.event,
    ),

    NotificationModel(
      id: "3",
      title: "Latest Blog Available",
      message:
          "Read our newest article about reducing plastic waste.",
      createdAt: DateTime.now().subtract(
        const Duration(days: 1),
      ),
      isRead: true,
      icon: Icons.article,
    ),

    NotificationModel(
      id: "4",
      title: "Waste Scanner",
      message:
          "Try our Waste Scanner feature to identify recyclable waste.",
      createdAt: DateTime.now().subtract(
        const Duration(days: 2),
      ),
      isRead: true,
      icon: Icons.document_scanner,
    ),
  ];

  Future<List<NotificationModel>> getNotifications() async {
    await Future.delayed(
      const Duration(milliseconds: 500),
    );

    return _notifications;
  }

  Future<void> markAsRead(String id) async {
    final notification = _notifications.firstWhere(
      (item) => item.id == id,
    );

    notification.isRead = true;
  }

  Future<void> deleteNotification(String id) async {
    _notifications.removeWhere(
      (item) => item.id == id,
    );
  }

  Future<void> markAllAsRead() async {
    for (final item in _notifications) {
      item.isRead = true;
    }
  }

  Future<void> clearAllNotifications() async {
  _notifications.clear();
  }

  int unreadCount() {
    return _notifications.where((item) => !item.isRead).length;
  }
}