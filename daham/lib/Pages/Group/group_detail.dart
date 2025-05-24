import 'package:flutter/material.dart';
import 'package:daham/Data/group.dart';

class GroupDetailPage extends StatelessWidget {
  final Group group;

  const GroupDetailPage({Key? key, required this.group}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(group.title)),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(group.description, style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
            Text('참여 인원: ${group.members.length} / ${group.maxMembers}'),
            SizedBox(height: 16),
            LinearProgressIndicator(
              value: group.progress,
              color: Colors.green,
              backgroundColor: Colors.green.withOpacity(0.2),
            ),
            SizedBox(height: 8),
            Text('진행률: ${(group.progress * 100).toInt()}%'),
          ],
        ),
      ),
    );
  }
}
