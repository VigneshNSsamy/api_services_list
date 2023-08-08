import 'dart:convert';
UserPets userPetsFromJson(String str) => UserPets.fromJson(json.decode(str));
String userPetsToJson(UserPets data) => json.encode(data.toJson());

class UserPets {
  UserPets({required this.data});

  final List<Datum> data;

  factory UserPets.fromJson(Map<String, dynamic> json) => UserPets(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
class Datum{
  Datum({
    required this.id,
    required this.userName,
    required this.petName,
    required this.petImage,
    required this.isFrindly
});
  final int id;
  final String userName;
  final String petName;
  final String petImage;
  final bool isFrindly;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json['id'],
    userName: json["userName"],
    petName: json["petName"],
    petImage: json["petImage"],
    isFrindly: json["isFriendly"],
  );
  Map<String, dynamic> toJson() =>{
    "id": id,
    "userName": userName,
    "petName": petName,
    "petImage": petImage,
    "isFriendly": isFrindly,
  };
}



