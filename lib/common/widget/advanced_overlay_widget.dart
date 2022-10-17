import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

import '../app_color.dart';
import '../app_strings.dart';
import 'audio_player_widget.dart';

class AdvancedOverlayWidget extends StatefulWidget {
  final VideoPlayerController? controller;
  final VoidCallback? onClickedFullScreen;
  final VoidCallback? onBackPressed;
  final bool isPortrait;

  const AdvancedOverlayWidget(
      {Key? key,
      required this.controller,
      this.onClickedFullScreen,
      this.onBackPressed,
      required this.isPortrait})
      : super(key: key);

  @override
  State createState() => _AdvancedOverlayWidgetState();
}

class _AdvancedOverlayWidgetState extends State<AdvancedOverlayWidget> {
  static const allSpeeds = <double>[0.25, 0.5, 1, 1.5, 2, 3, 5, 10];

  String getPosition() {
    final duration = Duration(
        milliseconds: widget.controller!.value.position.inMilliseconds.round());
    return duration.toString().split('.').first;
    // return [duration.inMinutes, duration.inSeconds]
    //     .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
    //     .join(':');
  }

  String getDuration() {
    final duration = Duration(
        milliseconds: widget.controller!.value.duration.inMilliseconds.round());
    return duration.toString().split('.').first;
  }

  Duration? _duration;
  Duration? _position;

  @override
  void initState() {
    _duration = widget.controller!.value.duration;
    _position = widget.controller!.value.position;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => widget.controller!.value.isPlaying
            ? widget.controller?.pause()
            : widget.controller?.play(),
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              buildPlay(),
              Positioned(
                  top: 0.0,
                  right: 0.0,
                  child: Row(
                    children: [
                      buildSpeed(),
                      widget.isPortrait
                          ? const SizedBox()
                          : SafeArea(
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                child: IconButton(
                                  onPressed: widget.onBackPressed,
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                    ],
                  )),
              Positioned(
                left: 8,
                bottom: 18,
                child: Text(
                  _position != null
                      ? '${getPosition()} / ${getDuration()}'
                      : _duration != null
                          ? getDuration()
                          : '00:00:00 / 00:00:00',
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontFamily: AppStrings.robotoFont,
                      fontWeight: FontWeight.w600,
                      color: AppColor.black),
                ),
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Row(
                    children: [
                      Expanded(child: buildIndicator(context)),
                      const SizedBox(width: 12),
                      GestureDetector(
                        child: const Icon(
                          Icons.fullscreen,
                          color: Colors.white,
                          size: 28,
                        ),
                        onTap: widget.onClickedFullScreen,
                      ),
                      const SizedBox(width: 8),
                    ],
                  )),
            ],
          ),
        ),
      );

  Widget buildIndicator(BuildContext context) {
    debugPrint('''
    
    (_position != null &&
                    _duration != null &&
                    _position!.inMilliseconds > 0 &&
                    _position!.inMilliseconds < _duration!.inMilliseconds)
                ? _position!.inMilliseconds / _duration!.inMilliseconds
                : 0.0
    
    ${(_position != null && _duration != null && _position!.inMilliseconds > 0 && _position!.inMilliseconds < _duration!.inMilliseconds) ? _position!.inMilliseconds / _duration!.inMilliseconds : 0.0}
        
    ${_position!.inMilliseconds / _duration!.inMilliseconds}
    ''');

    return Container(
      margin: const EdgeInsets.all(8).copyWith(right: 0),
      height: 8,
      child: SliderTheme(
        data: SliderTheme.of(context).copyWith(
          trackShape: CustomTrackShape(),
          thumbColor: AppColor.red,
          activeTickMarkColor: AppColor.red,
          activeTrackColor: AppColor.red,
        ),
        child: Slider(
          onChanged: (v) {
            final duration = widget.controller?.value.duration;
            if (duration == null) {
              return;
            }
            final position = v * duration.inMilliseconds;

            widget.controller?.seekTo(Duration(milliseconds: position.round()));
          },
          value: (widget.controller != null &&
                  widget.controller!.value.position.inMilliseconds > 0 &&
                  widget.controller!.value.position.inMilliseconds <
                      widget.controller!.value.duration.inMilliseconds)
              ? widget.controller!.value.position.inMilliseconds /
                  widget.controller!.value.duration.inMilliseconds
              : 0.0,
        ),
      ),
      // child: VideoProgressIndicator(
      //   controller!,
      //   colors: const VideoProgressColors(playedColor: AppColor.red),
      //   allowScrubbing: true,
      // ),
    );
  }

  Widget buildSpeed() => Align(
        alignment: Alignment.topRight,
        child: PopupMenuButton<double>(
          initialValue: widget.controller!.value.playbackSpeed,
          tooltip: 'Playback speed',
          onSelected: widget.controller!.setPlaybackSpeed,
          itemBuilder: (context) => allSpeeds
              .map<PopupMenuEntry<double>>((speed) => PopupMenuItem(
                    value: speed,
                    child: Text('${speed}x'),
                  ))
              .toList(),
          child: Container(
            color: Colors.white38,
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
            child: Text('${widget.controller!.value.playbackSpeed}x'),
          ),
        ),
      );

  Widget buildPlay() => widget.controller!.value.isPlaying
      ? const SizedBox()
      : Container(
          color: Colors.transparent,
          alignment: Alignment.center,
          child: const Icon(
            Icons.play_arrow,
            color: Colors.white,
            size: 70,
          ),
        );
}
