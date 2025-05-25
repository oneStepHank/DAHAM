import 'package:daham/Provider/group_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'group_detail.dart';
import 'group_create.dart';
import 'group_join.dart';

class GroupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('그룹')),
      body: Consumer<GroupProvider>(
        builder: (context, provider, _) {
          final groups = provider.groups;

          if (groups.isEmpty) {
            return Center(child: Text('참여 중인 그룹이 없습니다.'));
          }

          return ListView.builder(
            itemCount: groups.length,
            itemBuilder: (context, index) {
              final group = groups[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => GroupDetailPage(group: group),
                    ),
                  );
                },
                child: Card(
                  margin: EdgeInsets.all(12),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          group.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text('현재 ${group.members.length}명 참여중'),
                        SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: group.progress,
                          color: Colors.green,
                          backgroundColor: Colors.green.withOpacity(0.2),
                        ),
                        SizedBox(height: 4),
                        Text('진행률 ${(group.progress * 100).toInt()}%'),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder:
                (_) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      title: Text('그룹 만들기'),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => GroupCreatePage()),
                        );
                      },
                    ),
                    ListTile(
                      title: Text('그룹 참가'),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => GroupJoinPage()),
                        );
                      },
                    ),
                  ],
                ),
          );
        },
      ),
    );
  }
}
