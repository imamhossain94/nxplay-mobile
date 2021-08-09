class Links {
  final String url;
  final String label;
  final bool active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json):
        url = json['url'],
        label = json['label'].toString(),
        active = json['active'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}