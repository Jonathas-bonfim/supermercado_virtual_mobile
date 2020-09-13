import 'package:flutter/cupertino.dart';

//alterar as páginas e saber em qual páginas estamos.
class PageManager {
  PageManager(this._pageController);

  final PageController _pageController;

  int page = 0;
  //quando eu quiser trocar de página vai chamar essa função
  void setPage(int value) {
    if (value == page) return;
    page = value;
    
    _pageController.jumpToPage(value);
  }
}
