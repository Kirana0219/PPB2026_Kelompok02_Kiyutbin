import 'package:flutter/material.dart';

import '../../../core/layout/widgets/app_header.dart';
import '../../../core/theme/app_text_styles.dart';
import '../models/notification_model.dart';
import '../services/notification_service.dart';
import '../widgets/notification_card.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotificationService _notificationService = NotificationService();

  List<NotificationModel> _notifications = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    final data = await _notificationService.getNotifications();

    setState(() {
      _notifications = data;
      _isLoading = false;
    });
  }

 Future<void> _markAllAsRead() async {
  final confirm = await showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        content: SizedBox(
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Are you sure you want to remove all notifications?",
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 24),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade300,
                        foregroundColor: Colors.black87,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text("Cancel"),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0D631B),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text("Clear"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );

  if (confirm != true) return;

  await _notificationService.clearAllNotifications();

  setState(() {
    _notifications.clear();
  });
}

  Future<void> _markAsRead(NotificationModel notification) async {
    await _notificationService.markAsRead(notification.id);

    setState(() {
      _notifications.clear();
    });
  }

  Future<void> _deleteNotification(NotificationModel notification) async {
    await _notificationService.deleteNotification(notification.id);

    setState(() {
      _notifications.remove(notification);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(showBackButton: true, showProfileAvatar: false),

      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadNotifications,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
                    child: Row(
                      children: [
                        Text("Notifications", style: AppTextStyles.heading),

                        const Spacer(),

                        TextButton(
                          onPressed: _notifications.isEmpty
                              ? null
                              : _markAllAsRead,
                          child: const Text("Clear All"),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: _notifications.isEmpty
                        ? ListView(
                            children: const [
                              SizedBox(height: 120),

                              Icon(
                                Icons.notifications_off_outlined,
                                size: 80,
                                color: Colors.grey,
                              ),

                              SizedBox(height: 20),

                              Center(
                                child: Text(
                                  "No Notifications",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),

                              SizedBox(height: 8),

                              Center(
                                child: Text(
                                  "You don't have any notifications yet.",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            itemCount: _notifications.length,
                            itemBuilder: (context, index) {
                              final notification = _notifications[index];

                              return NotificationCard(
                                notification: notification,

                                onTap: () async {
                                  await _markAsRead(notification);
                                },

                                onDelete: () async {
                                  await _deleteNotification(notification);
                                },
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
    );
  }
}
