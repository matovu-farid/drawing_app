import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:scoped_model/scoped_model.dart';
import 'main.dart';
import 'package:toast/toast.dart';

import 'model.dart';

class ColorButton extends StatelessWidget {
  const ColorButton({
    Key key,

  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showToast('Pick a color', context, gravity: Toast.BOTTOM);
        showDialog(
          context: context,
          child: AlertDialog(
            title: const Text('Pick a color!'),
            content: SingleChildScrollView(
              child: ScopedModelDescendant<MyModel>(
                builder: (context, child,model) {
                  return ColorPicker(
                    pickerColor: model.previousColor,
                    onColorChanged: model.changeColor,
                    showLabel: true,
                    pickerAreaHeightPercent: 0.8,
                  );
                }
              ),
            ),
            actions: <Widget>[
              ScopedModelDescendant<MyModel>(
                builder: (context, child, model) {
                  return FlatButton(
                    child: const Text('Got it'),
                    onPressed: () {
                      model.selectedColor = model.previousColor;
                      Navigator.of(context).pop();
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
      tooltip: 'choose color',
      child: Icon(
        FontAwesome.dashboard,
      ),
    );
  }
}