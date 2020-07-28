import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  final Stream<double> Function() initializeStream;

  const SplashPage({
    Key key,
    @required this.initializeStream,
  }) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Color> color;
  Stream<double> initStream;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    color = ColorTween(begin: Colors.pinkAccent, end: Colors.redAccent)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.ease));
    _controller.repeat(reverse: true);
    initStream = widget.initializeStream();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(
              flex: 10,
            ),
            AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Text(
                    "Atlezz",
                    style: TextStyle(
                      fontSize: 80,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.bold,
                      color: color.value,
                    ),
                  );
                }),
            Spacer(),
            StreamBuilder<double>(
                stream: initStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    print("go to next scene");
                  }
                  return AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return CircularProgressIndicator(
                          valueColor: color,
                          value: snapshot.data ?? 0,
                          semanticsLabel: "Startup progress",
                          strokeWidth: 10,
                        );
                      });
                }),
            Spacer(
              flex: 10,
            ),
          ],
        ),
      ),
    );
  }
}
