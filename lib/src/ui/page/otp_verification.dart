import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/src/provider.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_colors.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_string.dart';
import 'package:zong_islamic_web_app/src/shared_prefs/stored_auth_status.dart';
import 'package:zong_islamic_web_app/src/ui/widget/stretch_button.dart';

class OTPPage extends StatelessWidget {
  const OTPPage({Key? key}) : super(key: key);
  final SizedBox _sizedBox = const SizedBox(height: 15);

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> valueNotifier = ValueNotifier(false);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppString.verification,
                style: Theme.of(context).textTheme.headline3!.copyWith(
                    color: AppColor.pinkTextColor,
                    fontWeight: FontWeight.w300),
              ),
              _sizedBox,
              Text(
                AppString.enterYourVerificationNumber,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: AppColor.darkGreyTextColor,
                    fontWeight: FontWeight.w300,
                    fontSize: 18),
              ),
              _sizedBox,
              PinCodeTextField(
                appContext: context,
                pastedTextStyle: const TextStyle(
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                ),
                length: 4,
                obscureText: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 50,
                  activeFillColor: Colors.white,
                  selectedColor: Colors.amber,
                  selectedFillColor: Colors.white,
                  inactiveFillColor: Colors.white,
                  inactiveColor: Colors.grey,
                ),
                animationDuration: const Duration(milliseconds: 300),
                enableActiveFill: true,
                keyboardType: TextInputType.number,
                onCompleted: (pin) {
                  print(pin);
                  //  pinCode = pin;
                },
                onChanged: (value) {
                  if(value.length.clamp(0, 4)==4){
                    valueNotifier.value = true;
                  }else{
                    valueNotifier.value = false;
                  }
                },
                beforeTextPaste: (text) {
                  print("Allowing to paste $text");
                  return true;
                },
              ),
              _sizedBox,
              ValueListenableBuilder<bool>(
                valueListenable: valueNotifier,
                builder: (context, verify, child)=>
                    StretchButton(
                        onPressed: verify ? () {
                          context.read<StoredAuthStatus>().saveAuthStatus(true);
                          Navigator.pop(context);
                        } : null,
                        text: AppString.verify,
                        vertical: 8),
              ),
              _sizedBox,
              TextButton(
                  onPressed: () {},
                  child: Text(
                    AppString.resend,
                    style:
                    Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: AppColor.greenTextColor,fontSize: 18,fontWeight: FontWeight.w300
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
