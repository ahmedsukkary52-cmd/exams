import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/theme_app.dart';

class ExamHeader extends StatefulWidget implements PreferredSizeWidget {
  final Duration duration;
  final VoidCallback onBack;
  final VoidCallback onTimeFinished;
  final bool startTimer;
  const ExamHeader({
    super.key,
    required this.duration,
    required this.onBack,
    required this.onTimeFinished,
    required this.startTimer
  });

  @override
  State<ExamHeader> createState() => _ExamHeaderState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _ExamHeaderState extends State<ExamHeader> {
  late Duration remaining;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    remaining = widget.duration;

    if (widget.startTimer) {
      _startTimer();
    }
  }

  @override
  void didUpdateWidget(covariant ExamHeader oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!oldWidget.startTimer && widget.startTimer) {
      _startTimer();
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    timer?.cancel();

    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (remaining.inSeconds <= 1) {
        timer?.cancel();

        setState(() {
          remaining = Duration.zero;
        });

        widget.onTimeFinished();
        return;
      }

      setState(() {
        remaining -= const Duration(seconds: 1);
      });
    });
  }


  Color get timerColor {
    final percentage = remaining.inSeconds / widget.duration.inSeconds;

    if (percentage <= 0.5) {
      return Colors.red;
    }

    if (percentage <= 0.75) {
      return Colors.orange;
    }

    return const Color(0xFF34C759);
  }

  String get formattedTime {
    final minutes = remaining.inMinutes.remainder(60);
    final seconds = remaining.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ThemeApp.colors.whiteColor,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      titleSpacing: 0,
      leading: IconButton(
        onPressed: widget.onBack,
        icon: const Icon(Icons.arrow_back_ios_new),
      ),
      title: Text(
        'Exam',
        style: ThemeApp.text.medium20black,
      ),
      actions: [
        const Icon(
          Icons.alarm,
          color: Color(0xff6CAFE6),
        ),
        SizedBox(width: 6.w),
        Padding(
          padding: EdgeInsets.only(right: 16.w),
          child: Center(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: widget.startTimer
                  ? AnimatedDefaultTextStyle(
                key: const ValueKey('timer'),
                duration: const Duration(milliseconds: 250),
                style: ThemeApp.text.medium20blue.copyWith(
                  color: timerColor,
                ),
                child: Text(formattedTime),
              )
                  : Container(
                key: const ValueKey('loading'),
                width: 56.w,
                height: 22.h,
                decoration: BoxDecoration(
                  color: ThemeApp.colors.lightGrayColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: const _TimerLoading(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _TimerLoading extends StatefulWidget {
  const _TimerLoading();

  @override
  State<_TimerLoading> createState() => _TimerLoadingState();
}

class _TimerLoadingState extends State<_TimerLoading> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 58.w,
      height: 22.h,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (_, __) {
            return ShaderMask(
              shaderCallback: (bounds) {
                return LinearGradient(
                  begin: Alignment(
                    -1.5 + (_controller.value * 3),
                    0,
                  ),
                  end: Alignment(
                    -0.5 + (_controller.value * 3),
                    0,
                  ),
                  colors: [
                    ThemeApp.colors.grayColor.withValues(alpha: .18),
                    ThemeApp.colors.grayColor.withValues(alpha: .45),
                    ThemeApp.colors.grayColor.withValues(alpha: .18),
                  ],
                  stops: const [0.25, 0.5, 0.75],
                ).createShader(bounds);
              },
              blendMode: BlendMode.srcATop,
              child: Container(
                decoration: BoxDecoration(
                  color: ThemeApp.colors.grayColor.withValues(alpha: .22),
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}