import 'package:flutter/material.dart';
import 'package:flutter_project_structure/customWidgtes/dialog_helper.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';

import '../../../constants/app_string_constant.dart';

class QuantityDropDown extends StatefulWidget {
  const QuantityDropDown(this.onDropDownChange,this.intitialValue, {Key? key}) : super(key: key);

  final ValueChanged<String> onDropDownChange;
  final int? intitialValue;

  @override
  _QuantityDropDownState createState() => _QuantityDropDownState();
}

class _QuantityDropDownState extends State<QuantityDropDown> {
  late int _value;
  late AppLocalizations? _localizations;

  @override
  void initState() {
    _value = widget.intitialValue ?? 1;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        hint: Text(
          "${_localizations?.translate(AppStringConstant.qty)} $_value",
          style: Theme.of(context).textTheme.subtitle2?.copyWith(fontSize: 14),
        ),
        items: ["1", "2", "3", "4", "5", "M"]
            .map(
              (element) => DropdownMenuItem<String>(
                child: Text(element),
                value: element,
              ),
            )
            .toList(),
        onChanged: (String? value) {
          if (value == null) {
            widget.onDropDownChange("1");
            setState(() {
              _value = 1;
            });
            return;
          }
          if (value == "M") {
            DialogHelper.quantityDialog(context, _localizations,
                onSave: (value) {
              setState(() {
                _value = int.tryParse(value) ?? 1;
              });
              widget.onDropDownChange(value);
            }, initialValue: _value.toString());
            return;
          }
          setState(() {
            _value = int.tryParse(value) ?? 1;
          });
          widget.onDropDownChange(value);
        },
      ),
    );
  }
}
