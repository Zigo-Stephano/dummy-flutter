import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


var url = "https://www.desktopbackground.org/download/o/2010/06/06/28755_oem-nissan-skyline-gtr-fast-and-furious-6-ff6-paul-walker-wall_1000x1441_h.jpg";
int result = 0;
int state = 2;


class AsstesView extends StatefulWidget {
  const AsstesView({Key? key}) : super(key: key);

  @override
  State<AsstesView> createState() => _AsstesViewState();
}

class _AsstesViewState extends State<AsstesView> {

  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

AudioPlayer audioPlayer = AudioPlayer();

  play() async {
    await audioPlayer.play(AssetSource("audio/audio.mp3"));
    // await audioPlayer.play(UrlSource("https://open.spotify.com/album/2EAkuKnERWRUnGBw1OTDZo?uid=d1e0eccf20a232f2687a&uri=spotify%3Atrack%3A7As3vd7OvJwyGUsZfNtHce&highlight=spotify%3Atrack%3A7As3vd7OvJwyGUsZfNtHce"));
    state = 1;
  }

  stop() async {
    await audioPlayer.stop();
    state = 0;
  }

  @override
  void initState() {
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.asset('assets/video/video.mp4');
    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);

    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assets'),
      ),
      // Use a FutureBuilder to display a loading spinner while waiting for the
      // VideoPlayerController to finish initializing.
      body: Padding(
        padding: const EdgeInsets.only(top:20),
        child: Column(
          children: <Widget>[
            FutureBuilder(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
            const SizedBox(height:15),
            Row( 
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton( 
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (states) => Colors.blue),
                    shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
                      return RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      );
                    }),
                  ),
                  onPressed: () {
                    setState(() {
                      if (_controller.value.isPlaying) {
                        _controller.pause();
                      } else {
                         _controller.play();
                      }
                    });
                  },
                  child: Icon(
                    _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  ),
                ), 
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (states) => Colors.blue),
                    shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
                      return RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      );
                    }),
                  ),
                  onPressed: (){
                    _controller.seekTo(
                      const Duration(seconds: 0),
                    );
                    _controller.pause();
                  },
                  child: const Icon(Icons.stop),
                ),
              ],
            ),
            const SizedBox(height:15),
            Container(height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(url),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height:10),
            Row( mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FloatingActionButton(
                  heroTag: "btnAudioStartOrResume",
                  onPressed: (){
                    setState(() {
                      if (state==1) {
                        audioPlayer.pause();
                        state = 0;            
                      }
                      else if (state == 2) {
                        play();
                      }
                      else {
                        audioPlayer.resume();
                        state = 1;
                      } 
                    });
                  },
                  child: state == 1 ? const Icon(Icons.pause) : const Icon(Icons.play_arrow)
                ),
                const SizedBox(width: 30,),
                FloatingActionButton(
                  heroTag: "btnAudioPause",
                  onPressed: stop,
                  child: const Icon(Icons.stop)
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}