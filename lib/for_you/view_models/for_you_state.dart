part of 'for_you_cubit.dart';

class ForYouState extends Equatable {
  final LoadingState loadingState;
  final List<Campaign> campaigns;
  final String message;

  const ForYouState({
    this.loadingState = LoadingState.init,
    required this.campaigns,
    this.message = "",
  });

  ForYouState copyWith({
    LoadingState? loadingState,
    List<Campaign>? campaigns,
    String? message,
  }) {
    return ForYouState(
      loadingState: loadingState ?? this.loadingState,
      campaigns: campaigns ?? this.campaigns,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        loadingState,
        campaigns,
        message,
      ];
}
