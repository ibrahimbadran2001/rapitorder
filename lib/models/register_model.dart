class RegisterModel {
  final bool status;
  final Data data;
  final String message;

  RegisterModel({
    required this.status,
    required this.data,
    required this.message,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      status: json['status'],
      data: Data.fromJson(json['data']),
      message: json['message'],
    );
  }
}

class Data {
  final int id;
  final String username;
  final String phone;
  final String email;
  final String fullName;
  final String userType;

  Data({
    required this.id,
    required this.username,
    required this.phone,
    required this.email,
    required this.fullName,
    required this.userType,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      username: json['username'],
      phone: json['phone'],
      email: json['email'],
      fullName: json['full_name'],
      userType: json['user_type'],
    );
  }
}