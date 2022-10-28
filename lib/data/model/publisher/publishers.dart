import 'package:book_with_cubit/data/model/book/book_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'publishers.g.dart';

@JsonSerializable()
class PublishersModel { //
  @JsonKey(defaultValue: "", name: "name")
  String name;

  @JsonKey(defaultValue: 0, name: "id")
  int id;

  @JsonKey(defaultValue: [], name: "books")
  List<BookModel> books;

  PublishersModel({
    required this.id,
    required this.name,
    required this.books
  });

  factory PublishersModel.fromJson(Map<String, dynamic> json) =>
      _$PublishersModelFromJson(json);

  Map<String, dynamic> toJson() => _$PublishersModelToJson(this);
}