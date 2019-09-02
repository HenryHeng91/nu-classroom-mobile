import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

//command generate json serializable flutter packages pub run build_runner build --delete-conflicting-outputs
class BaseResponse{
  bool success;
  String message;
  int status;

  BaseResponse(this.success, this.message, this.status);
}

@JsonSerializable()
class Service {
  int id;
  String name;

  Service(this.id, this.name);

  factory Service.fromJson(Map<String, dynamic> json) => _$ServiceFromJson(json);
}

@JsonSerializable()
class ServiceResponse extends BaseResponse{
  List<Service> result;

  ServiceResponse(this.result,bool success,String message,int status):super(success,message,status);

  factory ServiceResponse.fromJson(Map<String, dynamic> json) => _$ServiceResponseFromJson(json);
}