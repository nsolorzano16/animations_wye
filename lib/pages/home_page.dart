import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _slideAnimation;
  Animation<double> _sizeAnimation;
  Animation<double> _fadeAnimation;
  Animation<AlignmentGeometry> _alignAnimation;
  Animation<double> _scaleTransition;
  Animation<Decoration> _decoratedBoxTransition;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 2,
      ),
    );

    _slideAnimation = Tween<Offset>(
        begin: Offset.zero,
        end: Offset(
          1.5,
          0.0,
        )).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticIn,
    ));

    _sizeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
      reverseCurve: Curves.bounceInOut,
    );

    _fadeAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(_controller);

    _alignAnimation = Tween<AlignmentGeometry>(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ).animate(_controller);

    _scaleTransition = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);

    _decoratedBoxTransition = DecorationTween(
        begin: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Color(0x66666666),
              blurRadius: 10.0,
              spreadRadius: 3.0,
              offset: Offset(0, 6.0),
            )
          ],
        ),
        end: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(30),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Color(0x66666666),
              blurRadius: 10.0,
              spreadRadius: 3.0,
              offset: Offset(0, 6.0),
            )
          ],
        )).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const titleStyle = TextStyle(
      color: Colors.black,
      fontSize: 22,
      fontWeight: FontWeight.bold,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Animations'),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          _TitleLabel(titleStyle: titleStyle, text: 'Align Transition'),
          Center(
            child: Container(
              height: 150,
              width: 150,
              child: AlignTransition(
                alignment: _alignAnimation,
                child: _Cuadrado(),
              ),
            ),
          ),
          _TitleLabel(titleStyle: titleStyle, text: 'Rotation Transition'),
          Center(
            child: RotationTransition(
              turns: _controller,
              child: _Cuadrado(),
            ),
          ),
          _TitleLabel(titleStyle: titleStyle, text: 'Slide Transition'),
          Center(
            child: SlideTransition(
              position: _slideAnimation,
              child: _Cuadrado(),
            ),
          ),
          _TitleLabel(titleStyle: titleStyle, text: 'Size Transition'),
          Center(
            child: SizeTransition(
              sizeFactor: _sizeAnimation,
              child: _Cuadrado(),
            ),
          ),
          _TitleLabel(titleStyle: titleStyle, text: 'Fade Transition'),
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: _Cuadrado(),
            ),
          ),
          _TitleLabel(titleStyle: titleStyle, text: 'Scale Transition'),
          Center(
            child: ScaleTransition(
              scale: _scaleTransition,
              alignment: Alignment.center,
              child: _Cuadrado(),
            ),
          ),
          _TitleLabel(titleStyle: titleStyle, text: 'Positioned Transition'),
          Container(
            width: double.infinity,
            height: 300,
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final biggest = constraints.biggest;
                return Stack(
                  children: [
                    PositionedTransition(
                      rect: RelativeRectTween(
                        begin: RelativeRect.fromSize(
                            Rect.fromLTWH(0, 0, 100, 100), biggest),
                        end: RelativeRect.fromSize(
                            Rect.fromLTWH(biggest.width - 100,
                                biggest.height - 100, 100, 100),
                            biggest),
                      ).animate(_controller),
                      child: _Cuadrado(),
                    )
                  ],
                );
              },
            ),
          ),
          _TitleLabel(titleStyle: titleStyle, text: 'Decorated Box Transition'),
          Center(
            child: DecoratedBoxTransition(
              decoration: _decoratedBoxTransition,
              child: Container(
                width: 100,
                height: 100,
                child: FlutterLogo(
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.red,
            onPressed: () => _controller.reset(),
            child: Icon(
              Icons.update,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            backgroundColor: Colors.red,
            onPressed: () => _controller.repeat(),
            child: Icon(
              Icons.play_arrow,
            ),
          ),
        ],
      ),
    );
  }
}

class _TitleLabel extends StatelessWidget {
  final String text;
  final TextStyle titleStyle;

  const _TitleLabel({
    Key key,
    @required this.titleStyle,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: titleStyle,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _Cuadrado extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: Colors.red,
    );
  }
}

/* 
------Transitions Widgets------
RotationTransition
SlideTransition
SizeTransition
FadeTransition
AlignTransition
ScaleTransition
PositionedTransition
DecoratedBoxTransition
DefaultTextStyleTransition,
RelativePositionedTransition,
StatusTransitionWidget
*/
