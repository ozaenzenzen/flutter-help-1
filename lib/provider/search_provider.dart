import 'package:flutter/cupertino.dart';

class SearchProvider extends ChangeNotifier {
  String _search = '';
  String get search => _search;
  set search(String search) {
    _search = search;
    notifyListeners();
  }
}
