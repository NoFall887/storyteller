import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

class StoryPlayer extends StatefulWidget {
  StoryPlayer({Key? key}) : super(key: key);

  @override
  State<StoryPlayer> createState() => _StoryPlayerState();
}

class _StoryPlayerState extends State<StoryPlayer> {
  late AssetsAudioPlayer player;
  late var duration;
  String? _nowPlaying;

  @override
  void initState() {
    player = AssetsAudioPlayer();

    player.current.listen((playingAudio) {
      setState(() {
        _nowPlaying = playingAudio!.audio.assetAudioPath;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AudioPlayer();
  }

  Widget AudioPlayer() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 8,
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(30),
      child: Column(
        children: [
          playbackTime(),
          SizedBox(height: 30),
          audioControl(),
        ],
      ),
    );
  }

  Widget playbackTime() {
    return Row();
  }

  Widget audioControl() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        PlayerBuilder.isPlaying(
            player: player,
            builder: (context, isPlaying) {
              return AudioControlButton(
                onPressed: () async {
                  _nowPlaying == null
                      ? await player.open(Audio("assets/audio/bawang.mp3"))
                      : await player.playOrPause();
                },
                child: !isPlaying
                    ? Icon(Icons.play_arrow_rounded, size: 45)
                    : Icon(Icons.pause_rounded, size: 45),
              );
            }),
        AudioControlButton(
          onPressed: () async {
            await player.stop();
          },
          child: Icon(Icons.stop_rounded, size: 40),
        )
      ],
    );
  }
}

class AudioControlButton extends StatelessWidget {
  final onPressed;
  final child;

  const AudioControlButton({
    Key? key,
    required this.onPressed,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: child,
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          CircleBorder(),
        ),
        padding: MaterialStateProperty.all(EdgeInsets.all(10)),
      ),
    );
  }
}
