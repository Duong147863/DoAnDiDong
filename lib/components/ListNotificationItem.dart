import 'package:doandidongappthuongmai/models/load_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class NotificationItem extends StatelessWidget {
  final NotificationData data;
  const NotificationItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
   return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 13),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.pink[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 0.5, color: Colors.black),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Độ trong suốt 50%
            spreadRadius: 1, // Xác định mức độ mà bóng sẽ lan rộng
            blurRadius: 4, // Bán kính mờ xác định độ mờ của bóng
            offset: Offset(0, 2), // Khoảng cách mà bóng sẽ được dịch chuyển
          ),
        ],
      ),
      child: Row(
          children: [
            Icon(Icons.notifications), 
            SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text( data.title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(data.description, style: TextStyle(fontSize: 16),softWrap: true,maxLines: 2),
                ],
              ),
            ),
            // Time
            Text(
            DateFormat('HH:mm dd-MM-yy').format(data.time),
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          ],
        ),
    );
  }
}
