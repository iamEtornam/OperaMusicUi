import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Opera Music',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
      ),
      home: PlayerPage(),
    );
  }
}

class PlayerPage extends StatefulWidget {
  @override
  _PlayerPageState createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage>
    with SingleTickerProviderStateMixin {
  double _volumeValue = 0.0;
  double _seekerValue = 0.00;
  AnimationController _animationController;
  bool _isPlaying = false;
  AnimatedIconData _animatedIcon;

  void iconState() {
    if (_isPlaying) {
      _animationController.forward();
      setState(() {
        _isPlaying = false;
        _animatedIcon = AnimatedIcons.pause_play;
      });
    } else {
      _animationController.reverse();
      setState(() {
        _isPlaying = true;
      });
    }
  }

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    iconState();
    super.initState();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(246, 230, 20, 1),
        body: Container(
          height: MediaQuery.of(context).size.height / 2,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: ExactAssetImage('assets/images/music_img.png'),
                  fit: BoxFit.contain)),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
          height: MediaQuery.of(context).size.height / 2,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              musicSeeker(),
              trackDetails(),
              trackControllers(),
              volumnController(),
              additionalOptions()
            ],
          ),
        ),
      ),
    );
  }

  Widget musicSeeker() {
    return Column(
      children: <Widget>[
        Slider(
          onChanged: (val) {
            setState(() {
              _seekerValue = val;
            });
          },
          value: _seekerValue,
          max: 100.0,
          min: 0.0,
          activeColor: Colors.black,
          divisions: 2,
          inactiveColor: Colors.black38,
          onChangeStart: (val) {
            setState(() {
              _seekerValue = val;
            });
          },
          onChangeEnd: (val) {
            setState(() {
              _seekerValue = val;
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text('1:13',
                  style: TextStyle(fontSize: 12.0, color: Colors.black26)),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Text('-2:10',
                  style: TextStyle(fontSize: 12.0, color: Colors.black26)),
            )
          ],
        )
      ],
    );
  }

  Widget trackDetails() {
    return Column(
      children: <Widget>[
        Text(
          'Losing My Mind',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        Text(
          'Charlir Puth - Nine Track Mind',
          style: TextStyle(fontSize: 16.0, color: Colors.black38),
        )
      ],
    );
  }

  Widget trackControllers() {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        padding: EdgeInsets.only(bottom: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.fast_rewind,
                color: Colors.black,
                size: 50.0,
              ),
            ),
            SizedBox(
              width: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 5.0, bottom: 5.0),
              child: IconButton(
                onPressed: () {
                  if (_isPlaying) {
                    _animationController.forward();
                    setState(() {
                      _isPlaying = false;
                      _animatedIcon = AnimatedIcons.pause_play;
                    });
                  } else {
                    _animationController.reverse();
                    setState(() {
                      _isPlaying = true;
                    });
                  }
                },
                icon: AnimatedIcon(
                  progress: _animationController,
                  icon: _animatedIcon,
                  color: Colors.black,
                  size: 60.0,
                ),
              ),
            ),
            SizedBox(
              width: 15.0,
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.fast_forward,
                color: Colors.black,
                size: 50.0,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget volumnController() {
    return Stack(
      alignment: Alignment.centerLeft,
      children: <Widget>[
        Icon(
          Icons.volume_mute,
          color: Colors.black,
          size: 15,
        ),
        Positioned(
          left: 15.0,
          right: 15.0,
          child: Slider(
            onChanged: (val) {
              setState(() {
                _volumeValue = val;
              });
            },
            value: _volumeValue,
            max: 100.0,
            min: 0.0,
            activeColor: Colors.black,
            divisions: 2,
            inactiveColor: Colors.black38,
            onChangeStart: (val) {
              setState(() {
                _volumeValue = val;
              });
            },
            onChangeEnd: (val) {
              setState(() {
                _volumeValue = val;
              });
            },
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Icon(
            Icons.volume_up,
            color: Colors.black,
            size: 15,
          ),
        ),
      ],
    );
  }

  Widget additionalOptions() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        IconButton(
            onPressed: () {},
            icon: Icon(
              MaterialIcons.getIconData("favorite-border"),
              color: Colors.black,
              size: 20.0,
            )),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Feather.getIconData("repeat"),
              color: Colors.black,
              size: 20.0,
            )),
        IconButton(
          onPressed: () {},
          icon: Icon(
            SimpleLineIcons.getIconData("shuffle"),
            color: Colors.black,
            size: 20.0,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Feather.getIconData("more-horizontal"),
            color: Colors.black,
            size: 20.0,
          ),
        )
      ],
    );
  }
}
