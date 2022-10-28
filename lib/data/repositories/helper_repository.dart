import 'package:book_with_cubit/data/model/helper/helper_model.dart';
import 'package:book_with_cubit/data/services/api_provider.dart';

class HelperRepository {
  HelperRepository({required this.apiProvider});

  final ApiProvider apiProvider;

  Future<List<HelperModel>> getLanguages() => apiProvider.getLanguages();

  Future<List<HelperModel>> getGenres() => apiProvider.getGenres();
}