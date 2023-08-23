import 'package:json_annotation/json_annotation.dart';

part 'rates_model.g.dart';

@JsonSerializable()
class RatesModel {
  @JsonKey(name: 'motd')
  final Motd? motd;
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'historical')
  final bool? historical;
  @JsonKey(name: 'base')
  final String? base;
  @JsonKey(name: 'date')
  final DateTime? date;
  @JsonKey(name: 'rates')
  final Map<String, double>? rates;

  RatesModel({
    this.motd,
    this.success,
    this.historical,
    this.base,
    this.date,
    this.rates,
  });

  factory RatesModel.fromJson(Map<String, dynamic> json) => _$RatesModelFromJson(json);

  Map<String, dynamic> toJson() => _$RatesModelToJson(this);
}

@JsonSerializable()
class Motd {
  @JsonKey(name: 'msg')
  final String? msg;
  @JsonKey(name: 'url')
  final String? url;

  Motd({
    this.msg,
    this.url,
  });

  factory Motd.fromJson(Map<String, dynamic> json) => _$MotdFromJson(json);

  Map<String, dynamic> toJson() => _$MotdToJson(this);
}
