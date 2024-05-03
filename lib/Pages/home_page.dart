import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    print('width and height');
    print(MediaQuery.of(context).size.width);
    print(MediaQuery.of(context).size.height);
    // setState(() {});
    // setState(() {});
    // print('name from home page init funciton is.....');
    // print(firstname);
    // print(lastname);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home Page',
        ),
      ),
      body: Text('data'),
    );
  }
}
