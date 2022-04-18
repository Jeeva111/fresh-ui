library fresh_ui;

import 'package:flutter/material.dart';
import 'package:fresh_ui/forms/forms.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final String text = _controller.text.toLowerCase();
      print(text);
      _controller.value = _controller.value.copyWith(
        text: text,
        selection:
            TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      TextInput(
        label: "Enter Name",
        onTextChange: print,
      ),
      Button(child: Text("Hello"), onPressed: () => print),
      SearchUI(
        placeholder: "Search keyword",
      ),
      FormInput(
        label: "MobileNumber",
        onTextChange: print,
        hintText: "0923423",
      ),
      FormRadio(
        label: "Pre Order",
        options: [
          {"key": "1", "value": "Yes"},
          {"key": "2", "value": "No"}
        ],
        onPressed: (selected, index) => print(selected),
      ),
      FormDropdown(
        hintText: "Choose a items . . .",
        dropDownLists: [
          {"key": "1", "value": "Yes"},
          {"key": "2", "value": "No"}
        ],
      )
    ]));
  }
}
