import 'package:flutter/widgets.dart';

class HomeViewModel extends ChangeNotifier {
  List groups = [];
  int currentPage = 1;
  final int perPage = 10;

  HomeViewModel();

  Future<void> fetchData() async {
    notifyListeners();
  }
}
