import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:daham/Data/group.dart';
import 'package:daham/provider/group_provider.dart';
import 'package:uuid/uuid.dart';

class GroupCreatePage extends StatefulWidget {
  @override
  _GroupCreatePageState createState() => _GroupCreatePageState();
}

class _GroupCreatePageState extends State<GroupCreatePage> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  int _maxMembers = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('그룹 만들기')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: '그룹 이름'),
            ),
            TextField(
              controller: _descController,
              decoration: InputDecoration(labelText: '그룹 설명'),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Text('최대 인원:'),
                SizedBox(width: 10),
                DropdownButton<int>(
                  value: _maxMembers,
                  onChanged: (value) => setState(() => _maxMembers = value!),
                  items:
                      [2, 3, 4, 5, 6, 7, 8]
                          .map(
                            (e) =>
                                DropdownMenuItem(value: e, child: Text('$e명')),
                          )
                          .toList(),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                final newGroup = Group(
                  id: Uuid().v4(),
                  title: _titleController.text,
                  description: _descController.text,
                  maxMembers: _maxMembers,
                  members: [],
                );
                Provider.of<GroupProvider>(
                  context,
                  listen: false,
                ).createGroup(newGroup);
                Navigator.pop(context);
              },
              child: Text('생성'),
            ),
          ],
        ),
      ),
    );
  }
}
