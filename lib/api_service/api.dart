class Api {
  static const hostConnection = "http://192.168.1.4/3000";
  static const hostConnectUser = "$hostConnection/user";

  //signup user

  static const validateEmail = "$hostConnectUser/user/validate_email.php";
  static const signUpUser = "$hostConnectUser/user/user_signup.php";
}
