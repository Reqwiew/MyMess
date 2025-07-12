
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
  int _counter = 0;
  String? storedToken;
  void _incrementCounter() => setState(() => _counter++);

  Future<void> _copyToClipboard(String token) async {
    await Clipboard.setData(ClipboardData(text: token));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Токен скопирован в буфер обмена!')),
    );
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    setState(() {
      storedToken = null;
    });
    print(prefs);
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Главная')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Вы нажали кнопку столько раз:'),
            Text('$_counter'),
            const SizedBox(height: 20),
            Text('Device Token:\n${widget.token ?? "Нет токена"}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: widget.token != null
                  ? () => _copyToClipboard(widget.token!)
                  : null,
              child: const Text('Скопировать токен'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/register'),
              child: const Text('Перейти в регистрацию'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/login'),
              child: const Text('Перейти в логин'),
            ),
            ElevatedButton(
              onPressed: _logout,
              child: const Text('Очистить токен и выйти'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        child: const Icon(Icons.add),
      ),
    );
  }
}
