import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // ضروري لتصفية الأرقام فقط
import 'dart:math';
import 'dart:async';
import 'package:ayatelecom/Homepage.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  String? generatedOtp;
  bool isOtpSent = false;
  bool isResendEnabled = false;
  int countdown = 0;
  Timer? timer;

  void sendMockOtp() {
    final random = Random();
    generatedOtp = (100000 + random.nextInt(900000)).toString();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('رمز التحقق الخاص بك هو: $generatedOtp'),
        duration: Duration(seconds: 4),
      ),
    );

    setState(() {
      isOtpSent = true;
      isResendEnabled = false;
      countdown = 30;
    });

    startCountdown();
  }

  void startCountdown() {
    timer?.cancel();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (countdown > 0) {
          countdown--;
        } else {
          isResendEnabled = true;
          timer.cancel();
        }
      });
    });
  }

  void verifyOtp() {
    if (otpController.text == generatedOtp) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('تم التحقق بنجاح 🎉'),
          backgroundColor: Colors.green,
        ),
      );

      Future.delayed(Duration(seconds: 1), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => Directionality(
                    textDirection: TextDirection.rtl,
                    child: HomePage(),
                  )),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('رمز غير صحيح، حاول مرة أخرى'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    phoneController.dispose();
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final showTimer = isOtpSent && !isResendEnabled;

    return Scaffold(
      appBar: AppBar(title: Text("تسجيل الدخول برقم الهاتف")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset('assets/logo.png', height: 120),
            SizedBox(height: 16),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: "رقم الهاتف",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            SizedBox(height: 16),
            if (isOtpSent) ...[
              TextField(
                controller: otpController,
                decoration: InputDecoration(
                  labelText: "أدخل رمز التحقق",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: verifyOtp,
                child: Text("تحقق"),
              ),
              SizedBox(height: 16),
              if (showTimer)
                Text("يمكنك إعادة إرسال الرمز خلال $countdown ثانية"),
              if (!showTimer)
                TextButton(
                  onPressed: isResendEnabled ? sendMockOtp : null,
                  child: Text("إعادة إرسال الرمز"),
                ),
            ] else ...[
              ElevatedButton(
                onPressed: sendMockOtp,
                child: Text("إرسال رمز التحقق"),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
