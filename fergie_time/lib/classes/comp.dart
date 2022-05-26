// ignore_for_file: unnecessary_this, unused_element, prefer_collection_literals

class Comp {
  String logo, name;
  Comp({this.logo, this.name});

  Comp.fromMap(Map<String, dynamic> map) {
    this.logo = map['logo'];
    this.name = map['name'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['logo'] = this.logo;
    map['name'] = this.name;
    return map;
  }
}
