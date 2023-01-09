
// action model
class ActionModel {

  int? id;
  String email;
  String action;
  String date;

  // constructeur
  ActionModel({
    required this.id,
    required this.email,
    required this.action,
    required this.date});

  // map String, dynamic
  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "action": action,
    "date": date
  };

  // fromJson
  factory ActionModel.fromJson(Map<String, dynamic> json) => ActionModel(
          id: json["id"],
          email: json["email"],
          action: json["action"],
          date: json["date"]
  );

}