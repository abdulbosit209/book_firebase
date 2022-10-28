import 'package:book_with_cubit/data/model/helper/helper_model.dart';
import 'package:book_with_cubit/data/model/publisher/publishers.dart';
import 'package:book_with_cubit/data/services/api_provider.dart';

class PublisherRepository {

  PublisherRepository({required this.apiProvider});

  final ApiProvider apiProvider;

  Future<PublishersModel> getPublishersById({required int id}) => apiProvider.getPublishersById(id: id);

  Future<List<HelperModel>> getPublishers() => apiProvider.getPublishers();

  Future<HelperModel> putPublishersById({required int id, required String name}) => apiProvider.putPublishersById(id: id, name: name);

  Future<bool> deletePublisherById({required int id}) => apiProvider.deletePublisherById(id: id);

  Future<HelperModel> addPublisher({required String name}) => apiProvider.addPublisher(name: name);

}