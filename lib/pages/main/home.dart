import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../fragments/pass/pass.dart';
import '../../models/currentuser.dart';
import '../../models/pass.dart';
import '../../api/pass_list.dart';
import '../../models/storage.dart';
import '../../models/scanner.dart';
import '../auth/login.dart';

class Home extends StatefulWidget {
  CurrentUserModel user;
  Home(this.user);

  @override
  HomeState createState() => new HomeState(user);
}

class HomeState extends State<Home> {
  CurrentUserModel user;
  Pass pass;

  HomeState(this.user);

  @override
  void initState() {
    pass = new Pass(this.user, null);
    getData();
  }

  Future<void> getData() async {

    Iterable<PassModel> passes = await PassListAPI().getData(user.token, null);
    PassModel pass_raw = passes.elementAt(0);

    pass.state.setState(() {
      pass.state.pass = pass_raw;
    });
    pass.state.getPass();

  }

  @override
  Widget build(BuildContext context) {

    return new Container(
      child: new Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          title: new Row(
            children: <Widget>[
              new Icon(
                Icons.person,
                size: 20.0,
                color: Colors.white,
              ),
              new Text(
                ' ' + this.user.firstname + ' ' + this.user.lastname,
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              )
            ],
          ),
          actions: <Widget>[
            user.type == '2' ? IconButton(
              icon: Icon(Icons.camera),
              onPressed: () {
                Scanner.scan(user);
              },
            ) : new Container(),

            new IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                Storage().removeUser();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));     
              },
            ),
          ],
        ),
        body: new Container(
          padding: EdgeInsets.all(20.0),
          child: pass,
        ),
      )
    );
  }
}