import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('API Test'),
        ),
        body: Center(
          child: TestAPI(),
        ),
      ),
    );
  }
}

class TestAPI extends StatefulWidget {
  @override
  _TestAPIState createState() => _TestAPIState();
}

class _TestAPIState extends State<TestAPI> {
  String _result = '';

  Future<void> getTitle() async {
    final response = await http.post(
      // Uri.parse('http://10.0.2.2:5000/title'), // For Android emulator, use '10.0.2.2'
      Uri.parse(
          'http://127.0.0.1:5000/title'), // For iOS emulator, use '127.0.0.1'
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'entry': 'This is a test diary entry.'}),
    );

    if (response.statusCode == 200) {
      setState(() {
        _result = jsonDecode(response.body)['title'];
      });
    } else {
      setState(() {
        _result = 'Error: ${response.statusCode}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(_result.isEmpty ? 'No result yet.' : _result),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: getTitle,
          child: const Text('Get Title'),
        ),
      ],
    );
  }
}
