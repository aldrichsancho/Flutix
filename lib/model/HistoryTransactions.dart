class HistoryTransactions {
  String? photo;
  String? name;
  double? nominal;
  String? description;
  String? type;

  HistoryTransactions({this.photo, this.name, this.nominal, this.description, this.type});

  HistoryTransactions.fromJson(Map<String, dynamic> json) {
    photo = json['photo'];
    name = json['name'];
    nominal = json['nominal'];
    description = json['description'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['photo'] = this.photo;
    data['name'] = this.name;
    data['nominal'] = this.nominal;
    data['description'] = this.description;
    data['type'] = this.type;
    return data;
  }
}