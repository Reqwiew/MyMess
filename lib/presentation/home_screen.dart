import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final String? token;

  const HomeScreen({super.key, required this.token});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTab = 0;

  Widget _buildChatsContent() {
    return ListView.builder(
      itemCount: 10, // Замени на реальное количество чатов
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/user/user.png'),
          ),
          title: Text('Чат ${index + 1}'),
          subtitle: Text('Последнее сообщение...'),
          trailing: Text('12:30'),
        );
      },
    );
  }

  Widget _buildGroupsContent() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/group/group.png'),
          ),
          title: Text('Группа ${index + 1}'),
          subtitle: Text('Участников: 15'),
          trailing: Text('12:30'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFFE0EBF4),
        leading: Container(),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/profileScreen');
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFD9D9D9),
                  image: DecorationImage(
                    image: AssetImage('assets/user/user.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            SizedBox(width: 20),
            Text(
              "Главная",
              style: TextStyle(fontSize: 17, color: Color(0xFF5852CB)),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,

              ),
              child: TextField(
                decoration: InputDecoration(

                  hintText: 'Найти...',
                  border: UnderlineInputBorder(),

                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 20,
                  ),
                ),
              ),
            ),
          ),

          Container(
            height: 48,
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedTab = 0;
                      });
                    },
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Чаты',
                            style: TextStyle(
                              color: _selectedTab == 0
                                  ? Color(0xFF5852CB) // Фиолетовый когда активен
                                  : Colors.grey,      // Серый когда неактивен
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 8),
                          // Бордер только для активного таба и короче ширины
                          if (_selectedTab == 0)
                            Container(
                              width: 60, // Ширина бордера (можно регулировать)
                              height: 3,
                              decoration: BoxDecoration(
                                color: Color(0xFF5852CB),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedTab = 1;
                      });
                    },
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Группы',
                            style: TextStyle(
                              color: _selectedTab == 1
                                  ? Color(0xFF5852CB)
                                  : Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 8),
                          // Бордер только для активного таба и короче ширины
                          if (_selectedTab == 1)
                            Container(
                              width: 60, // Ширина бордера (можно регулировать)
                              height: 3,
                              decoration: BoxDecoration(
                                color: Color(0xFF5852CB),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _selectedTab == 0
                ? _buildChatsContent()
                : _buildGroupsContent(),
          ),
        ],
      ),
    );
  }
}