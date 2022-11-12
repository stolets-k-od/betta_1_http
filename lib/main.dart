import 'dart:io';

import 'package:betta_1_http/api.dart';
import 'package:betta_1_http/post.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Post> _posts = [];
  bool? preload;
  final api = ApiClient();

  Future<void> getPosts() async {
    setState(() {
      preload = true;
    });
    api.getPost().then((value) {
      _posts = value;
      sleep(const Duration(seconds: 3));
      setState(() {
        preload = false;
      });
    });
  }

  Widget ekran() {
    if (preload == null) {
      print('sized');
      return const SizedBox();
    } else if (preload == true) {
      print('circular');
      return const Center(child: CircularProgressIndicator());
    } else {
      print('listview');
      return ListView.builder(
        itemCount: _posts.length,
        itemBuilder: ((context, index) {
          return ListTile(
            leading: Text(_posts[index].id.toString()),
            title: Text(_posts[index].title),
            subtitle: Text(_posts[index].body),
          );
        }),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Посты:'),
      ),
      body: ekran(),

      // ListView.builder(
      //   itemCount: _posts.length,
      //   itemBuilder: ((context, index) {
      //     return ListTile(
      //       leading: Text(_posts[index].id.toString()),
      //       title: Text(_posts[index].title),
      //       subtitle: Text(_posts[index].body),
      //     );
      //   }),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: getPosts,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
