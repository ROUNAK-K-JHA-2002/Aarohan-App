import 'package:flutter/material.dart';
import 'package:aarohan_app/widgets/loader.dart';
import 'package:aarohan_app/screens/dashboard.dart';

class LoaderScreen extends StatefulWidget {

  @override
  _LoaderScreenState createState() => _LoaderScreenState();
}

class _LoaderScreenState extends State<LoaderScreen> {

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration(milliseconds:5000 ),()=> Navigator.popAndPushNamed(context, '/'));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Loader();
  }
}
