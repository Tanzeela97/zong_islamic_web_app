import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:zong_islamic_web_app/src/model/slider.dart';

import 'package:zong_islamic_web_app/src/resource/repository/home_repository.dart';

part 'slider_state.dart';

class SliderCubit extends Cubit<SliderState> {
  final HomeRepository homeRepository;

  SliderCubit(this.homeRepository) : super(SliderInitial());

  void getSlider() async {
    emit(SliderLoadingState());
    final Either<SliderErrorState, List<CustomSlider>> eitherResponse =
        (await homeRepository.getSliderImage());
    emit(eitherResponse.fold(
      (l) => SliderErrorState(message: 'Something Went Wrong'),
      (r) => SliderSuccessState(slider: r),
    ));
  }
}
