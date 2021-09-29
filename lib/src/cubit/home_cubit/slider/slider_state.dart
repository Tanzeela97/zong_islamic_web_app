part of 'slider_cubit.dart';

@immutable
abstract class SliderState {}

class SliderInitial extends SliderState {}

class SliderLoadingState extends SliderState {
  final bool? isVisible;

  SliderLoadingState({this.isVisible});
}

// ignore: must_be_immutable
class SliderSuccessState extends SliderState {
  bool? isSuccess;
  List<Slider>? slider;

  SliderSuccessState({this.isSuccess, this.slider});
}

class SliderErrorState extends SliderState {
  final String? message;

  SliderErrorState({this.message});
}
