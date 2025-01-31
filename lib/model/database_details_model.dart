import 'dart:convert';

class DatabaseDetailsModel {
  String userName;
  String userEmail;
  String userImage;
  int totalCreditRedeemed;
  int creditBalance;
  DatabaseDetailsModel({
    required this.userName,
    required this.userEmail,
    required this.userImage,
    required this.totalCreditRedeemed,
    required this.creditBalance,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userName': userName,
      'userEmail': userEmail,
      'userImage': userImage,
      'totalCreditRedeemed': totalCreditRedeemed,
      'creditBalance': creditBalance,
    };
  }

  factory DatabaseDetailsModel.fromMap(Map<String, dynamic> map) {
    return DatabaseDetailsModel(
      userName: map['userName'] as String,
      userEmail: map['userEmail'] as String,
      userImage: map['userImage'] as String,
      totalCreditRedeemed: map['totalCreditRedeemed'],
      creditBalance: map['creditBalance'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DatabaseDetailsModel.fromJson(String source) =>
      DatabaseDetailsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
