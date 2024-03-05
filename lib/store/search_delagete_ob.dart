import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'search_delagete_ob.g.dart';

class SearchDelegateOb = _SearchDelagateOb with _$SearchDelegateOb;

abstract class _SearchDelagateOb with Store {
  @observable
  double sliderInitialIndex = 80000;

  @observable
  List list_of_image = [
    'assets/car1.png',
    'assets/car2.png',
    'assets/car3.png',
    'assets/car4.png',
    'assets/car5.png',
    'assets/car6.png',
    'assets/car7.png',
    'assets/car8.png',
    'assets/car9.png',
    'assets/car10.png',
    'assets/car11.png',
    'assets/car12.png',
  ].asObservable();

  @action
  void shuffle() {
    list_of_image.shuffle();
  }

  @observable
  List bgColor = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ].asObservable();

  @observable
  List textColor = [
    Colors.black,
    Colors.black,
    Colors.black,
    Colors.black,
    Colors.black,
    Colors.black,
    Colors.black,
    Colors.black,
    Colors.black,
  ].asObservable();

  @action
  void changeColor(Color bgColor, Color textColor, int index) {
    for (int i = 0; i < this.bgColor.length; i++) {
      this.bgColor[i] = Colors.white;
      this.textColor[i] = Colors.black;
    }
    this.bgColor[index] = Colors.black;
    this.textColor[index] = Colors.white;
  }

  @action
  void changeSlider(double index) {
    sliderInitialIndex = index;
  }
}
