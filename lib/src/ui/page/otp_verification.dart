import 'package:flash/flash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/src/provider.dart';
import 'package:zong_islamic_web_app/src/cubit/auth_cubit/otp/otp_cubit.dart';
import 'package:zong_islamic_web_app/src/resource/network/remote_data_source.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_colors.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_string.dart';
import 'package:zong_islamic_web_app/src/shared_prefs/stored_auth_status.dart';
import 'package:zong_islamic_web_app/src/ui/widget/stretch_button.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_loading.dart';

class OTPPage extends StatefulWidget {
  final String number;

  const OTPPage(this.number, {Key? key}) : super(key: key);

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> with SingleTickerProviderStateMixin {
  final SizedBox _sizedBox = const SizedBox(height: 15);
  final ValueNotifier<bool> valueNotifier = ValueNotifier(false);
  String pinCode = '';

  late AnimationController _controller;

  static const int kStartValue = 5;
  bool resent = false;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(seconds: 60 * kStartValue));
    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          resent = true;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    valueNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    color: AppColor.pinkTextColor, fontWeight: FontWeight.w300),
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
                  pinCode = pin;
                },
                onChanged: (value) {
                  if (value.length.clamp(0, 4) == 4) {
                    valueNotifier.value = true;
                  } else {
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
                builder: (context, verify, child) => StretchButton(
                    onPressed: verify
                        ? () {
                            BlocProvider.of<OtpCubit>(context, listen: false)
                                .verifyOtp(widget.number, pinCode);
                          }
                        : null,
                    text: AppString.verify,
                    vertical: 8),
              ),
              _sizedBox,

              // Row(
              //   children: [
              //     Text(
              //       'did not received OTP?',
              //       style: Theme.of(context).textTheme.bodyText1!.copyWith(
              //           color: AppColor.greenTextColor,
              //           fontSize: 18,
              //           fontWeight: FontWeight.w300),
              //     ),
              //     Spacer(),
              //     TextButton(
              //         onPressed: resent
              //             ? () {
              //                 _controller.reset();
              //                 _controller.forward();
              //                 setState(() {
              //                   resent = false;
              //                 });
              //               }
              //             : null,
              //         child: Countdown(
              //           animation: StepTween(begin: kStartValue * 60, end: 0)
              //               .animate(_controller),
              //         )),
              //   ],
              // ),
              Center(
                child: TextButton(
                    onPressed: resent
                        ? () async {
                            await ZongIslamicRemoteDataSourceImpl()
                                .login(widget.number);
                            _controller.reset();
                            _controller.forward();
                            setState(() {
                              resent = false;
                            });
                          }
                        : null,
                    child: Countdown(
                      animation: StepTween(begin: kStartValue * 60, end: 0)
                          .animate(_controller),
                    )),
              ),
              _sizedBox,
              BlocConsumer<OtpCubit, OtpState>(listener: (context, state) {
                if (state is OtpSuccessState) {
                  if (state.authStatusModel!.status == "success") {
                    context
                        .read<StoredAuthStatus>()
                        .saveAuthStatus(true, widget.number);
                    Navigator.of(context).pop();
                  } else {
                    showDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (context) => AlertDialog(
                              content:
                                  Text(state.authStatusModel!.desc!.toString()),
                              actions: [
                                GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pop(true);
                                    },
                                    child: Center(
                                        child: Text(
                                      'Exit',
                                      style: TextStyle(fontSize: 20),
                                    )))
                              ],
                            ));
                  }
                }
              }, builder: (context, state) {
                print(state);
                if (state is OtpInitial) {
                  return const SizedBox.shrink();
                } else if (state is OtpSuccessState) {
                  return const SizedBox.shrink();
                } else if (state is OtpLoadingState) {
                  return const WidgetLoading();
                } else if (state is OtpErrorState) {
                  return const Text('someThing went wrong');
                } else {
                  return const Text('someThing went wrong');
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}

// class CountDownTimer extends StatelessWidget {
//   final int minute;
//
//   const CountDownTimer({Key? key, required this.minute}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return TweenAnimationBuilder(
//         tween: StepTween(begin: minute * 60, end: 0),
//         duration: Duration(seconds: 60),
//         onEnd: () {
//           print('on end');
//         },
//         builder: (context, value, child) {
//           print(value.toString());
//           return Text(
//               "${Duration(seconds: value as int).inMinutes}:${Duration(seconds: value).inSeconds.remainder(60)}");
//         });
//   }
// }

class Countdown extends AnimatedWidget {
  const Countdown({Key? key, required this.animation})
      : super(key: key, listenable: animation);
  final Animation<int> animation;

  @override
  build(BuildContext context) {
    return Text(
        "Resent OTP in ${Duration(seconds: animation.value).inMinutes}:${Duration(seconds: animation.value).inSeconds.remainder(60)}");
  }
}
