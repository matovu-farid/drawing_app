import 'package:drawing_app/hand_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_fluid_slider/flutter_fluid_slider.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:toast/toast.dart';

import 'options.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Drawing App',
      theme: ThemeData(

        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Drawing App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);



  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color selectedColor = Colors.amberAccent;
  Color pickerColor = Colors.amberAccent;
  int _counter = 0;


  List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.amber,
    Colors.black
  ];




  Option optionSelected = Option.HAND;
  Color previousColor ;
  void changing_option(Option option){

    setState(() {
      optionSelected = option;
    });
  }
  double stokeWidth = 5;


  @override
  Widget build(BuildContext context) {
    void changeColor(Color color) {
      setState(() => pickerColor = color);
    }



    return Scaffold(

      appBar: AppBar(

        title: Center(child: Text(widget.title)),
      ),
      body: Center(

        child: Stack(
          children: <Widget>[

            MyDrawer( selectedColor: selectedColor,pickedColor:pickerColor,strokeWidth:stokeWidth,drawingOption: optionSelected,),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 100,right: 10,top: 10),
                child: RotatedBox(
                  quarterTurns: -1,
                  child: FluidSlider(
                    thumbDiameter: 35,
                    value: stokeWidth,
                    onChanged: (double newValue) {
                      setState(() {
                        stokeWidth = newValue;
                      });
                    },
                    min: 0.0,
                    max: 20.0,
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,

          children: [
            FloatingActionButton(
              onPressed: ()=>changing_option(Option.PENCIL),

              tooltip: 'Increment',
              child: Icon(FontAwesome.pencil,color: optionSelected==Option.PENCIL?Colors.green:Colors.white,),
            ),
            FloatingActionButton(
              child: Icon(FontAwesome.hand_pointer_o,color: optionSelected==Option.HAND?Colors.green:Colors.white,),
              onPressed: (){
                if(optionSelected==Option.RUBBER){
                  selectedColor = previousColor ??Colors.yellow;

                }
                changing_option(Option.HAND);},
              tooltip: 'Increment',
            ),FloatingActionButton(
              onPressed: (){
                showToast('Pick a color', context,gravity: Toast.BOTTOM);
                showDialog(
                  context: context,
                  child: AlertDialog(
                    title: const Text('Pick a color!'),
                    content: SingleChildScrollView(
                      child: ColorPicker(
                        pickerColor: pickerColor,
                        onColorChanged: changeColor,
                        showLabel: true,
                        pickerAreaHeightPercent: 0.8,
                      ),

                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: const Text('Got it'),
                        onPressed: () {
                          setState(() => selectedColor = pickerColor);
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                );
              },
              tooltip: 'choose color',
              child: Icon(FontAwesome.dashboard,),

            ),

            FloatingActionButton(

              onPressed: ()=>changing_option(Option.SQUARE),

              tooltip: 'square',
              child: Icon(FontAwesome.square_o,color: optionSelected==Option.SQUARE?Colors.green:Colors.white,),

            ),FloatingActionButton(
              onPressed: (){
                showDialog(
                    context: context,
                  child: AlertDialog(
                    content: Wrap(
                      spacing: 2,
                      children: [
                        FloatingActionButton(
                          onPressed: (){

                            changing_option(Option.RUBBER);
                            showToast('Eraser', context);

                            },
                          child: Icon(FontAwesome.eraser,),


                          tooltip: 'Eraser',
                        ),
                        FloatingActionButton(
                          onPressed: () {
                            changing_option(Option.CIRCLE);
                            showToast('Circle', context);

                          },
                          child: Icon(FontAwesome.circle_o),
                        ),
                        FloatingActionButton(
                            onPressed: () {
                              changing_option(Option.OVAL);
                              showToast('Oval', context);
                            },
                            child: Icon(FontAwesome.circle),
                          ),
                        FloatingActionButton(
                          onPressed: () {
                            changing_option(Option.RECTANGLE);
                            showToast('Oval', context);
                          },
                          child: Icon(FontAwesome.times_rectangle),
                        ),
                        ],
                    ),
                    actions: [
                      FlatButton(
                        child: const Text('Done'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  )

                );
              },
              tooltip: 'Increment',
              child: Icon(Icons.add),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
void showToast(String msg, BuildContext context, {int duration, int gravity}) {
  Toast.show(msg, context, duration: duration, gravity: gravity);
}