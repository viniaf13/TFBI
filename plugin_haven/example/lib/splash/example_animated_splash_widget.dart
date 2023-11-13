import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plugin_haven/splash/bloc/splash_bloc.dart';
import 'package:plugin_haven/splash/bloc/splash_event.dart';

class ExampleAnimatedSplashWidget extends StatefulWidget {
  const ExampleAnimatedSplashWidget({super.key});

  @override
  State<ExampleAnimatedSplashWidget> createState() =>
      _ExampleAnimatedSplashWidgetState();
}

class _ExampleAnimatedSplashWidgetState
    extends State<ExampleAnimatedSplashWidget> {
  @override
  void initState() {
    super.initState();
    Future<void>.delayed(const Duration(milliseconds: 1), () {
      setState(() {
        open = true;
      });
    });

    Future<void>.delayed(animationDuration, () {
      BlocProvider.of<SplashBloc>(context).add(RemoveSplashWaiterEvent());
    });
  }

  bool open = false;
  Duration animationDuration = const Duration(seconds: 2);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: AnimatedOpacity(
                duration: animationDuration - const Duration(milliseconds: 100),
                opacity: open ? 1 : 0,
                child: AnimatedContainer(
                  duration:
                      animationDuration - const Duration(milliseconds: 100),
                  curve: Curves.easeInSine,
                  width: open ? MediaQuery.of(context).size.width : 0,
                  color: open ? Colors.blue : Colors.white,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
