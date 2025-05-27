import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:daham/Data/group.dart';
import 'package:daham/Data/task.dart';
import 'package:daham/Provider/group_provider.dart';
import 'task_create.dart';

class GroupDetailPage extends StatefulWidget {
  final Group group;

  const GroupDetailPage({super.key, required this.group});

  @override
  State<GroupDetailPage> createState() => _GroupDetailPageState();
}

class _GroupDetailPageState extends State<GroupDetailPage> {
  Task? selectedTask;

  final String currentUserId = 'myUserId'; // ✅ 나중에 FirebaseAuth.uid로 대체

  @override
  Widget build(BuildContext context) {
    final group = widget.group;
    final isMember = group.members.contains(currentUserId);
    final taskList = group.tasks;

    return Scaffold(
      appBar: AppBar(title: Text(group.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ 공통 상단 영역
            Card(
              child: ListTile(
                title: Text(group.title),
                subtitle: Text('현재 ${group.members.length}명 참여 중'),
                trailing: CircleAvatar(
                  child: Text('${(group.progress * 100).toInt()}%'),
                ),
              ),
            ),
            const SizedBox(height: 16),

            if (!isMember) ...[
              const Text('👥 그룹 참여자'),
              ...group.members.map((m) => ListTile(title: Text(m))),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Provider.of<GroupProvider>(
                    context,
                    listen: false,
                  ).joinGroup(group.id, currentUserId);
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('그룹에 가입되었습니다')));
                  setState(() {});
                },
                child: const Text('그룹 가입하기'),
              ),
            ] else ...[
              // ✅ 그룹 과제 드롭다운
              DropdownButton<Task>(
                value: selectedTask,
                hint: const Text('그룹 과제 선택'),
                isExpanded: true,
                items:
                    taskList.map((task) {
                      return DropdownMenuItem(
                        value: task,
                        child: Text('${task.title} (${task.subject})'),
                      );
                    }).toList(),
                onChanged: (task) {
                  setState(() => selectedTask = task);
                },
              ),
              const SizedBox(height: 16),

              // ✅ 과제 참여자별 진행률
              if (selectedTask != null)
                Expanded(
                  child: ListView.builder(
                    itemCount: selectedTask!.memberProgress.length,
                    itemBuilder: (context, index) {
                      final userId = selectedTask!.memberProgress.keys
                          .elementAt(index);
                      var progress = selectedTask!.memberProgress[userId]!;
                      final isMe = userId == currentUserId;
                      return ListTile(
                        leading: CircleAvatar(child: Text(userId[0])),
                        title:
                            isMe
                                ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    LinearProgressIndicator(value: progress),
                                    Slider(
                                      value: progress,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedTask!.memberProgress[userId] =
                                              value;

                                          widget.group.progress =
                                              calculateGroupProgress(
                                                widget.group,
                                              );
                                        });
                                      },
                                    ),
                                  ],
                                )
                                : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    LinearProgressIndicator(value: progress),
                                  ],
                                ),
                        trailing: Text('${(progress * 100).toInt()}%'),
                      );
                    },
                  ),
                )
              else
                const Center(child: Text('과제를 선택해주세요')),
            ],
          ],
        ),
      ),

      // ✅ FAB도 "내가 속한 멤버일 때만" 보이도록 조건부 처리
      floatingActionButton:
          isMember
              ? FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () async {
                  await showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (_) => TaskCreateModal(group: group),
                  );
                  setState(() {});
                },
              )
              : null,
    );
  }
}

// 그룹의 전체 과제 진행률 계산
double calculateGroupProgress(Group group) {
  final tasks = group.tasks;
  if (tasks.isEmpty) return 0.0;

  final totalProgress = tasks
      .map((task) => task.memberProgress.values.fold(0.0, (a, b) => a + b))
      .fold(0.0, (a, b) => a + b);

  final totalCount = tasks
      .map((task) => task.memberProgress.length)
      .fold(0, (a, b) => a + b);

  return totalCount == 0 ? 0.0 : totalProgress / totalCount;
}
