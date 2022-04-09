import 'package:flutter/material.dart';
import 'package:storyteller/storyPlayer.dart';
import 'package:storyteller/text.dart';

class StoryTeller extends StatefulWidget {
  StoryTeller({Key? key}) : super(key: key);

  @override
  State<StoryTeller> createState() => _StoryTellerState();
}

class _StoryTellerState extends State<StoryTeller> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Story Teller"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            children: [
              Text(
                StoryText.text,
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              StoryPlayer(),
            ],
          ),
        ),
      ),
    );
  }
}
