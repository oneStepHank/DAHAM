import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:daham/provider/group_provider.dart';

class GroupJoinPage extends StatefulWidget {
  @override
  _GroupJoinPageState createState() => _GroupJoinPageState();
}

class _GroupJoinPageState extends State<GroupJoinPage> {
  final _searchController = TextEditingController();
  String? foundGroupId;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GroupProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('그룹 참가')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(labelText: '그룹 이름'),
            ),
            ElevatedButton(
              onPressed: () {
                final group = provider.searchGroupByName(
                  _searchController.text,
                );
                if (group != null) {
                  setState(() => foundGroupId = group.id);
                } else {
                  setState(() => foundGroupId = null);
                }
              },
              child: Text('검색'),
            ),
            if (foundGroupId != null)
              ElevatedButton(
                onPressed: () {
                  provider.joinGroup(foundGroupId!, 'sampleUserId');
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('참가 완료')));
                  Navigator.pop(context);
                },
                child: Text('참가하기'),
              )
            else if (_searchController.text.isNotEmpty)
              Text('그룹을 찾을 수 없습니다.'),
          ],
        ),
      ),
    );
  }
}
