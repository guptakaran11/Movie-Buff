// ignore_for_file: must_be_immutable

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  double? height;
  double? width;

  HomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return buildUI();
  }

  Widget buildUI() {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: height,
        width: width,
        child: Stack(
          alignment: Alignment.center,
          children: [
            backgrouondWidget(),
          ],
        ),
      ),
    );
  }

  Widget backgrouondWidget() {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          10.0,
        ),
        image: const DecorationImage(
          image: NetworkImage(
            'https://img00.deviantart.net/ebb2/i/2017/243/0/d/godzilla_by_tatianamakeeva-db1d5c6.png',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 10.0,
          sigmaY: 10.0,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(
              0.1,
            ),
          ),
        ),
      ),
    );
  }
}
