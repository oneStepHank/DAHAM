import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:daham/Data/group.dart';
import 'package:daham/Provider/group_provider.dart';
import 'package:uuid/uuid.dart';

class GroupCreatePage extends StatefulWidget {
  const GroupCreatePage({super.key});

  @override
  State<GroupCreatePage> createState() => _GroupCreatePageState();
}

class _GroupCreatePageState extends State<GroupCreatePage> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  int _maxMembers = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('그룹 만들기')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: '그룹 이름'),
            ),
            TextField(
              controller: _descController,
              decoration: const InputDecoration(labelText: '그룹 설명'),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text('최대 인원:'),
                const SizedBox(width: 10),
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
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final newGroup = Group(
                  id: const Uuid().v4(),
                  title: _titleController.text,
                  description: _descController.text,
                  maxMembers: _maxMembers,
                  members: [],
                );

                Provider.of<GroupProvider>(
                  context,
                  listen: false,
                ).createGroup(newGroup);

                Navigator.pop(context); // 생성 후 뒤로 이동
              },
              child: const Text('생성'),
            ),
          ],
        ),
      ),
    );
  }
}
