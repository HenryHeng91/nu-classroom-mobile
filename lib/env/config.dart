import 'package:json_annotation/json_annotation.dart';
part 'config.g.dart';

@JsonSerializable(createToJson: false)
class Config {
  final String oneSignalId;
  final String admobId;
  final String androidUnitId;
  final String iosUnitId;

  Config(this.oneSignalId, this.admobId, this.androidUnitId, this.iosUnitId);
  factory Config.fromJson(Map<String, dynamic> json) => _$ConfigFromJson(json);
}