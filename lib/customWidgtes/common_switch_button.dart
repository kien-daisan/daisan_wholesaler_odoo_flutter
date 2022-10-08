import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import '../config/theme.dart';


class CommonSwitchButton extends StatefulWidget {
  bool isOn;
  final String title;
  final ValueChanged<bool> callback;
  Color? colors;
  CommonSwitchButton(this.title, this.callback,this.isOn, {Key? key, this.colors}) : super(key: key);

  @override
  State<CommonSwitchButton> createState() => _CommonSwitchButtonState();
}

class _CommonSwitchButtonState extends State<CommonSwitchButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.colors,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Switch(
            activeColor: Theme.of(context).colorScheme.onPrimary,
            value: widget.isOn,
            onChanged: (value) {
              setState(() {
                widget.isOn = value;
                widget.callback(widget.isOn);
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.all(AppSizes.imageRadius),
            child: Text(widget.title, style: Theme.of(context).textTheme.headline6?.copyWith(fontWeight: FontWeight.normal)),
          ),
        ],
      ),
    );
  }
}