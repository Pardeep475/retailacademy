import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../app_color.dart';
import '../app_images.dart';
import '../app_strings.dart';
import '../utils.dart';
import 'app_text.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String url;
  final PlayerMode mode;
  final VoidCallback? onLikePressed;
  final VoidCallback? onCommentPressed;
  final Function(bool value)? showLoader;
  final Function(String position) positionOnPressed;
  final bool hasLiked;

  const AudioPlayerWidget({
    Key? key,
    required this.url,
    this.onLikePressed,
    this.onCommentPressed,
    required this.positionOnPressed,
    this.showLoader,
    this.hasLiked = false,
    this.mode = PlayerMode.mediaPlayer,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  late AudioPlayer _audioPlayer;
  Duration? _duration;
  Duration? _position;

  PlayerState _playerState = PlayerState.stopped;
  StreamSubscription? _durationSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _playerCompleteSubscription;
  StreamSubscription? _playerErrorSubscription;
  StreamSubscription? _playerStateSubscription;

  bool get _isPlaying => _playerState == PlayerState.playing;

  // bool get _isPaused => _playerState == PlayerState.paused;

  String get _durationText => _duration?.toString().split('.').first ?? '';

  String get positionText => _position?.toString().split('.').first ?? '';

  bool isAudioMute = false;

  @override
  void initState() {
    super.initState();
    _initAudioPlayer();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
    _playerErrorSubscription?.cancel();
    _playerStateSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 30.w, right: 30.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: _position != null
                    ? '$positionText / $_durationText'
                    : _duration != null
                        ? _durationText
                        : '00:00:00 / 00:00:00',
                textSize: 14.sp,
                color: AppColor.black,
                maxLines: 1,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                lineHeight: 1.3,
                fontWeight: FontWeight.w500,
              ),
              Container(
                height: 10.h,
                margin: EdgeInsets.only(top: 16.h, bottom: 10.h),
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackShape: CustomTrackShape(),
                    thumbColor: AppColor.red,
                    activeTickMarkColor: AppColor.red,
                    activeTrackColor: AppColor.red,
                  ),
                  child: Slider(
                    onChanged: (v) {
                      final duration = _duration;
                      if (duration == null) {
                        return;
                      }
                      final position = v * duration.inMilliseconds;
                      _audioPlayer
                          .seek(Duration(milliseconds: position.round()));
                    },
                    value: (_position != null &&
                            _duration != null &&
                            _position!.inMilliseconds > 0 &&
                            _position!.inMilliseconds <
                                _duration!.inMilliseconds)
                        ? _position!.inMilliseconds / _duration!.inMilliseconds
                        : 0.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColor.red,
          ),
          margin: EdgeInsets.symmetric(vertical: 10.h),
          child: _isPlaying
              ? IconButton(
                  onPressed: _isPlaying ? _pause : null,
                  icon: const Icon(
                    Icons.pause,
                    color: AppColor.white,
                  ),
                )
              : IconButton(
                  onPressed: _isPlaying ? null : _play,
                  icon: const Icon(Icons.play_arrow_rounded,
                      color: AppColor.white)),
        ),
        // Row(
        //   mainAxisSize: MainAxisSize.min,
        //   children: [
        //     IconButton(
        //       key: const Key('play_button'),
        //       onPressed: _isPlaying ? null : _play,
        //       iconSize: 24.0,
        //       icon: const Icon(Icons.play_arrow),
        //       color: Colors.cyan,
        //     ),
        //     IconButton(
        //       key: const Key('pause_button'),
        //       onPressed: _isPlaying ? _pause : null,
        //       iconSize: 24.0,
        //       icon: const Icon(Icons.pause),
        //       color: Colors.cyan,
        //     ),
        //     IconButton(
        //       key: const Key('stop_button'),
        //       onPressed: _isPlaying || _isPaused ? _stop : null,
        //       iconSize: 24.0,
        //       icon: const Icon(Icons.stop),
        //       color: Colors.cyan,
        //     ),
        //     IconButton(
        //       onPressed: () {},
        //       iconSize: 24.0,
        //       icon: const Icon(Icons.volume_up),
        //       color: Colors.cyan,
        //     ),
        //   ],
        // ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 16.w,
            ),
            IconButton(
              onPressed: widget.onLikePressed,
              icon: SvgPicture.asset(
                AppImages.iconHeart,
                color: widget.hasLiked ? AppColor.red : AppColor.black,
                height: 24.r,
              ),
            ),
            IconButton(
              onPressed: widget.onCommentPressed,
              icon: SvgPicture.asset(
                AppImages.iconChat,
                color: AppColor.black,
                height: 24.r,
              ),
            ),
            const Expanded(child: SizedBox()),
            IconButton(
              onPressed: () => _muteAndUnMuteAudio(),
              icon: Icon(
                isAudioMute ? Icons.volume_off : Icons.volume_up,
                size: 28.r,
              ),
            ),
            // IconButton(
            //   onPressed: () {},
            //   icon: Icon(
            //     Icons.settings,
            //     size: 28.r,
            //   ),
            // ),
            SizedBox(
              width: 16.w,
            ),
          ],
        ),
      ],
    );
  }

  void _initAudioPlayer() {
    _audioPlayer = AudioPlayer();

    _durationSubscription = _audioPlayer.onDurationChanged.listen((duration) {
      setState(() => _duration = duration);
    });

    _positionSubscription = _audioPlayer.onPositionChanged.listen(
      (p) {
        setState(() => _position = p);
        widget.positionOnPressed(positionText);
      },
    );

    _playerCompleteSubscription = _audioPlayer.onPlayerComplete.listen((event) {
      _onComplete();
      setState(() {
        _position = _duration;
      });
    });

    // _audioPlayer.onPlayerStateChanged.listen((state) {
    //   if (mounted) {
    //     setState(() {
    //       _audioPlayerState = state;
    //     });
    //   }
    // });
  }

  _play() async {
    final playPosition = (_position != null &&
            _duration != null &&
            _position!.inMilliseconds > 0 &&
            _position!.inMilliseconds < _duration!.inMilliseconds)
        ? _position
        : null;
    if (widget.showLoader != null) {
      widget.showLoader!(true);
    }

    await _audioPlayer
        .play(UrlSource(widget.url), position: playPosition)
        .onError((error, stackTrace) {
      debugPrint('AUDIO_PLAYER_ERROR:----  $error');
      Utils.errorSnackBar(AppStrings.error, AppStrings.audioPlayingError);
      if (widget.showLoader != null) {
        widget.showLoader!(false);
      }
    });
    if (widget.showLoader != null) {
      widget.showLoader!(false);
    }
    if(_audioPlayer.state == PlayerState.playing){
      setState(() => _playerState = PlayerState.playing);
    }
  }

  _pause() async {
    await _audioPlayer.pause();
    setState(() => _playerState = PlayerState.paused);
  }

  // _stop() async {
  //   await _audioPlayer.stop();
  //   if (_audioPlayer.state == PlayerState.playing) {
  //     setState(() {
  //       _playerState = PlayerState.stopped;
  //       _position = const Duration();
  //     });
  //   }
  // }

  void _onComplete() {
    setState(() => _playerState = PlayerState.stopped);
  }

  void _muteAndUnMuteAudio() {
    if (_audioPlayer.state == PlayerState.playing ||
        _audioPlayer.state == PlayerState.paused) {
      setState(() {
        if (isAudioMute) {
          _audioPlayer.setVolume(1);
        } else {
          _audioPlayer.setVolume(0);
        }
        isAudioMute = !isAudioMute;
      });
    }
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight ?? 0.0;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
