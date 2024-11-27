import 'package:rxdart/rxdart.dart';

class BoolBloc {
  final BehaviorSubject<bool> _bloc = BehaviorSubject<bool>();
  Stream<bool> get streams => _bloc.stream;
  bool get value => _bloc.value;

  setValue(bool val) => _bloc.add(val);
}

class IntBloc {
  final BehaviorSubject<int> _bloc = BehaviorSubject<int>();
  Stream<int> get streams => _bloc.stream;
  int get value => _bloc.value;

  setValue(int val) => _bloc.add(val);
}

