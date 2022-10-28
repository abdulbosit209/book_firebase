part of 'helper_cubit.dart';

@immutable
abstract class HelperState {}

class HelperInitial extends HelperState {}

//--------------------Languages-------------------
class GetLanguagesInProgress extends HelperState {}

class GetLanguagesInSuccess extends HelperState {
  GetLanguagesInSuccess({required this.languages});

  final List<HelperModel> languages;
}

class GetLanguagesInFailure extends HelperState {
  GetLanguagesInFailure({required this.errorText});

  final String errorText;
}

//--------------------Genres-------------------
class GetGenresInProgress extends HelperState {}

class GetGenresInSuccess extends HelperState {
  GetGenresInSuccess({required this.genres});

  final List<HelperModel> genres;

}

class GetGenresInFailure extends HelperState {
  GetGenresInFailure({required this.errorText});

  final String errorText;
}