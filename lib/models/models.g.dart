// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Service _$ServiceFromJson(Map<String, dynamic> json) {
  return Service(json['id'] as int, json['name'] as String);
}

Map<String, dynamic> _$ServiceToJson(Service instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};

ServiceResponse _$ServiceResponseFromJson(Map<String, dynamic> json) {
  return ServiceResponse(
      (json['result'] as List)
          ?.map((e) =>
              e == null ? null : Service.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['success'] as bool,
      json['message'] as String,
      json['status'] as int);
}

Map<String, dynamic> _$ServiceResponseToJson(ServiceResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'status': instance.status,
      'result': instance.result
    };