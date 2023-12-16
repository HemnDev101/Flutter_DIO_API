import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:json_serializatoin_project/data/user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<User> user = [];
  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();
  }

  void getData() async {
    final dio = Dio();
    final response =
        await dio.get('https://jsonplaceholder.typicode.com/users');
    //respomse => Response<dynamic>
    //response.data => List<dynamic>
    // print(response.data[1]);  => _Map<String, dynamic>
    for (int i = 0; i < response.data.length; i++) {
      user.add(User.fromJson(response.data[i]));
      final a = User.fromJson(response.data[i]);
      print(user.first.name);
    }
    //   User.fromJson(response.data. );
    // print(response);
  }

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      getData();
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: user.length,
        itemBuilder: (context, index) => Card(
          child: Column(
            children: [
              Text(
                "${user[index].name}",
                style: TextStyle(fontSize: 20),
              ),
              Text("${user[index].email}"),
            ],
          ),
          color: Colors.pink[50],
          margin: EdgeInsets.symmetric(vertical: 16),
        ), 
      ),
    );
  }
}
