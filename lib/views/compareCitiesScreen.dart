import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CompareCitiesScreen extends StatefulWidget {
  const CompareCitiesScreen({Key key}) : super(key: key);

  @override
  _CompareCitiesScreenState createState() => _CompareCitiesScreenState();
}

class _CompareCitiesScreenState extends State<CompareCitiesScreen> {

  Map<String, String> cityStateMap = new Map<String, String>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    cityStateMap = ModalRoute.of(context).settings.arguments as Map<String,String>;

    return SafeArea(
      child: Scaffold(

      ),
    );
  }
}
