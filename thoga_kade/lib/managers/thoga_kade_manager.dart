import 'package:thoga_kade/model/vegetable.dart';

abstract class ThogaKadeState {}

class LoadingState extends ThogaKadeState {}

class LoadedState extends ThogaKadeState {
  final List<Vegetable> inventory;
  LoadedState(this.inventory);
}

class ErrorState extends ThogaKadeState {
  final String message;
  ErrorState(this.message);
}

class ThogaKadeManager {
  ThogaKadeState _state = LoadingState();

  ThogaKadeState get state => _state;

  void loadInventory(List<Vegetable> inventory) {
    _state = LoadedState(inventory);
  }

  void showError(String message) {
    _state = ErrorState(message);
  }
}
