class CustomerLoginModel {
  final bool status;
  final Data data;
  final String message;

  CustomerLoginModel({
    required this.status,
    required this.data,
    required this.message,
  });

  factory CustomerLoginModel.fromJson(Map<String, dynamic> json) {
    return CustomerLoginModel(
      status: json['status'],
      data: Data.fromJson(json['data']),
      message: json['message'],
    );
  }
}

class Data {
  final User user;
  final String token;

  Data({required this.user, required this.token});

  factory Data.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) {
      // Return default values when data is an empty object
      return Data(user: User(id: 0, username: '', phone: '', email: '', fullName: '', userType: ''
      ), token: '');
    }

    return Data(
      user: User.fromJson(json['user']),
      token: json['token'],
    );
  }
}

class User {
  final int id;
  final String username;
  final String phone;
  final String email;
  final String fullName;
  final String userType;

  User({
    required this.id,
    required this.username,
    required this.phone,
    required this.email,
    required this.fullName,
    required this.userType,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      fullName: json['full_name'] ?? '',
      userType: json['user_type'] ?? '',
    );
  }
}