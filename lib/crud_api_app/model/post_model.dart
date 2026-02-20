class PostModel {
  final int? id;
  final String title;
  final String body;
  PostModel({this.id, required this.body, required this.title});
  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(id: json["id"], body: json["body"], title: json["title"]);
  }
  Map<String, dynamic> toJson() {
    return {"title": title, "body": body};
  }
}
