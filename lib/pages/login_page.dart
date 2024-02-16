import 'package:flutter/material.dart';
import 'package:chatterly/providers/auth_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../widgets/widgets.dart';
import 'pages.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  double opacityLevel = 1.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(microseconds: 1), () {
      setState(() {
        opacityLevel = 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    switch (authProvider.status) {
      case Status.authenticateError:
        Fluttertoast.showToast(msg: "Sign in fail");
        break;
      case Status.authenticateCanceled:
        Fluttertoast.showToast(msg: "Sign in canceled");
        break;
      case Status.authenticated:
        Fluttertoast.showToast(msg: "Sign in success");
        break;
      default:
        break;
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnimatedOpacity(
        duration: Duration(seconds: 2),
        opacity: opacityLevel = opacityLevel == 0 ? 1.0 : 0.0,
        child: Stack(
          children: [
            Positioned(
                height: mq.height * 0.4,
                top: mq.height * 0.16,
                width: mq.width * 0.86,
                left: mq.width * 0.06,
                child: Image.asset("images/ic_launcher.png")),
            Positioned(
              top: mq.height * 0.58,
              width: mq.width * 0.80,
              left: mq.width * 0.06,
              child: Text("Connect with those ",
                  style: GoogleFonts.urbanist(
                      wordSpacing: 1,
                      fontSize: 21,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center),
            ),
            Positioned(
              top: mq.height * 0.61,
              width: mq.width * 0.80,
              right: mq.width * 0.07,
              child: Text(" who matters the most.",
                  style: GoogleFonts.urbanist(
                      wordSpacing: 1,
                      fontSize: 21,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center),
            ),
            Positioned(
              top: mq.height * 0.68,
              width: mq.width * 0.80,
              left: mq.width * 0.10,
              child: Text("Welcome to Chatterly, ",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center),
            ),
            Positioned(
              bottom: mq.height * 0.16,
              width: mq.width * 0.80,
              left: mq.width * 0.10,
              height: mq.height * 0.075,
              child: ElevatedButton(
                onPressed: () async {
                  LoadingView();
                  await authProvider.handleSignIn().then((isSuccess) {
                    if (isSuccess) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    }
                  }).catchError((error, stackTrace) {
                    Fluttertoast.showToast(msg: error.toString());
                    authProvider.handleException();
                  });
                },
                child: Text(
                  "Get Started ",
                  style: TextStyle(fontSize: 18,color: Colors.white),
                ),
                style: ButtonStyle(
                    elevation: MaterialStatePropertyAll(3),
                    backgroundColor: MaterialStatePropertyAll(Colors.black),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)))),
              ),
            ),
            Positioned(
              bottom: mq.height * 0.01,
              width: mq.width * 0.80,
              left: mq.width * 0.10,
              child: Text(
                "Read our Privacy Policy and Terms of Service",
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
    // return Scaffold(
    //     // appBar: AppBar(backgroundColor: Colors.black,
    //     //   title: Text(
    //     //     AppConstants.loginTitle,
    //     //     style: TextStyle(color: Colors.white),
    //     //   ),
    //     //   centerTitle: true,
    //     // ),
    //     body: Stack(
    //       children: <Widget>[
    //         Center(
    //           child: TextButton(
    //             onPressed: () async {
    //               authProvider.handleSignIn().then((isSuccess) {
    //                 if (isSuccess) {
    //                   Navigator.pushReplacement(
    //                     context,
    //                     MaterialPageRoute(
    //                       builder: (context) => HomePage(),
    //                     ),
    //                   );
    //                 }
    //               }).catchError((error, stackTrace) {
    //                 Fluttertoast.showToast(msg: error.toString());
    //                 authProvider.handleException();
    //               });
    //             },
    //             child: Text(
    //               'Sign in with Google',
    //               style: TextStyle(fontSize: 16, color: Colors.white),
    //             ),
    //             style: ButtonStyle(
    //               backgroundColor: MaterialStateProperty.resolveWith<Color>(
    //                 (Set<MaterialState> states) {
    //                   if (states.contains(MaterialState.pressed)) return Color(
    //                       0xff000000).withOpacity(0.8);
    //                   return Color(0xff000000);
    //                 },
    //               ),
    //               splashFactory: NoSplash.splashFactory,
    //               padding: MaterialStateProperty.all<EdgeInsets>(
    //                 EdgeInsets.fromLTRB(30, 15, 30, 15),
    //               ),
    //             ),
    //           ),
    //         ),
    //         // Loading
    //         Positioned(
    //           child: authProvider.status == Status.authenticating ? LoadingView() : SizedBox.shrink(),
    //         ),
    //       ],
    //     ));
  }
}
