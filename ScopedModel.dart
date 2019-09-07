import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:async';
import 'package:speech_recognition/speech_recognition.dart';

class HelloMan extends StatefulWidget {
  HelloMan({Key key}) : super(key: key);

  _HelloManState createState() => _HelloManState();
}

class _HelloManState extends State<HelloMan> {
  
  @override
  Widget build(BuildContext context) {
    return RotateMi(model: CounterModel());
     
  }
}



class RotateMi extends StatefulWidget {
  final CounterModel model;
  RotateMi({this.model, Key key}) : super(key: key);

  _RotateMiState createState() => _RotateMiState();
}

class _RotateMiState extends State<RotateMi> {
  int _turns;
  double _value;
  double _x, _y, _z;
  int count = 0;
  bool df = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _x = _y = _z = 0.0;
  }

  void _onChanged(double value) {
    setState(() {
      _turns = value.toInt();
      _value = value;
    });
  }

  final GlobalKey<ScaffoldState> abc = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return ScopedModel<CounterModel>(
      model: widget.model,
      child: MaterialApp(
        home: Scaffold(
          key: abc,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() {
                if (df) {
                  df = false;
                } else {
                  df = true;
                }

                abc.currentState.showBottomSheet((context) => df
                    ? ScopedModelDescendant<CounterModel>(
                        builder: (context, child, model) {
                          return Row(
                            children: <Widget>[
                              Text(
                                model.counter.toString(),
                                style: Theme.of(context).textTheme.display1,
                              ),
                              ScopedModelDescendant<CounterModel>(
                                  builder: (context, child, model) {
                                return RaisedButton(onPressed: model.zero);
                              }),
                            ],
                          );
                        },
                      )
                    : Offstage());
              });
            },
          ),

          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ScopedModelDescendant<CounterModel>(
                  builder: (context, child, model) {
                    return Text(
                      model.counter.toString(),
                      style: Theme.of(context).textTheme.display1,
                    );
                  },
                ),
                ScopedModelDescendant<CounterModel>(
                    builder: (context, child, model) {
                  return RaisedButton(onPressed: model.increment);
                }),
              ],
            ),
          ),
 
        ),
      ),
    );
  }
}

class CounterModel extends Model {
  int _counter = 0;

  int get counter => _counter;

  void increment() {
    // First, increment the counter
    _counter++;

    // Then notify all the listeners.
    notifyListeners();
  }

  void zero() {
    _counter = 0;
    notifyListeners();
  }
}
