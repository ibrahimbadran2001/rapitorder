class VerificationModel {
  final bool status;
  final String message;
  VerificationModel({required this.message,required this.status});
  factory VerificationModel.fromJson(Map<String, dynamic> json) {
    return VerificationModel(
      status: json['status'],
      message: json['message'],
    );
  }
}