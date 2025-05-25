import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:daham/Data/group.dart';
import 'package:daham/Provider/group_provider.dart';

class GroupDetailPage extends StatelessWidget {
  final Group group;

  const GroupDetailPage({Key? key, required this.group}) : super(key: key);

  final String _currentUserId = 'myUserId'; // 추후 FirebaseAuth.uid로 대체

  @override
  Widget build(BuildContext context) {
    final isMember = group.members.contains(_currentUserId);
    final groupProvider = Provider.of<GroupProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text(group.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(group.description, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            Text('참여 인원: ${group.members.length} / ${group.maxMembers}'),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: group.progress,
              color: Colors.green,
              backgroundColor: Colors.green.withOpacity(0.2),
            ),
            const SizedBox(height: 8),
            Text('진행률: ${(group.progress * 100).toInt()}%'),
            const SizedBox(height: 24),

            // ✅ 조건에 따라 버튼 or 안내 메시지 표시
            if (!isMember)
              ElevatedButton(
                onPressed: () {
                  groupProvider.joinGroup(group.id, _currentUserId);
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('그룹에 참가했습니다')));
                  Navigator.pop(context); // 돌아가기 (옵션)
                },
                child: const Text('그룹 참가하기'),
              )
            else
              const Text(
                '✅ 이미 이 그룹에 속해 있습니다',
                style: TextStyle(color: Colors.grey),
              ),
          ],
        ),
      ),
    );
  }
}
