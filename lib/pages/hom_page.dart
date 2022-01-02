import 'package:flutter/material.dart';
import "../widgets/app_color.dart" as AppColor;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.background,
      child: const SafeArea(
        child: Scaffold(),
      ),
    );
  }
}
