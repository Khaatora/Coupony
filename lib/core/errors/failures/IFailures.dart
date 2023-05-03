import 'package:equatable/equatable.dart';

/// interface for failures types
abstract class IFailure extends Equatable{
  final String message;

  const IFailure(this.message);

  //used internally by Equatable to check equality between class objects
  @override
  List<Object?> get props => [];

}