import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plugin_haven/splash/bloc/index.dart';

class ImageSplashView extends StatelessWidget {
  const ImageSplashView({
    Key? key,
    required this.imageAsset,
    this.backgroundColor,
  }) : super(key: key);
  final String imageAsset;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SplashBloc>(context, listen: false)
        .add(RemoveSplashWaiterEvent());

    return Scaffold(
      backgroundColor: backgroundColor,
      key: GlobalKey(),
      body: Center(
        child: Image.asset(imageAsset),
      ),
    );
  }
}
