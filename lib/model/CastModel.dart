class CastModel {
  int? id;
  String? name;
  String? profilePath;
  int? order;

  CastModel({this.id, this.name, this.profilePath, this.order});

  CastModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    profilePath = json['profile_path'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['profile_path'] = this.profilePath;
    data['order'] = this.order;
    return data;
  }
}