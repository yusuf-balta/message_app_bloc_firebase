import 'dart:convert';

class PersonModel {
  String? userId;
  DateTime? createdTime;
  bool? newMesage;
  String? photoUrl;
  String? userName;
  String? phoneNumber;
  DateTime? birthDay;
  String? mailAdress;
  String? password;
  PersonModel({
    this.userId,
    this.createdTime,
    this.newMesage,
    this.photoUrl,
    this.userName,
    this.phoneNumber,
    this.birthDay,
    this.mailAdress,
    this.password,
  });

  PersonModel copyWith({
    String? userId,
    DateTime? createdTime,
    bool? newMesage,
    String? photoUrl,
    String? userName,
    String? phoneNumber,
    DateTime? birthDay,
    String? mailAdress,
    String? password,
  }) {
    return PersonModel(
      userId: userId ?? this.userId,
      createdTime: createdTime ?? this.createdTime,
      newMesage: newMesage ?? this.newMesage,
      photoUrl: photoUrl ?? this.photoUrl,
      userName: userName ?? this.userName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      birthDay: birthDay ?? this.birthDay,
      mailAdress: mailAdress ?? this.mailAdress,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'createdTime': createdTime?.millisecondsSinceEpoch,
      'newMesage': newMesage ?? false,
      'photoUrl': photoUrl ?? '',
      'userName': userName,
      'phoneNumber': phoneNumber,
      'birthDay': birthDay?.millisecondsSinceEpoch,
      'mailAdress': mailAdress,
      'password': password,
    };
  }

  factory PersonModel.fromMap(Map<dynamic, dynamic> map) {
    return PersonModel(
      userId: map['userId'],
      createdTime: map['createdTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdTime'])
          : null,
      newMesage: map['newMesage'],
      photoUrl: map['photoUrl'],
      userName: map['userName'],
      phoneNumber: map['phoneNumber'],
      birthDay: map['birthDay'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['birthDay'])
          : null,
      mailAdress: map['mailAdress'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PersonModel.fromJson(String source) =>
      PersonModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PersonModel(userId: $userId, createdTime: $createdTime, newMesage: $newMesage, photoUrl: $photoUrl, userName: $userName, phoneNumber: $phoneNumber, birthDay: $birthDay, mailAdress: $mailAdress, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PersonModel &&
        other.userId == userId &&
        other.createdTime == createdTime &&
        other.newMesage == newMesage &&
        other.photoUrl == photoUrl &&
        other.userName == userName &&
        other.phoneNumber == phoneNumber &&
        other.birthDay == birthDay &&
        other.mailAdress == mailAdress &&
        other.password == password;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        createdTime.hashCode ^
        newMesage.hashCode ^
        photoUrl.hashCode ^
        userName.hashCode ^
        phoneNumber.hashCode ^
        birthDay.hashCode ^
        mailAdress.hashCode ^
        password.hashCode;
  }
}
