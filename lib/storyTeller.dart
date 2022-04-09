import 'package:flutter/material.dart';
import 'package:storyteller/storyPlayer.dart';
import 'package:storyteller/text.dart';

class StoryTeller extends StatefulWidget {
  const StoryTeller({Key? key}) : super(key: key);

  @override
  State<StoryTeller> createState() => _StoryTellerState();
}

class _StoryTellerState extends State<StoryTeller> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Story Teller"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            children: [
              Text(
                "Bawang putih dan Bawang Merah",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                StoryText.text,
                textAlign: TextAlign.justify,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              const StoryPlayer(),
            ],
          ),
        ),
      ),
    );
  }
}
