import 'package:flutter/material.dart';

class SecondClass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar:AppBar(
          elevation: 10.0,
          title:Center(child: Text('Title'),
          ),
          actions: <Widget>[
            Icon(Icons.settings),
          ],
        ),
        body: Material(
          child: WillPopScope(
              onWillPop: () async {
                return await showDialog<bool>(
                  context: context,
                  builder: (_)=> AlertDialog(
                    title: Text('Are you sure?'),
                    content: Text('It will close the application.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text('No'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: Text('Yes'),
                      ),
                    ],
                  )
                ) ?? false;
              },
           child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      color: Colors.purple,
                      child: Text(
                        "Expanded",
                        style: TextStyle(fontSize: 25.0),
                        ),
                    ), 
                  ),
                    Flexible(
                      child: Container(
                      color: Colors.yellow,
                      child: Text(
                        "Flexible",
                        style: TextStyle(fontSize: 25.0),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    child: Container(
                      color: Colors.yellow,
                      child: Text(
                        "Flexible",
                        style: TextStyle(fontSize: 25.0),
                        ),
                    ), 
                  ),
                    Flexible(
                      child: Container(
                      color: Colors.yellow,
                      child: Text(
                        "Flexible",
                        style: TextStyle(fontSize: 25.0),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.purple,
                      child: Text(
                        "Expanded",
                        style: TextStyle(fontSize: 25.0),
                        ),
                    ), 
                  ),
                    Expanded(
                      flex: 3,
                      child: Container(
                      color: Colors.red,
                      child: Text(
                        "Expanded",
                        style: TextStyle(fontSize: 25.0),
                      ),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                child: Text('Click me'),
                onTap: (){
                  Navigator.of(context).pushNamed('/screen2');
                }
              )
            ],
          ),
        ),
      )
    );
  }
}