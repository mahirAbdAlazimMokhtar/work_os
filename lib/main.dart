import 'package:flutter/material.dart';
import 'package:work_os/screen/auth/login.dart';

void main() {
  runApp(const WorkOS());
}
class WorkOS extends StatefulWidget {
  const WorkOS({Key? key}) : super(key: key);

  @override
  State<WorkOS> createState() => _WorkOSState();
}

class _WorkOSState extends State<WorkOS> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xffEDE7DC)
      ),
      home: LoginScreen(),
    );
  }
}
