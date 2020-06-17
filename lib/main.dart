import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_web/firebase_auth_web.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

double width1 = 0, height1 = 0;
FirebaseAuthWeb auth;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cihan',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

AnimationController rotationController;
AnimationController _scaleController;

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  initState() {
    _scaleController = AnimationController(
        duration: Duration(
          milliseconds: 300,
        ),
        vsync: this);
    _scaleController.forward();
    rotationController =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    rotationController
        .forward()
        .whenComplete(() => rotationController.repeat());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Widget AnimatedLogo() {
      return LayoutBuilder(builder: (BuildContext context, constraints) {
        return Positioned(
          top: 40,
          left: 40,
          child: Container(
            alignment: Alignment.center,
            child: RotationTransition(
                turns: Tween(begin: 0.0, end: 1.0).animate(rotationController),
                child: Image.asset('assets/images/anisun.png')),
            width: size.width / 12,
            height: size.width / 12,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/logo2.png'))),
          ),
        );
      });
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          setState(() {
            _scaleController.reverse();
          })
        },
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      'assets/images/background.jpg',
                    ),
                    fit: BoxFit.cover)),
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 100,
                  ),
                  LayoutBuilder(
                    builder: (BuildContext context, contstraints) {
                      return ScaleTransition(
                        scale: Tween<double>(begin: 0, end: 1)
                            .animate(_scaleController),
                        child: Container(
                          alignment: Alignment.center,
                          width: size.width / 2,
                          height: size.height / 1.5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: SelectableText('Sign In',
                                    style:
                                        Theme.of(context).textTheme.headline3),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(30),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        width: size.width / 4.5,
                                        child: TextField(
                                          decoration: InputDecoration(
                                            prefixIcon:  Padding(
                                              padding: const EdgeInsets.only(left: 4,right: 4),
                                              child: Container(
                                                decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.green),
                                          width: 40,
                                          height: 40,
                                          alignment: Alignment.center,
                                          child: Icon(Icons.email,color: Colors.white,)),
                                            ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(35),
                                              ),
                                              labelText: 'Email Address'),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Container(
                                          width: size.width / 4.5,
                                          child: TextField(
                                              obscureText: true,
                                              decoration: InputDecoration(
                                                prefixIcon: Padding(
                                              padding: const EdgeInsets.only(left: 4,right: 4),
                                              child: Container(
                                                decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.green),
                                          width: 40,
                                          height: 40,
                                          alignment: Alignment.center,
                                          child: Icon(Icons.lock,color: Colors.white,)),
                                            ),
                                                labelText: 'Password',
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(35),
                                                ),
                                              )),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          AnimatedLogo()
        ],
      ),
    );
  }
}
