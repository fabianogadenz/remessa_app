class Currency {
  int id;
  String abbreviation;
  String flagUrl;

  Currency({
    this.id,
    this.abbreviation,
    this.flagUrl,
  });

  Currency.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    abbreviation = json['abbreviation'];
    flagUrl = json['flagUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['abbreviation'] = this.abbreviation;
    data['flagUrl'] = this.flagUrl;
    return data;
  }
}
