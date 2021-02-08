import 'dart:convert';

Converter converterFromJson(String str) => Converter.fromJson(json.decode(str));

String converterToJson(Converter data) => json.encode(data.toJson());

class Converter {
  Converter({
    this.motd,
    this.success,
    this.query,
    this.info,
    this.historical,
    this.date,
    this.result,
  });

  Motd motd;
  bool success;
  Query query;
  Info info;
  bool historical;
  DateTime date;
  dynamic result;

  factory Converter.fromJson(Map<String, dynamic> json) => Converter(
        motd: Motd.fromJson(json['motd']),
        success: json['success'],
        query: Query.fromJson(json['query']),
        info: Info.fromJson(json['info']),
        historical: json['historical'],
        date: DateTime.parse(json['date']),
        result: json['result'],
      );

  Map<String, dynamic> toJson() => {
        'motd': motd.toJson(),
        'success': success,
        'query': query.toJson(),
        'info': info.toJson(),
        'historical': historical,
        'date': "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        'result': result,
      };
}

class Info {
  Info({
    this.rate,
  });

  dynamic rate;

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        rate: json['rate'],
      );

  Map<String, dynamic> toJson() => {
        'rate': rate,
      };
}

class Motd {
  Motd({
    this.msg,
    this.url,
  });

  String msg;
  String url;

  factory Motd.fromJson(Map<String, dynamic> json) => Motd(
        msg: json['msg'],
        url: json['url'],
      );

  Map<String, dynamic> toJson() => {
        'msg': msg,
        'url': url,
      };
}

class Query {
  Query({
    this.from,
    this.to,
    this.amount,
  });

  String from;
  String to;
  int amount;

  factory Query.fromJson(Map<String, dynamic> json) => Query(
        from: json['from'],
        to: json['to'],
        amount: json['amount'],
      );

  Map<String, dynamic> toJson() => {
        'from': from,
        'to': to,
        'amount': amount,
      };
}
