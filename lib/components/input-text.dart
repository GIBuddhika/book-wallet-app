import 'package:flutter/material.dart';
import 'package:flutter_application_1/helpers/form-validation.dart';
import 'package:flutter_application_1/model/validation.dart';

class InputText extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final bool obscureText;
  final List validators;
  final StringCallback callback;

  InputText({
    required this.label,
    required this.controller,
    required this.validators,
    this.obscureText = false,
    required this.callback,
  });

  @override
  _InputTextState createState() =>
      _InputTextState(obscureText: this.obscureText);
}

typedef void StringCallback(bool val);

class _InputTextState extends State<InputText> {
  bool obscureText;
  final FormValidation formValidation = FormValidation();

  _InputTextState({this.obscureText = false});

  void _toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 15),
      child: TextFormField(
        validator: (text) {
          final validationData =
              formValidation.validate(text, widget.validators);
          if (!validationDataFromJson(validationData).isValid) {
            return validationDataFromJson(validationData).errMessage;
          }
        },
        controller: widget.controller,
        obscureText: obscureText,
        cursorColor: Colors.black,
        onChanged: (value) {
          final validationData =
              formValidation.validate(value, widget.validators);
          if (!validationDataFromJson(validationData).isValid) {
            widget.callback(false);
          } else {
            widget.callback(true);
          }
        },
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.only(bottom: 2),
          labelText: widget.label,
          suffixIconConstraints: BoxConstraints(
            minHeight: 40,
            minWidth: 32,
          ),
          labelStyle: TextStyle(
            color: Colors.black,
          ),
          suffixIcon: widget.obscureText
              ? GestureDetector(
                  onTap: _toggle,
                  child: Icon(
                    obscureText
                        ? Icons.visibility_off_rounded
                        : Icons.visibility_rounded,
                    size: 20,
                    color: Colors.black,
                  ),
                )
              : null,
          fillColor: Colors.white,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
