
import 'package:flutter/material.dart';
import 'package:gauravbiometric/custom_widgets.dart';
import 'package:local_auth/local_auth.dart';
import 'package:lottie/lottie.dart';

import 'controller/local_auth_api.dart';

class FingerprintPage extends StatefulWidget {
  const FingerprintPage({Key? key}) : super(key: key);
  @override
  State<FingerprintPage> createState() => _FingerprintPageState();
}

class _FingerprintPageState extends State<FingerprintPage> {
  late bool isAvailable;
  late bool hasFingerprint;
  checkAvablity() async {
    isAvailable = await LocalAuthApi.hasBiometrics();
    final biometrics = await LocalAuthApi.getBiometrics();

    hasFingerprint = biometrics.contains(BiometricType.fingerprint);

    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        buildText('Biometrics', isAvailable),
        buildText('Fingerprint', hasFingerprint),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Color(0xFF009C10),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xFF009C10),
          title: const Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "MedOnGo Verification",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28.0,
                  ),
                ),
                SizedBox(width: 10,),
                Column(
                  children: [
                    Icon(Icons.add_box), // You can replace this with the health plus icon you want
                  ],
                ),
              ],
            ),
          ),
          centerTitle: true,
        ),


    body: Container(
          margin: const EdgeInsets.only(
            top: 33,
          ),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  spreadRadius: 8,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(35), topLeft: Radius.circular(35)),
              border: Border.all(color: Colors.transparent)),
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Login with your",
                  style: TextStyle(
                      fontSize: 29,
                      fontWeight: FontWeight.w700,
                      color: Colors.black.withOpacity(0.8)),
                ),
                Text(
                  "fingerprint",
                  style: TextStyle(
                      fontSize: 29,
                      fontWeight: FontWeight.w700,
                      color: Colors.black.withOpacity(0.8)),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Text(
                  "let us know it's you by one click authentication",
                  style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey.withOpacity(0.8)),
                ),
                LottieBuilder.asset(
                  "assets/fin.json",
                  repeat: true,
                ),
                FutureBuilder(
                    future: checkAvablity(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator(
                          color: Colors.green,
                          strokeWidth: 2,
                        );
                      } else {
                        return Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: 10,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/medongo.jpg',
                                  height: 200,
                                  width: 70,),
                                ],
                              ),
                              // buildText('Biometrics Hardware  ', isAvailable),
                              buildText(
                                  'Fingerprint Availability ', hasFingerprint),
                              authenticateButton(context)
                            ],

                          ),


                        );


                      }
                    })
              ],

            ),


          ),
        ),


      );
}
