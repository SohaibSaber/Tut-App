import 'dart:async';

import 'package:tut_app/domain/model/model.dart';
import 'package:tut_app/presentation/base/baseviewmodel.dart';

import '../resources/assets_manager.dart';
import '../resources/strings_manager.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  final StreamController _streamController =
      StreamController<SliderViewObject>();
  late final List<SliderObject> _list ;
  int currentIndex = 0;

  @override
  void dispose() {
    _streamController.close();

  }

  @override
  void start() {
    _list = _getSliderData();
    _postDataToView();
  }

  @override
  int goNext() {
    int nextIndex = currentIndex ++ ;
    if (nextIndex >= _list.length){
      currentIndex = 0;
    }
    return currentIndex;
     }

  @override
  int goPrevious() {
    int previousIndex = currentIndex -- ;
    if (previousIndex == -1){
      currentIndex = _list.length - 1;
    }
    return currentIndex;
  }

  @override
  void onChanged(int index) {
    currentIndex = index;
    _postDataToView();

  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  @override
  Stream<SliderViewObject> get outputSliderViewObject =>
      _streamController.stream.map((sliderViewObject) => sliderViewObject);

  List<SliderObject> _getSliderData() => [
    SliderObject(AppStrings.onBoardingTitle1, AppStrings.onBoardingSubTitle1, ImageAssets.onBoardingLogo1),
    SliderObject(AppStrings.onBoardingTitle2, AppStrings.onBoardingSubTitle2, ImageAssets.onBoardingLogo2),
    SliderObject(AppStrings.onBoardingTitle3, AppStrings.onBoardingSubTitle3, ImageAssets.onBoardingLogo3),
    SliderObject(AppStrings.onBoardingTitle4, AppStrings.onBoardingSubTitle4, ImageAssets.onBoardingLogo4),
  ];
  _postDataToView(){
    inputSliderViewObject.add(SliderViewObject(_list[currentIndex], _list.length, currentIndex));
  }
}

abstract class OnBoardingViewModelInputs {
  void goNext();

  void goPrevious();

  void onChanged(int index);

  Sink get inputSliderViewObject;
}

abstract class OnBoardingViewModelOutputs {
  Stream<SliderViewObject> get outputSliderViewObject;
}

class SliderViewObject {
  SliderObject sliderObject;
  int numOfSlide;
  int currentIndex;

  SliderViewObject(this.sliderObject, this.numOfSlide, this.currentIndex);
}
