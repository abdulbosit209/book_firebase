part of 'publishers_cubit.dart';

 class PublishersState extends Equatable {
  const PublishersState({
    required this.formzStatus,
    required this.errorText,
    required this.publishers
 });

  final List<HelperModel> publishers;
  final FormzStatus formzStatus;
  final String errorText;

  PublishersState copyWith({
   List<HelperModel>? publishers,
    FormzStatus? formzStatus,
    String? errorText
 }) => PublishersState(
    publishers: publishers ?? this.publishers,
    formzStatus: formzStatus ?? this.formzStatus,
    errorText: errorText ?? this.errorText
  );


  @override
  List<Object?> get props => [
    publishers,
    formzStatus,
    errorText
  ];
}
