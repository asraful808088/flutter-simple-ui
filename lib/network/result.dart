class Result {
  late bool? success;
  late String? fileError;
  late String? nameError;
  late String? emailError;
  late String? passwordError;
  late String? co_password_Error;
  late String? codeError;
  late String? secretError;
  late String? tokenError;
  Result(
      {this.co_password_Error,
      this.emailError,
      this.fileError,
      this.codeError,
      this.nameError,
      this.passwordError,
      this.secretError,
      this.tokenError,
      this.success});
}
