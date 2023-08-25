import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coordinate List App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Row(
        children: [
          Expanded(child: MyHomePage()),
          Expanded(
            child: VideoArea(),
          ),
        ],
      ),
    );
  }
}

Map useData={};

class MyHomePage extends StatefulWidget {


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  calculateCoordinates() {
    final int x = Random().nextInt(3) + 1;
    final int y = Random().nextInt(3) + 1;
    final int z = Random().nextInt(3) + 1;
    final int n = Random().nextInt(3) + 1;
    var aGuess = "";

    List coordinates = [
      for (int i = 0; i <= x; i++)
        for (int j = 0; j <= y; j++)
          for (int k = 0; k <= z; k++)
            if (i + j + k != n)"Guess Me!"
    ];
    return Column(
      children: [
        Expanded(
          child: listViewTimed(coordinates),
        ),
        StatefulBuilder(
            builder: (context, state) {
              return Container(
                height: 250.0,
                child: Card(
                  color: Color.fromARGB(255, 0, 77, 18),
                  child: Center(child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            aGuess, style: const TextStyle(fontSize: 25),),
                        ),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              onChanged: (v) {
                                ;
                                state(() {
                                  aGuess = v;
                                });
                              },
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter prediction of Last Card Number',
                              ),
                            ),
                          ),
                        ),
                    Builder(
                      builder: (context) {

                        dynamic selectedOption;
                        return StatefulBuilder(
                        
                          builder: (context, state) {
                            return Row(
                              children: [
                                Text("Last card is ",style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    ),
                                Radio(
                                  onChanged: (value) {
                                    state(() {
                                      selectedOption = value!;
                                    });
                                  },
                                  groupValue: selectedOption,
                                  value: "No",
                                ),
                                Text("before or ",style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    ),
                                Radio(
                                  onChanged: (value) {
                                    state(() {
                                      selectedOption = value!;
                                    });
                                  },
                                  groupValue: selectedOption,
                                  value: "Yes",
                                ),
                                Text("After the video ends?",style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    )
                              ],
                            );
                          }
                        );
                      }
                    ),
                    
                    
                      ],
                    ),
                  )
                  ),
                ),
              );
            }
        ),


      ],
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    // setState;

    useData["setState"] = setState;
    useData["viewing"] = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //print(_state.toString());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Center(child: Text('GuesS Game')),
      ),
      body: Row(
        children: [
          Expanded(
            child: useData["viewing"] ? calculateCoordinates() : Center(child:
            Container(child:
            Card(child:
            Container(
              height: 200.0,
              width: 200.0,
              child:  Column(
                children: [
                  Expanded(child: Center(child: CircularProgressIndicator())),
                  Expanded(child: Center(child: Text("Play video to start")))
                ],
              ),
            )))),
          ),

        ],
      ),
    );
  }
}


VideoArea() {
  return Card(
    clipBehavior: Clip.hardEdge,
    child: StatefulBuilder(
      builder: (context, setState) {
        late VideoPlayerController _controller;
        dynamic s = true;

        Future<void> initializeVideo(state) async {
          if (s == true) {
            _controller = VideoPlayerController.network(
                'https://firebasestorage.googleapis.com/v0/b/plans-b4b0a.appspot.com/o/youtube%2FDownload%20(1).mp4?alt=media&token=2c711928-48c5-4dbd-ad75-f10f572981e3');
            await _controller.initialize();
            state(() {});
            s = false;
          }
        }

        void toggleVideoPlayback() {
          if (_controller.value.isPlaying) {
            _controller.pause();
          } else {
            useData["setState"]((){
              useData["viewing"]=true;
            });
            _controller.play();
          }
        }

        return StatefulBuilder(
          builder: (context, state) {
            initializeVideo(state);
            return Stack(
              children: [
                Positioned.fill(
                  child: _controller.value.isInitialized
                      ? FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: _controller.value.size.width,
                      height: _controller.value.size.height,
                      child: VideoPlayer(_controller),
                    ),
                  )
                      : const CircularProgressIndicator(),
                ),
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: FloatingActionButton(
                    onPressed: toggleVideoPlayback,
                    child: Icon(
                      _controller.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    ),
  );
}


listViewTimed(allValuss) {
  return ListView.builder(
    itemCount: allValuss!.length,

    itemBuilder: (context, rindex) {
      final index = allValuss!.length - 1 - rindex;

      return Row(
        children: [
          Expanded(
            child: Builder(
                builder: (context) {
                  dynamic myValue;
                  return StatefulBuilder(
                      builder: (context, state) {
                        Future.delayed(Duration(milliseconds: int.parse(
                            "${index * 1}000")), () {
                          myValue = allValuss![index];
                          try {
                            state(() {});
                          } catch (error) {
                            if (kDebugMode) {

                            }
                          }
                        });

                        if (myValue == null) {
                          return Container();
                        }

                        if (allValuss!.length - 1 == index) {
                          Future.delayed(const Duration(seconds: 5), () {
                            useData["setState"](() {
                              useData["viewing"] = false;
                            });
                          });

                          return Card(
                            elevation: 2,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            color: const Color.fromARGB(221, 255, 0, 0),
                            child: ListTile(
                              leading: Text("${index}",
                                  style: const TextStyle(color: Colors.white,)),
                              title:  Row(
                                children: [
                                  Text(
                                    "value:",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "LAST CARD",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 0, 255, 242),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }

                        return Card(
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          color: const Color.fromARGB(221, 0, 0, 0),
                          child: ListTile(
                            leading: Text("${index}",
                                style: const TextStyle(color: Colors.white,)),
                            title: Row(
                              children: [
                                const Text(
                                  "value:",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "${myValue.toString()}!!",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 0, 255, 242),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                  );
                }
            ),
          ),

        ],
      );
    },
  );
}