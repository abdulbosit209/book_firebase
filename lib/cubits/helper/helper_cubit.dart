import 'package:bloc/bloc.dart';
import 'package:book_with_cubit/data/model/helper/helper_model.dart';
import 'package:book_with_cubit/data/repositories/helper_repository.dart';
import 'package:meta/meta.dart';

part 'helper_state.dart';

class HelperCubit extends Cubit<HelperState> {
  HelperCubit({required this.helperRepository}) : super(HelperInitial());

  final HelperRepository helperRepository;
  List<HelperModel> languageList = [];
  List<HelperModel> genresList = [];

  void getLanguages() async {
    emit(GetLanguagesInProgress());
    try {
      languageList = await helperRepository.getLanguages();
      emit(GetLanguagesInSuccess(languages: languageList));
    } catch (error) {
      emit(GetLanguagesInFailure(errorText: error.toString()));
    }
  }

  void getGenres() async {
    emit(GetGenresInProgress());
    try {
      genresList = await helperRepository.getGenres();
      emit(GetGenresInSuccess(genres: genresList));
    } catch (error) {
      emit(GetGenresInFailure(errorText: error.toString()));
    }
  }

}
