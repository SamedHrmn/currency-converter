// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rates_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RatesModel _$RatesModelFromJson(Map<String, dynamic> json) => RatesModel(
      motd: json['motd'] == null
          ? null
          : Motd.fromJson(json['motd'] as Map<String, dynamic>),
      success: json['success'] as bool?,
      historical: json['historical'] as bool?,
      base: json['base'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      rates: (json['rates'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
    );

Map<String, dynamic> _$RatesModelToJson(RatesModel instance) =>
    <String, dynamic>{
      'motd': instance.motd,
      'success': instance.success,
      'historical': instance.historical,
      'base': instance.base,
      'date': instance.date?.toIso8601String(),
      'rates': instance.rates,
    };

Motd _$MotdFromJson(Map<String, dynamic> json) => Motd(
      msg: json['msg'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$MotdToJson(Motd instance) => <String, dynamic>{
      'msg': instance.msg,
      'url': instance.url,
    };
