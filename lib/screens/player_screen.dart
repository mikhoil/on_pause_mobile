import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_use_audio/flutter_use_audio.dart';
import 'package:just_audio/just_audio.dart';

import '../shared/utils/formatDuration.dart';
import '../entities/meditation/model/meditation.dart';

class PlayerScreen extends HookWidget {
  PlayerScreen(
      {super.key, required this.meditation, required this.practiceTitle});

  final Meditation meditation;
  final String practiceTitle;

  @override
  Widget build(BuildContext context) {
    final player = useAudio();

    Future<void> setAudio() async {
      player.playbackEventStream.listen((event) {},
          onError: (Object e, StackTrace stackTrace) {
        print(e);
      });
      try {
        print(meditation.url);
        await player.setAudioSource(AudioSource.uri(Uri.parse(meditation.url!)));
      } catch (e) {
        print(e);
      }
    }

    useEffect(() {
      setAudio();

      return () {
        player.stop();
        player.dispose();
      };
    }, []);

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(0), child: AppBar()),
        body: StreamBuilder<PlayerState>(
            stream: player.playerStateStream,
            builder: (context, snapshot) {
              final processingState = snapshot.data?.processingState;
              final playing = snapshot.data?.playing;

              if (playing != null) {
                return Stack(children: [
                  Opacity(
                      opacity: !playing ? .9 : 1,
                      child: SvgPicture.asset(
                        'lib/app/assets/meditation_bg_image.svg',
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                        colorFilter: ColorFilter.matrix([
                          1,
                          0,
                          0,
                          0,
                          !playing ? -50 : 1,
                          0,
                          1,
                          0,
                          0,
                          !playing ? -50 : 1,
                          0,
                          0,
                          1,
                          0,
                          !playing ? -50 : 1,
                          0,
                          0,
                          0,
                          1,
                          0
                        ]),
                      )),
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(
                          top: 51, bottom: 34, left: 33, right: 33),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(practiceTitle,
                                  style: const TextStyle(
                                      fontSize: 19,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500)),
                              const SizedBox(height: 10),
                              Text(meditation.title,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500)),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Color.fromRGBO(255, 255, 255, .05))),
                                child: const Text(
                                  "Завершить сеанс",
                                  style: TextStyle(
                                      color: Color.fromRGBO(185, 202, 215, .73),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              (processingState == ProcessingState.loading ||
                                      processingState ==
                                          ProcessingState.buffering)
                                  ? Container(
                                      margin: const EdgeInsets.all(8.0),
                                      width: 64,
                                      height: 64,
                                      child: const CircularProgressIndicator(),
                                    )
                                  : (playing != null)
                                      ? ElevatedButton(
                                          onPressed: () {
                                            if (playing) {
                                              player.stop();
                                            } else {
                                              player.play();
                                            }
                                            print(player.duration);
                                          },
                                          style: const ButtonStyle(
                                              fixedSize:
                                                  MaterialStatePropertyAll(
                                                      Size.fromRadius(41.5)),
                                              padding: MaterialStatePropertyAll(
                                                  EdgeInsets.zero)),
                                          child: SvgPicture.asset(
                                            'lib/app/assets/${!playing ? 'play' : 'pause'}.svg',
                                            width: 26,
                                            height: 28,
                                          ),
                                        )
                                      : Text("error"),
                              const SizedBox(
                                height: 30,
                              ),
                              StreamBuilder<Duration?>(
                                  stream: player.positionStream,
                                  builder: (context, snapshot) {
                                    final position = snapshot.data?.inSeconds;

                                    if (position != null)
                                      return Column(
                                        children: [
                                          LinearProgressIndicator(
                                            minHeight: 2,
                                            value:
                                                position / meditation.duration,
                                            color: !playing
                                                ? Colors.white
                                                : Colors.black,
                                            backgroundColor:
                                                Colors.black.withOpacity(.2),
                                          ),
                                          const SizedBox(
                                            height: 14,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                formatDuration(position),
                                                style: TextStyle(
                                                    color: !playing
                                                        ? Colors.white
                                                        : Colors.black,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 15),
                                              ),
                                              Text(
                                                  " / ${formatDuration(meditation.duration)}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 15,
                                                      color: Colors.black
                                                          .withOpacity(.3)))
                                            ],
                                          )
                                        ],
                                      );
                                    return Text("...");
                                  }),
                            ],
                          ),
                        ],
                      )),
                ]);
              }
              return Text("...");
            }));
  }
}
