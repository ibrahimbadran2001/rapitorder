class ChangePasswordModel {
  final bool status;
  final String message;
  ChangePasswordModel({required this.message,required this.status});
  factory ChangePasswordModel.fromJson(Map<String, dynamic> json) {
    return ChangePasswordModel(
      status: json['status'],
      message: json['message'],
    );
  }
}