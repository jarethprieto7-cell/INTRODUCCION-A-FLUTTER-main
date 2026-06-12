import 'package:flutter/material.dart';

class SecondPageClass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar:AppBar(
          elevation: 10.0,
          automaticallyImplyLeading: false,
          title:Center(child: Text('Screen 2'),
          ),
          actions: <Widget>[
            Icon(Icons.settings),
          ],
        ),
        body: Material(
        child: Column(
          children: <Widget>[
            Text('Screen 2'),
              GestureDetector(
                  child: Text('Take me back!'),
                  onTap: (){
                    Navigator.of(context).pop();
                  }
                )
          ],
        )  
      )
    );
  }
}