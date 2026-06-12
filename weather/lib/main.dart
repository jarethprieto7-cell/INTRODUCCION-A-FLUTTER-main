import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather/modules/global.dart';
import 'package:weather/modules/whetherApi.dart';
import 'dart:convert';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wheather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Wheather'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Color> colors = [
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.red
  ];

  // Tipado 
  Future<WhetherApi> fetchPosts() async {
    final response = await http.get(
      Uri.parse(EARTHQUAKE_URL),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return WhetherApi.fromJson(data);
    } else {
      throw Exception("Server Under Maintenance");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(widget.title),
      ),
      body: FutureBuilder<WhetherApi>(
        future: fetchPosts(),
        builder: (BuildContext context, AsyncSnapshot<WhetherApi> snapshot) {

          // Cargando
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Error
          if (snapshot.hasError) {
            return const Center(
              child: Text("Sorry for Inconvenience, Server Under Maintenance"),
            );
          }

          final data = snapshot.data!;

          return ListView.builder(
            itemCount: data.features?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {

              final feature = data.features![index];

              // null safety aplicada
              final mag = feature.properties?.mag ?? 0;
              final placeText =
                  feature.properties?.place ?? "Unknown, Unknown";

              List<String> places = placeText.split(",");

              var circleContent = Container(
                margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 19,
                ),
                child: Text(
                  mag.ceil().toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              );

              return Container(
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFFE0E0E0),
                      offset: Offset(0.5, 0.5),
                      blurRadius: 10.0,
                    ),
                  ],
                  color: const Color(0xFFFAFAFA),
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 6,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colors[
                            mag.ceil() > 4
                                ? 4
                                : mag.ceil() == 0
                                    ? 0
                                    : mag.ceil() - 1
                          ],
                        ),
                        child: circleContent,
                      ),
                    ),

                    const SizedBox(width: 10),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          places.last.trim(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          places.first,
                          style: const TextStyle(fontSize: 12),
                        )
                      ],
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}