import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../utils/constants.dart';
import 'my_svg_icon.dart';

class MyFrequencyPlayer extends StatefulWidget {
  List<Map<String, Object>> freqList;
  MyFrequencyPlayer({super.key, required this.freqList});

  @override
  State<MyFrequencyPlayer> createState() => _MyFrequencyPlayerState();
}

class _MyFrequencyPlayerState extends State<MyFrequencyPlayer> {
  static const platform = MethodChannel('com.rifetechnology.rife_mobile_app/frequency_generator');

  int _playingIndex = 0;
  String _playingFreqTitle = '';

  bool _isPlaying = false;
  bool _isFavourite = false;
  int _loopIndex = 0;
  bool _isPaused = false;
  bool _isStopped = false;
  bool _isSessionCompleted = true;

  bool _isLoopRunning = false;

  // // ICON PROPERTIES;
  var _iconSize = 38.0;
  var lenFreqList = 0;
  bool isRunning = false;
  Stopwatch stopwatch = Stopwatch();
  int elapsedTime = 0;
  int totalDuration = 0;
  var _progressPercentage = 0.0;

  var freqDurationTimer;

  void playFrequency({required double freqHz}) async {
    await platform.invokeMethod<bool>('playFrequency',
        {'frequency': freqHz, 'phaseDifference': PHASE_DIFFERENCE});
  }

  void stopFrequency() async {
    await platform.invokeMethod<bool>('stopFrequency');
  }

  void startStopwatch() {
    setState(() {
      isRunning = true;
      stopwatch.start();
    });

    // Update the elapsed time every 100 milliseconds
    Timer.periodic(Duration(milliseconds: 100), (Timer timer) {

      if (stopwatch.isRunning) {
        if(_progressPercentage==1.0){
          if(_loopIndex==1){
            stopwatch.reset();
            stopFrequency();
            setState(() {
              elapsedTime = 0;
              _progressPercentage = 0;
              _playingIndex = 0;
              // _resumeIndex = 0;
            });
          }
          if(_loopIndex==0){
            stopwatch.stop();
            stopFrequency();
            setState(() {
              _isPlaying = false;
              _isSessionCompleted = true;
              _progressPercentage = 0;
            });
          }

        }
        setState(() {
          elapsedTime = (stopwatch.elapsedMilliseconds ~/ 1000.0);
          _progressPercentage = (elapsedTime)/(totalDuration);
        });
      }

    });
  }



  void stopStopwatch() {
    setState(() {
      isRunning = false;
      stopwatch.stop();
    });
  }

  String formatTime(int seconds) {
    // Calculate hours, minutes, and remaining seconds
    int hours = seconds ~/ 3600;
    int remainingSeconds = seconds % 3600;
    int minutes = remainingSeconds ~/ 60;
    int secs = remainingSeconds % 60;

    // Format the time string
    String formattedTime = hours > 0
        ? '${_formatDigit(hours)}:${_formatDigit(minutes)}:${_formatDigit(secs)}'
        : '${_formatDigit(minutes)}:${_formatDigit(secs)}';
    return formattedTime;
  }

  String _formatDigit(int digit) {
    // Helper function to add leading zero if needed
    return digit < 10 ? '0$digit' : '$digit';
  }

  int _secRemaining = 0;
  bool _isActive = false;
  Completer<void> _timerCompleter = Completer<void>();

  startFreqPlayer() async {
    print("***starting-freq-player***");

    if(_loopIndex==0){
      print("***is-loop-running: $_isLoopRunning***");
      for(int i = 0;
      i < widget.freqList.length && _isLoopRunning;
      // i<1;
      i++){
        print("***playing-for-$i***");
        int duration = widget.freqList[_playingIndex]["duration_sec"] as int;
        double freqHz = widget.freqList[_playingIndex]["freq_hz"] as double;
        String freqTitle = widget.freqList[_playingIndex]["freq_title"] as String;

        print("***playing-freq-hz-${freqHz}***");
        // int duration = 9;
        _secRemaining = duration;
        if(_isPlaying){
          setState(() {
            _playingIndex = i;
            _playingFreqTitle = freqTitle;
            _isActive = true;
          });
          playFrequency(freqHz: freqHz);
          await Future.delayed(Duration(seconds: !_isPaused ? duration: _secRemaining), () {
            print("***player-completed-for-$_playingIndex***");
            _secRemaining--;
          });

          // // METHOD-1: TO IMPLEMENT THE PAUSE PLAY FUNCTIONS;
          // while (_secRemaining > 0) {
          //   await _timerCompleter.future;
          //
          //   if (_isPaused) {
          //     break;
          //   }
          //
          //   await Future.delayed(Duration(seconds: 1), () {
          //     print("***player-completed-for-$_playingIndex***");
          //     _secRemaining--;
          //   });
          // }

          // // METHOD-2: TO IMPLEMENT THE PAUSE PLAY FUNCTION;
          // Timer.periodic(Duration(seconds: 1), (Timer timer) {
          //   setState(() {
          //     if(_isActive){
          //       if (_secRemaining < 1) {
          //         timer.cancel();
          //         _isActive = false;
          //       } else {
          //         _secRemaining -= 1;
          //         print("***sec-remaining-${_secRemaining}***");
          //       }
          //     }
          //   });
          // });
        }
      }
    }

    if(_loopIndex==1){
      _playingIndex = 0;
      for(int i = 0; _isLoopRunning && _isPlaying; i++){
        print("***---playingIndex: $_playingIndex---***");
        int duration = widget.freqList[_playingIndex]["duration_sec"] as int;
        double freqHz = widget.freqList[_playingIndex]["freq_hz"] as double;
        if(_isPlaying){ // NOTE: check if "_secRemaining < duration" and then iterate;
          if(_playingIndex<widget.freqList.length){
            setState(() {
              _playingIndex++;
            });
          }
          playFrequency(freqHz: freqHz);
          await Future.delayed(Duration(seconds: duration), () {
            print("***------completed-${i}------");
          });
        }
      }
    }
    // _resumeIndex = _playingIndex;
  }

  _getRepeatIcon({required int loopIndex}) {
    if(loopIndex==0){
      return MySvgIcon(iconUrl: "assets/icons/repeat_icon.svg", iconColor: Colors.white,);
    }
    if(loopIndex==1){
      return MySvgIcon(iconUrl: "assets/icons/repeat_on_icon.svg", iconColor: Colors.white, iconSize: 18.0,);
    }
    // if(loopIndex==2){
    //   return Icon(Icons.repeat_on);
    // }
  }

  Color _iconBgColor = const Color(0xff0069c7);
  Color _playerBgColor = const Color(0xff0080f3);

  int getTotalDuration(List<Map<String, Object>> freqList) {
    int sum = 0;
    freqList.forEach((element){
      int duration = (element["duration_sec"]) as int;
      sum += duration;
    });
    setState(() {
      totalDuration = sum;
    });
    return(totalDuration);
  }
  @override
  Widget build(BuildContext context) {
    // // PLAYER BOX PROPERTIES;
    var _boxHeightText = 80.0;
    var _boxHeightBar = 32.0;
    var _boxHeightTime = 0.0;
    var size = MediaQuery.of(context).size;
    totalDuration = getTotalDuration(widget.freqList);
    lenFreqList = widget.freqList.length;
    return Container(
      width: size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Svg(
            'assets/images/player_bg_image.svg',
            // color: Colors.grey,
          ),

            fit: BoxFit.fitWidth
        ),
        color: _playerBgColor,
        border: Border.all(width: 0.0),
      ),
      child: SizedBox(
        height: (_boxHeightText + _boxHeightBar + _boxHeightTime),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 42,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _isPlaying ? Text("Playing Now ${_playingFreqTitle}", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),): Text("Play Now", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                          Text("${_playingIndex+1} / $lenFreqList Frequencies", style: TextStyle(color: Colors.white),),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: _iconSize,
                          height: _iconSize,
                          child: Container(
                            decoration: BoxDecoration(
                              color: _iconBgColor,
                              border: Border.all(
                                width: 0.0,
                                color: _iconBgColor
                              ),
                              borderRadius: BorderRadius.circular(7.0)
                            ),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                setState(() {
                                  _isFavourite = !_isFavourite;
                                });
                              },
                              icon: !_isFavourite
                                  ? MySvgIcon(iconUrl: "assets/icons/favourite_border_icon.svg", iconColor: Colors.white, iconSize: 18.0,)
                                  : MySvgIcon(iconUrl: "assets/icons/favourite_icon.svg", iconColor: Colors.white, iconSize: 18.0,)
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: _iconSize,
                            height: _iconSize,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: _iconBgColor,
                                  border: Border.all(
                                      width: 0.0,
                                      color: _iconBgColor
                                  ),
                                  borderRadius: BorderRadius.circular(7.0)
                              ),
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () async {

                                  if(!_isPlaying){
                                    setState(() {
                                      _isPlaying = true;
                                    });
                                  }

                                  // // NOTE: The below code should execute the pause functionality
                                  // setState(() {
                                  //   _isPlaying = !_isPlaying;
                                  //   _isActive = !_isActive;
                                  // });

                                  if(_isPlaying){
                                    _isLoopRunning = true;
                                    startStopwatch();
                                    startFreqPlayer();
                                  } else {
                                    print("***player-paused***R");
                                    _isLoopRunning = false;
                                    stopStopwatch();
                                  }

                                  if(_isSessionCompleted){
                                    setState(() {
                                      elapsedTime = 0;
                                      _progressPercentage = 0;
                                      _isSessionCompleted = false;
                                      stopwatch.reset();
                                    });
                                    stopFrequency();
                                  }

                                  print("***isPlaying: $_isPlaying***");

                                  if(_isPlaying){
                                    await startFreqPlayer();
                                  }

                                },
                                icon:
                                !_isPlaying ? Padding(
                                  padding: const EdgeInsets.fromLTRB(3.0, 0.0, 0.0, 0.0),
                                  child: MySvgIcon(iconUrl: "assets/icons/play_polygon_icon.svg", iconColor: Colors.white, ),
                                ) : MySvgIcon(iconUrl: "assets/icons/pause_icon.svg", iconColor: Colors.white,),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: _iconSize,
                          height: _iconSize,
                          child: Container(
                            decoration: BoxDecoration(
                                color: _iconBgColor,
                                border: Border.all(
                                    width: 0.0,
                                    color: _iconBgColor
                                ),
                                borderRadius: BorderRadius.circular(7.0)
                            ),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                if(_loopIndex<1){
                                  setState(() {
                                    _loopIndex++;
                                  });
                                } else {
                                  setState(() {
                                    _loopIndex =0;
                                  });
                                }
                                print(_loopIndex.toString());

                              },
                              icon: _getRepeatIcon(loopIndex: _loopIndex),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: _iconSize,
                            height: _iconSize,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: _iconBgColor,
                                  border: Border.all(
                                      width: 0.0,
                                      color: _iconBgColor
                                  ),
                                  borderRadius: BorderRadius.circular(7.0)
                              ),
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  if(_isPlaying){
                                    setState(() {
                                      _isPlaying = false;
                                      _isStopped = true;
                                    });
                                  }

                                  stopStopwatch();

                                  setState(() {
                                    elapsedTime = 0;
                                    _loopIndex = 0;
                                    _playingIndex = 0;
                                    _progressPercentage = 0;
                                    _isSessionCompleted = false;
                                    _isLoopRunning = false;
                                    stopwatch.reset();
                                  });

                                  stopFrequency();

                                },
                                icon:
                                _isPlaying ? MySvgIcon(iconUrl: "assets/icons/stop_icon.svg", iconColor: Colors.white, iconSize: 12.0,) : MySvgIcon(iconUrl: "assets/icons/stop_icon.svg", iconColor: Colors.white,  iconSize: 12.0,) ,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
                child: Container(
                  // color: Colors.blueGrey.shade50,
                  child: LinearPercentIndicator(
                    width: size.width - 24.0,
                    widgetIndicator: SizedBox(
                      height: 15.0,
                      child: Column(
                        children: [
                          Container(
                            width: 10.0, // Adjust the width to change the size of the circle
                            height: 10.0, // Equal to width to make it a perfect circle
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white, // Change the color as needed
                              // You can add more styling properties here, like border
                              // border: Border.all(color: Colors.black, width: 2.0),
                            ),
                          ),
                          SizedBox(height: 5.0,),
                        ],
                      ),
                    ),
                    barRadius: Radius.circular(5.0),
                    lineHeight: 4.0,
                    percent: (_progressPercentage),
                    backgroundColor: Colors.white.withOpacity(0.8),
                    progressColor: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${formatTime(elapsedTime)}", style: TextStyle(fontSize: 14.0, color: Colors.white),),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text("${formatTime(totalDuration)}", style: TextStyle(fontSize: 14.0, color: Colors.white),),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
