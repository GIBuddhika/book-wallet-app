import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/button.dart';
import 'package:flutter_application_1/components/input-text.dart';
import 'package:flutter_application_1/curved-navigation.dart';
import 'package:flutter_application_1/handlers/auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextStyle basicStyle = TextStyle(color: Colors.white, fontSize: 16);
  Gradient gradient1 = LinearGradient(
    colors: [
      Colors.blue.withOpacity(0.8),
      Colors.cyan.withOpacity(0.8),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  TextEditingController emailController = new TextEditingController();
  TextEditingController passController = new TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isDisabled = false;
  bool isSubmitted = false;
  bool isLoading = false;
  bool isLoggingFailed = true;

  void validateForm(val) {
    if (isSubmitted) {
      setState(() {
        if (_formKey.currentState!.validate()) {
          this.isDisabled = false;
        } else {
          this.isDisabled = true;
        }
      });
    }
  }

  final storage = FlutterSecureStorage();

  setAuthData(apiToken) async {
    await storage.write(key: 'token', value: apiToken);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CurvedNavigation(data: 'data')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/signup2.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: FittedBox(
                child: Container(
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 15, top: 15),
                          child: Center(
                            child: Image.asset(
                              "images/welcome.png",
                              height: 75,
                            ),
                          ),
                        ),
                        InputText(
                          label: 'Email',
                          controller: emailController,
                          validators: ['email', 'required'],
                          callback: (val) {
                            validateForm(val);
                          },
                        ),
                        InputText(
                          label: 'Password',
                          controller: passController,
                          validators: ['required'],
                          obscureText: true,
                          callback: (val) {
                            validateForm(val);
                          },
                        ),
                        if (isLoggingFailed) ...[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Invalid credentials. Please try again.',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          )
                        ],
                        GradientButton(
                          child: Text(
                            "Login",
                            style: basicStyle,
                          ),
                          isLoading: this.isLoading,
                          onPressed: () async {
                            setState(() {
                              isDisabled = false;
                              this.isSubmitted = true;
                              this.isLoading = true;
                            });
                            if (_formKey.currentState!.validate()) {
                              try {
                                final results = await Auth().login(
                                  emailController.text,
                                  passController.text,
                                );
                                isLoggingFailed = false;
                                print(results.apiToken);
                                setAuthData(results.apiToken);
                                setState(() {
                                  isLoading = false;
                                  isLoggingFailed = true;
                                });
                              } catch (_) {
                                setState(() {
                                  isLoading = false;
                                  isLoggingFailed = true;
                                });
                              }
                            } else {
                              setState(() {
                                isLoading = false;
                                this.isSubmitted = true;
                                isDisabled = true;
                              });
                            }
                          },
                          isDisabled: isDisabled,
                          gradient: gradient1,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
