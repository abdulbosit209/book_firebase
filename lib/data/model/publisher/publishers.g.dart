// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'publishers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublishersModel _$PublishersModelFromJson(Map<String, dynamic> json) =>
    PublishersModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      books: (json['books'] as List<dynamic>?)
              ?.map((e) => BookModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$PublishersModelToJson(PublishersModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'books': instance.books,
    };
