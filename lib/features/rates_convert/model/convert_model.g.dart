// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'convert_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConvertModel _$ConvertModelFromJson(Map<String, dynamic> json) => ConvertModel(
      motd: json['motd'] == null
          ? null
          : Motd.fromJson(json['motd'] as Map<String, dynamic>),
      success: json['success'] as bool?,
      query: json['query'] == null
          ? null
          : Query.fromJson(json['query'] as Map<String, dynamic>),
      info: json['info'] == null
          ? null
          : Info.fromJson(json['info'] as Map<String, dynamic>),
      historical: json['historical'] as bool?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      result: json['result'],
    );

Map<String, dynamic> _$ConvertModelToJson(ConvertModel instance) =>
    <String, dynamic>{
      'motd': instance.motd,
      'success': instance.success,
      'query': instance.query,
      'info': instance.info,
      'historical': instance.historical,
      'date': instance.date?.toIso8601String(),
      'result': instance.result,
    };

Info _$InfoFromJson(Map<String, dynamic> json) => Info(
      rate: json['rate'],
    );

Map<String, dynamic> _$InfoToJson(Info instance) => <String, dynamic>{
      'rate': instance.rate,
    };

Motd _$MotdFromJson(Map<String, dynamic> json) => Motd(
      msg: json['msg'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$MotdToJson(Motd instance) => <String, dynamic>{
      'msg': instance.msg,
      'url': instance.url,
    };

Query _$QueryFromJson(Map<String, dynamic> json) => Query(
      from: json['from'] as String?,
      to: json['to'] as String?,
      amount: json['amount'] as int?,
    );

Map<String, dynamic> _$QueryToJson(Query instance) => <String, dynamic>{
      'from': instance.from,
      'to': instance.to,
      'amount': instance.amount,
    };
