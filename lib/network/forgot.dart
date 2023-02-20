import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:megawallet/network/result.dart';

class ForgotNetwork {
  Future<Result> stap1(
      {required String secretCode, required String email}) async {
    Map<String, String> body = {
      'secret': secretCode,
      'email': email,
    };
    final response =
        await http.post(Uri.parse("http://168.192.1.108:4000/auth/forgot"),
            headers: {
              "Accept": "application/json",
              "Content-Type": "application/x-www-form-urlencoded"
            },
            body: body,
            encoding: Encoding.getByName("utf-8"));
    final parseData = jsonDecode(response.body);
    if (parseData["secret"] != null) {
      return Result(nameError: parseData["name"]["msg"], success: false);
    }
    if (parseData["email"] != null) {
      return Result(emailError: parseData["email"]["msg"], success: false);
    }

    return Result(success: true);
  }

  Future<Result> stap2(
      {required String password,
      required String coPassword,
      required String email}) async {
    if (password != coPassword) {
      return Result(
          success: false,
          co_password_Error: "Password and confirm password does not match");
    }
    Map<String, String> body = {'password': password, 'email': email};
    final response = await http.post(
        Uri.parse("http://168.192.1.108:4000/auth/forgot/stap2"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: body,
        encoding: Encoding.getByName("utf-8"));
    final parseData = jsonDecode(response.body);
    if (parseData["password"] != null) {
      return Result(
          success: false, passwordError: parseData["password"]["msg"]);
    }
    return Result(success: true);
  }

  Future<Result> stap3(
      {required String email,
      required String code,
      required String token,
      required String password}) async {
        
    Map<String, String> body = {
      'password': password,
      'email': email,
      'token': token,
      'hash_code': code
    };
     
    final response = await http.post(
        Uri.parse("http://168.192.1.108:4000/auth/forgot/final"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: body,
        encoding: Encoding.getByName("utf-8"));
        
   
    final parseData = jsonDecode(response.body);
   
     if (parseData["hash_code"] != null) {
      return Result(codeError: parseData["hash_code"], success: false);
    }
    if (parseData["token"] != null) {
      return Result(tokenError: parseData["token"], success: false);
    }
   

    return Result(success: true);
  }
}
