import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 상단 사용자 정보 + 캘린더
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 24,
                    backgroundImage: AssetImage('assets/user.png'), // 사용자 이미지
                  ),
                  const SizedBox(width: 12),
                  const Text('사용자명', style: TextStyle(fontSize: 16)),
                  const Spacer(),
                  const Icon(Icons.circle, size: 16), // 블랙 점
                  const SizedBox(width: 8),
                  const Icon(Icons.signal_cellular_alt),
                  const Icon(Icons.battery_full),
                ],
              ),
            ),
            // 날짜 바
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('월'),
                  Text('화'),
                  Text('수'),
                  Text(
                    '목',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('금'),
                  Text('토'),
                  Text('일'),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 4, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Text('6'),
                  Text('7'),
                  Text('8'),
                  Text('9', style: TextStyle(color: Colors.blue)),
                  Text('10'),
                  Text('11'),
                  Text('12'),
                ],
              ),
            ),
            // 퍼센트 인디케이터
            CircularPercentIndicator(
              radius: 60.0,
              lineWidth: 12.0,
              percent: 0.6,
              center: const Text(
                "60%",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              progressColor: Colors.yellow.shade600,
              backgroundColor: Colors.yellow.shade100,
              circularStrokeCap: CircularStrokeCap.round,
            ),
            const SizedBox(height: 16),
            // 할 일 목록
            Expanded(
              child: ListView(
                children: const [
                  TodoItem(
                    title: "알고리즘",
                    subtitle: "HW1_2 제출하기",
                    checked: true,
                  ),
                  TodoItem(
                    title: "OS 그룹스터디",
                    subtitle: "상상랩8 / 19:00-",
                    checked: false,
                  ),
                  TodoItem(
                    title: "새새밥고",
                    subtitle: "학관 14:00-",
                    checked: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // 우측 하단 +
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.white,
        child: const Icon(Icons.add, color: Colors.blue),
      ),
      // 하단 탭바
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black54,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.groups), label: '그룹'),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: '채팅',
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              radius: 12,
              backgroundImage: AssetImage('assets/user.png'),
            ),
            label: 'MY',
          ),
        ],
      ),
    );
  }
}

class TodoItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool checked;

  const TodoItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.checked,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        checked ? Icons.check_circle : Icons.radio_button_unchecked,
        color: checked ? Colors.blue : Colors.grey,
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 13)),
    );
  }
}
