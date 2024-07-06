import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication_otp/package/home_screen.dart';
import 'package:flutter/material.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;

  final phoneController = TextEditingController(text: "+91");
  final otpController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? verificationId;

  bool showLoading = false;

  void signInWithPhoneAuthCredetial(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });

    try {
      final authCredetial =
          await _auth.signInWithCredential(phoneAuthCredential);

      setState(() {
        showLoading = false;
      });

      if (authCredetial.user != null) {
        print(authCredetial.user!.uid);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });
      _scaffoldkey.currentState?.showSnackBar(
        SnackBar(
          content: Text(e.message ?? ""),
        ),
      );
    }
  }

  getMoibleFormState(context) {
    return Column(
      children: [
        const Spacer(),
        TextField(
          decoration: const InputDecoration(
            hintText: 'Phone Number',
          ),
          controller: phoneController,
          keyboardType: const TextInputType.numberWithOptions(),
        ),
        const SizedBox(
          height: 16,
        ),
        ElevatedButton(
          child: const Text('Send'),
          onPressed: () async {
            setState(() {
              showLoading = true;
            });
            await _auth.verifyPhoneNumber(
              phoneNumber: phoneController.text,
              verificationCompleted: (PhoneAuthCredential) {
                setState(() {
                  showLoading = false;
                });
              },
              verificationFailed: (VerificationFailed) {
                setState(() {
                  showLoading = false;
                });
                _scaffoldkey.currentState?.showSnackBar(
                  SnackBar(
                    content: Text(VerificationFailed.message ?? ""),
                  ),
                );
              },
              codeSent: (verificatioId, resendingToken) {
                setState(() {
                  showLoading = false;

                  currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
                  verificationId = verificatioId;
                });
              },
              codeAutoRetrievalTimeout: (verificationId) {},
            );
            print(phoneController);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue),
          ),
        ),
        const Spacer(),
      ],
    );
  }

  getOtpFormState(context) {
    return Column(
      children: [
        const Spacer(),
        TextField(
          decoration: const InputDecoration(
            hintText: 'Enter Otp',
          ),
          controller: otpController,
          keyboardType: const TextInputType.numberWithOptions(),
        ),
        const SizedBox(
          height: 16,
        ),
        ElevatedButton(
          child: const Text('verify'),
          onPressed: () async {
            PhoneAuthCredential phoneAuthCredential =
                PhoneAuthProvider.credential(
                    verificationId: verificationId!,
                    smsCode: otpController.text);

            signInWithPhoneAuthCredetial(phoneAuthCredential);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue),
          ),
        ),
        const Spacer(),
      ],
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      body: Container(
        child: showLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
                ? getMoibleFormState(context)
                : getOtpFormState(context),
      ),
    );
  }
}
