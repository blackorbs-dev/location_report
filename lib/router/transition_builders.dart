import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

CustomTransitionPage<T> fadeTransition<T>({
  required LocalKey key,
  required Widget child,
  Duration duration = const Duration(milliseconds: 400),
}) {
  return CustomTransitionPage<T>(
    key: key,
    child: child,
    transitionDuration: duration,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );
}

CustomTransitionPage<T> slideTransition<T>({
  required LocalKey key,
  required Widget child,
  Offset beginOffset = const Offset(0, 0.3),
  Duration duration = const Duration(milliseconds: 300),
}) {
  return CustomTransitionPage<T>(
    key: key,
    child: child,
    transitionDuration: duration,
    reverseTransitionDuration: const Duration(milliseconds: 200),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final offset = Tween<Offset>(
        begin: beginOffset,
        end: Offset.zero,
      ).animate(animation);
      return SlideTransition(position: offset, child: child);
    },
  );
}

CustomTransitionPage<T> scaleTransition<T>({
  required LocalKey key,
  required Widget child,
  Duration duration = const Duration(milliseconds: 400),
}) {
  return CustomTransitionPage<T>(
    key: key,
    child: child,
    transitionDuration: duration,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return ScaleTransition(
        scale: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
        child: child,
      );
    },
  );
}

CustomTransitionPage flipTransition({
  required LocalKey key,
  required Widget child,
  Duration duration = const Duration(milliseconds: 500),
}) {
  return CustomTransitionPage(
    key: key,
    child: child,
    transitionDuration: duration,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final rotateAnim = Tween<double>(begin: 1, end: 0).animate(
        CurvedAnimation(parent: animation, curve: Curves.easeInOut),
      );

      return AnimatedBuilder(
        animation: rotateAnim,
        child: child,
        builder: (context, child) {
          final angle = rotateAnim.value * pi; // pi radians = 180°
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001) // perspective
              ..rotateY(angle),
            child: child,
          );
        },
      );
    },
  );
}

