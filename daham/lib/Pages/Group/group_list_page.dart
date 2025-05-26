import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:daham/Provider/group_provider.dart';
import 'group_create.dart';
import 'group_join.dart';
import 'all_group_page.dart';
import 'my_group_page.dart';

class GroupListPage extends StatelessWidget {
  const GroupListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('그룹'),
          bottom: const TabBar(tabs: [Tab(text: '전체 그룹'), Tab(text: '나의 그룹')]),
        ),
        body: const TabBarView(children: [AllGroupsPage(), MyGroupsPage()]),
        // ✅ FloatingActionButton은 Scaffold의 속성으로 여기 위치해야 함
        floatingActionButton: Builder(
          builder:
              (innerContext) => FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () {
                  showModalBottomSheet(
                    context: innerContext,
                    builder:
                        (_) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              title: const Text('그룹 만들기'),
                              onTap: () {
                                Navigator.pop(innerContext);
                                Navigator.push(
                                  innerContext,
                                  MaterialPageRoute(
                                    builder: (_) => const GroupCreatePage(),
                                  ),
                                );
                              },
                            ),
                            ListTile(
                              title: const Text('그룹 검색'),
                              onTap: () {
                                Navigator.pop(innerContext);
                                Navigator.push(
                                  innerContext,
                                  MaterialPageRoute(
                                    builder: (_) => const GroupJoinPage(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                  );
                },
              ),
        ),
      ),
    );
  }
}
