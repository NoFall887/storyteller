import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';

class StoryPlayer extends StatefulWidget {
  const StoryPlayer({Key? key}) : super(key: key);

  @override
  State<StoryPlayer> createState() => _StoryPlayerState();
}

class _StoryPlayerState extends State<StoryPlayer> {
  late AssetsAudioPlayer player;
  Duration? _duration;
  String? _nowPlaying;
  int _loopCount = 0;
  int _loopDone = 0;

  _openAudioFile() {
    player.open(Audio("assets/audio/bawang.mp3"));
  }

  @override
  void initState() {
    player = AssetsAudioPlayer();

    player.current.listen((playingAudio) {
      setState(() {
        _nowPlaying = playingAudio!.audio.assetAudioPath;
        _duration = playingAudio.audio.duration;
      });
    });
    // execute when audio finished to play
    player.playlistAudioFinished.listen((playing) {
      if (_loopDone < _loopCount) {
        setState(() {
          _loopDone++;
          player.play();
        });
      } else {
        setState(() {
          _loopCount = 0;
          _loopDone = 0;
        });
      }
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
    return audioPlayer();
  }

  Widget audioPlayer() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          const BoxShadow(
            color: Colors.grey,
            blurRadius: 8,
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          audioControlSlider(),
          const SizedBox(height: 30),
          audioControl(),
        ],
      ),
    );
  }

  Widget audioControlSlider() {
    return PlayerBuilder.currentPosition(
      player: player,
      builder: (context, position) {
        return ProgressBar(
          progress: Duration(
            milliseconds: position.inMilliseconds,
          ),
          timeLabelPadding: 10,
          timeLabelLocation: TimeLabelLocation.above,
          timeLabelTextStyle: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
          total: Duration(
            milliseconds: _duration == null ? 0 : _duration!.inMilliseconds,
          ),
          onSeek: (duration) {
            player.seekBy(duration);
          },
        );
      },
    );
  }

  Widget audioControl() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            AudioControlButton(
              onPressed: () {
                _loopCount < 10 ? _loopCount++ : _loopCount = 0;
                setState(() {});
              },
              child: const Icon(
                Icons.loop_rounded,
                size: 30,
              ),
            ),
            Text("${_loopCount}X")
          ],
        ),
        PlayerBuilder.isPlaying(
            player: player,
            builder: (context, isPlaying) {
              return AudioControlButton(
                onPressed: () async {
                  _nowPlaying == null
                      ? await _openAudioFile()
                      : await player.playOrPause();
                },
                child: !isPlaying
                    ? const Icon(Icons.play_arrow_rounded, size: 45)
                    : const Icon(Icons.pause_rounded, size: 45),
              );
            }),
        AudioControlButton(
          onPressed: () async {
            await player.stop();
            setState(() {
              _loopCount = 0;
              _loopDone = 0;
            });
          },
          child: const Icon(Icons.stop_rounded, size: 40),
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
          const CircleBorder(),
        ),
        padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
      ),
    );
  }
}
