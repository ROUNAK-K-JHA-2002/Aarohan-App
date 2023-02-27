import 'package:flutter/material.dart';

class Loader extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    double height= MediaQuery.of(context).size.height;  double width= MediaQuery.of(context).size.width;
    return Container(
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image:AssetImage(
            'assets/arhn-loader-per-1.gif',
          ),
          fit: BoxFit.cover
        )
      ),

    );
  }
}
