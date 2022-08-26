import 'package:flutter/material.dart';
import 'package:retail_academy/common/widget/app_text.dart';

class RetailReelsScreen extends StatefulWidget{
  const RetailReelsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RetailReelsScreenState();

}

class _RetailReelsScreenState extends State<RetailReelsScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: const AppText( text: 'Retails reels',),
      ),
    );
  }

}