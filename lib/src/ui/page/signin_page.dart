import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zong_islamic_web_app/src/cubit/auth_cubit/login/login_cubit.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_colors.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_string.dart';
import 'package:zong_islamic_web_app/src/ui/page/otp_verification.dart';
import 'package:zong_islamic_web_app/src/ui/widget/stretch_button.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);
  static final TextEditingController _controller =
      TextEditingController(text: "+92")
        ..addListener(() {
          if (!_controller.text.startsWith("+92")) {
            _controller.value = _controller.value.copyWith(text: "+92");
            _controller.selection =
                TextSelection.fromPosition(const TextPosition(offset: 3));
          }
        });

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> valueNotifier = ValueNotifier(false);
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppString.signIn,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: AppColor.pinkTextColor,
                  fontSize: 32,
                  fontWeight: FontWeight.w300),
            ),
            const SizedBox(height: 10),
            Text(
              AppString.mobileNumber,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  //color: AppColor.pinkTextColor,
                  fontSize: 18,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w300),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[800]),
                  fillColor: Colors.white70),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Checkbox(value: valueNotifier.value, onChanged: (value) {
                  valueNotifier.value = value!;
                }),
                const SizedBox(width: 10),
                RichText(
                    text: TextSpan(
                  text: "${AppString.agree} ",
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: Colors.black,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w300),
                  children: [
                    TextSpan(
                      text: AppString.term,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Colors.red,
                            letterSpacing: 2,
                            decoration: TextDecoration.underline,
                          ),
                    ),
                  ],
                )),
              ],
            ),
            const SizedBox(height: 15),
            ValueListenableBuilder<bool>(
              valueListenable: valueNotifier,
              builder: (context,term,child){
                return StretchButton(
                  onPressed: term ? () {BlocProvider.of<LoginCubit>(context).getLogin();} : null,
                  text: AppString.next,
                );
              },
            ),
            const SizedBox(height: 15),
            BlocConsumer<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state is LoginSuccessState) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const OTPPage()));
                }
              },
              builder: (context, state) {
                if (state is LoginInitial) {
                  return const SizedBox.shrink();
                } else if (state is LoginLoadingState) {
                  return const Text('loading');
                } else if (state is LoginSuccessState) {
                  return const SizedBox.shrink();
                } else if (state is LoginErrorState) {
                  return Text(state.message!);
                } else {
                  return const Text('someThing Went Wrong');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
