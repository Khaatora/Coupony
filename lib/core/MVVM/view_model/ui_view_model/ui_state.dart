part of 'ui_cubit.dart';

class UIState extends Equatable {
  final bool hidePassword;

  const UIState({this.hidePassword = true});

  UIState copyWith({bool? hidePassword}) {
    return UIState(
      hidePassword: hidePassword ?? this.hidePassword,
    );
  }

  @override
  List<Object?> get props => [hidePassword];
}
