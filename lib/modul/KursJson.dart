// ignore_for_file: non_constant_identifier_names

class KursJson {
  final int id;
  final String code;
  final String ccy;
  final String ccyNmRu;
  final String ccyNmUz;
  final String ccyNmUzc;
  final String ccyNmEn;
  final String nominal;
  final String rate;
  final String diff;
  final String date;

  KursJson({
    required this.id,
    required this.code,
    required this.ccy,
    required this.ccyNmRu,
    required this.ccyNmUz,
    required this.ccyNmUzc,
    required this.ccyNmEn,
    required this.nominal,
    required this.rate,
    required this.diff,
    required this.date,
  });

  factory KursJson.formJson(Map<String, dynamic> json) {
    return KursJson(
      id: json['id'],
      code: json["Code"],
      ccy: json["Ccy"],
      ccyNmRu: json["CcyNm_RU"],
      ccyNmUz: json["CcyNm_UZ"],
      ccyNmUzc: json["CcyNm_UZC"],
      ccyNmEn: json["CcyNm_EN"],
      nominal: json["Nominal"],
      rate: json["Rate"],
      diff: json["Diff"],
      date: json["Date"],
    );
  }
}
