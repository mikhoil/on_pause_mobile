import 'package:dio/dio.dart';
import 'package:fl_query/fl_query.dart';
import 'package:fl_query_hooks/fl_query_hooks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_use_audio/flutter_use_audio.dart';
import 'package:just_audio/just_audio.dart';
import '../../../entities/practice/model/practice.dart';
import '../queries/use_update_history_and_stats.dart';
import '../../../shared/api/instances/classic_instance.dart';
import '../../../shared/utils/get_tokens.dart';
import '../../../shared/utils/refresh_tokens.dart';
import '../../../shared/utils/format_duration.dart';
import '../../../entities/meditation/model/meditation.dart';

class PlayerScreen extends HookWidget {
  const PlayerScreen({super.key, required this.meditation});

  final Meditation meditation;

  @override
  Widget build(BuildContext context) {
    final player = useAudio();
    final update = useUpdateHistoryAndStats(meditation.id);

    final Query(data: practice) = useQuery<Practice, Error>(
        'practice ${meditation.practiceId}',
        () => withRefreshTokens(() async {
              final tokens = await getTokens();
              return Practice.fromJson(
                  (await getClassicInstance(tokens.accessToken)
                          .get('/practices/${meditation.practiceId}'))
                      .data);
            }),
        onData: (data) => print(data.title));

    Future<void> setAudio() async {
      player.playbackEventStream.listen((event) {
        if (event.processingState == ProcessingState.completed) {
          print('end');
          player.stop();
          update.mutate(meditation.duration);
        }
      }, onError: (Object e, StackTrace stackTrace) {
        print(e);
      });
      try {
        await player.setAudioSource(AudioSource.uri(Uri.parse(
            'https://storage.yandexcloud.net/on-pause-meditations/${meditation.audio!}')));
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
                return Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'https://storage.yandexcloud.net/on-pause-meditations/${meditation.image}'),
                    )),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(
                        top: 51, bottom: 34, left: 33, right: 33),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            practice != null
                                ? Text(practice.title.toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 19,
                                        color: Color(int.parse(
                                            practice.colors[0]
                                                .replaceAll('#', 'ff'),
                                            radix: 16)),
                                        fontWeight: FontWeight.w500))
                                : Text(''),
                            const SizedBox(height: 10),
                            Text(
                              meditation.title,
                              style: TextStyle(fontSize: 15),
                            ),
                            const SizedBox(height: 10),
                            practice != null
                                ? ElevatedButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(Color(
                                                int.parse(
                                                    practice.colors[1]
                                                        .replaceAll('#', 'ff'),
                                                    radix: 16)))),
                                    child: Text(
                                      "Завершить сеанс",
                                      style: TextStyle(
                                          color: Color(int.parse(
                                              practice.colors[2]
                                                  .replaceAll('#', 'ff'),
                                              radix: 16)),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  )
                                : CircularProgressIndicator()
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
                                : ElevatedButton(
                                    onPressed: () {
                                      if (playing) {
                                        player.stop();
                                      } else {
                                        player.play();
                                      }
                                    },
                                    style: const ButtonStyle(
                                        fixedSize: MaterialStatePropertyAll(
                                            Size.fromRadius(41.5)),
                                        padding: MaterialStatePropertyAll(
                                            EdgeInsets.zero)),
                                    child: Icon(
                                      !playing ||
                                              processingState ==
                                                  ProcessingState.completed
                                          ? Icons.play_arrow_rounded
                                          : Icons.pause_rounded,
                                      color: Colors.black.withOpacity(.7),
                                      size: 60,
                                    ),
                                  ),
                            const SizedBox(height: 25),
                            StreamBuilder<Duration?>(
                                stream: player.positionStream,
                                builder: (context, snapshot) {
                                  final position = snapshot.data?.inSeconds;
                                  if (position != null)
                                    return Column(
                                      children: [
                                        LinearProgressIndicator(
                                          minHeight: 2,
                                          value: position / meditation.duration,
                                          color: Colors.black.withOpacity(.57),
                                          backgroundColor:
                                              Colors.black.withOpacity(.2),
                                        ),
                                        const SizedBox(height: 14),
                                        practice != null
                                            ? FittedBox(
                                                fit: BoxFit.contain,
                                                child: Container(
                                                    padding: EdgeInsets.all(4),
                                                    decoration: BoxDecoration(
                                                        color: Color(int.parse(
                                                            practice.colors[1]
                                                                .replaceAll(
                                                                    '#', 'ff'),
                                                            radix: 16)),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12)),
                                                    child: player.duration
                                                                ?.inSeconds !=
                                                            null
                                                        ? Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                formatDuration(
                                                                    position),
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                              Text(
                                                                  " / ${formatDuration(player.duration!.inSeconds)}",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontSize:
                                                                          15,
                                                                      color: Colors
                                                                          .black))
                                                            ],
                                                          )
                                                        : Text('')))
                                            : CircularProgressIndicator()
                                      ],
                                    );
                                  return CircularProgressIndicator();
                                }),
                          ],
                        ),
                      ],
                    ));
              }
              return CircularProgressIndicator();
            }));
  }
}
