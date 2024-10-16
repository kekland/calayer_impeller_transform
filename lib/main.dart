import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  var angle = 0.0;
  var alignment = Alignment.centerLeft;
  
  static const _alignmentValues = [
    Alignment.topLeft,
    Alignment.topCenter,
    Alignment.topRight,
    Alignment.centerLeft,
    Alignment.center,
    Alignment.centerRight,
    Alignment.bottomLeft,
    Alignment.bottomCenter,
    Alignment.bottomRight,
  ];

  @override
  Widget build(BuildContext context) {
    final transform = Matrix4.identity()
      ..setEntry(3, 2, 0.00125)
      ..rotateY(angle);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Slider(
            value: angle,
            onChanged: (v) => setState(() => angle = v),
            min: -pi / 2,
            max: pi / 2,
          ),
          DropdownButton<Alignment>(
            value: alignment,
            onChanged: (v) => setState(() => alignment = v!),
            items: _alignmentValues
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e.toString()),
                    ))
                .toList(),
          ),
          Center(
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: Transform(
                transform: transform,
                alignment: alignment,
                child: const Stack(
                  children: [
                    Opacity(
                      opacity: 0.5,
                      child: MyFlutterView(),
                    ),
                    Opacity(
                      opacity: 0.5,
                      child: MyPlatformView(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyFlutterView extends StatelessWidget {
  const MyFlutterView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160.0,
      height: 160.0,
      child: Container(
        color: Colors.orange,
        child: const Text('Text from Flutter'),
      ),
    );
  }
}

class MyPlatformView extends StatelessWidget {
  const MyPlatformView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 160.0,
      height: 160.0,
      child: UiKitView(
        viewType: 'MyPlatformView',
      ),
    );
  }
}
