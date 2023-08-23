import 'package:json_annotation/json_annotation.dart';

part 'convert_model.g.dart';

@JsonSerializable()
class ConvertModel {
  @JsonKey(name: 'motd')
  final Motd? motd;
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'query')
  final Query? query;
  @JsonKey(name: 'info')
  final Info? info;
  @JsonKey(name: 'historical')
  final bool? historical;
  @JsonKey(name: 'date')
  final DateTime? date;
  @JsonKey(name: 'result')
  final dynamic result;

  ConvertModel({
    this.motd,
    this.success,
    this.query,
    this.info,
    this.historical,
    this.date,
    this.result,
  });

  factory ConvertModel.fromJson(Map<String, dynamic> json) => _$ConvertModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConvertModelToJson(this);
}

@JsonSerializable()
class Info {
  @JsonKey(name: 'rate')
  final dynamic rate;

  Info({
    this.rate,
  });

  factory Info.fromJson(Map<String, dynamic> json) => _$InfoFromJson(json);

  Map<String, dynamic> toJson() => _$InfoToJson(this);
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

@JsonSerializable()
class Query {
  @JsonKey(name: 'from')
  final String? from;
  @JsonKey(name: 'to')
  final String? to;
  @JsonKey(name: 'amount')
  final int? amount;

  Query({
    this.from,
    this.to,
    this.amount,
  });

  factory Query.fromJson(Map<String, dynamic> json) => _$QueryFromJson(json);

  Map<String, dynamic> toJson() => _$QueryToJson(this);
}
