import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isDisabled;
  final Gradient gradient;

  GradientButton({
    required this.onPressed,
    required this.isLoading,
    required this.isDisabled,
    required this.child,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: isDisabled ? null : onPressed,
      child: isDisabled
          ? Ink(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                  constraints: BoxConstraints(maxWidth: 150.0, minHeight: 50.0),
                  alignment: Alignment.center,
                  child: child),
            )
          : Ink(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: gradient,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                  constraints: BoxConstraints(maxWidth: 150.0, minHeight: 50.0),
                  alignment: Alignment.center,
                  child: isLoading
                      ? SizedBox(
                          height: 25,
                          width: 25,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : child),
            ),
      splashColor: Colors.black12,
      padding: EdgeInsets.all(0),
    );
  }
}
