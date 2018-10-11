import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pass_master/fragments/header.dart';
import 'dart:async';

import '../../../api/pass.dart';
import '../../../fragments/pass/pass.dart';
import '../../../models/srt-pass.dart';
import '../../../models/pass.dart';
import '../../../models/teacher-pass.dart';
import '../../../models/location-pass.dart';
import '../../../models/currentuser.dart';

class ViewPass extends StatefulWidget {
  CurrentUserModel user;
  PassModel pass;

  ViewPass(this.user, this.pass);

  @override
  ViewPassState createState() => new ViewPassState(user, pass);

}

class ViewPassState extends State<ViewPass> {
  CurrentUserModel user;
  PassModel pass_data;

  Pass pass;

  ViewPassState(this.user, this.pass_data);

  @override 
  void initState() {
    pass = new Pass(this.user, pass_data.type, pass_data.pk);
    getData();
  }

  Future<void> getData() async {
    pass.state.setState(() {
      pass.state.type = pass_data.type;
      pass.state.pk = pass_data.pk;
      pass.state.getPass();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.orangeAccent,
        child: new Container(
          padding: EdgeInsets.all(20.0),
          child: pass,
        ),
    );
  }
}