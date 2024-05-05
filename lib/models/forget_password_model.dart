class ForgetPasswordModel {
  final bool status;
  final String message;
  ForgetPasswordModel({required this.message,required this.status});
  factory ForgetPasswordModel.fromJson(Map<String, dynamic> json) {
    return ForgetPasswordModel(
      status: json['status'],
      message: json['message'],
    );
  }
}