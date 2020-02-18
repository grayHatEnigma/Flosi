import 'package:expense_manager/constants.dart';
import 'package:expense_manager/domain/manager_ui_contract.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:provider/provider.dart';

class IntroScreen extends StatefulWidget {
  final title;
  IntroScreen({this.title});
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  // to determine whether there is an existing plan or create a new one
  bool createPlan;
  final duration = Duration(milliseconds: 4000);

  @override
  void initState() {
    super.initState();
    // delayed navigation to either home or salary screen
    Future.delayed(
      Duration(milliseconds: 4500),
      () => Navigator.pushReplacementNamed(
          context, createPlan ? kPlanSalaryScreenID : kHomeScreenID),
    );
    controller = AnimationController(vsync: this, duration: duration);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final manager = Provider.of<ManagerUiContract>(context);
    createPlan = !manager.hasPlan;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                widget.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 45,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: FadeTransition(
                child: Image.asset('images/intro.png'),
                opacity: animation,
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                width: 200,
                child: FAProgressBar(
                  direction: Axis.horizontal,
                  size: 20,
                  animatedDuration: duration,
                  backgroundColor: Theme.of(context).primaryColorDark,
                  progressColor: Theme.of(context).accentColor,
                  currentValue: 100,
                  displayText: '%',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // dispose the animation controller to avoid memory leaks.
    controller.dispose();
    super.dispose();
  }
}
