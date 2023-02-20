import 'dart:convert';
import 'dart:io';

import "package:http/http.dart" as http;
import "package:megawallet/network/result.dart";

class SignUpNetwork {
  Future<Result> stap1({required String name, required String email}) async {
    Map<String, String> body = {
      'name': name,
      'email': email,
    };
    final response =
        await http.post(Uri.parse("http://168.192.1.108:4000/auth/"),
            headers: {
              "Accept": "application/json",
              "Content-Type": "application/x-www-form-urlencoded"
            },
            body: body,
            encoding: Encoding.getByName("utf-8"));
    final parseData = jsonDecode(response.body);
    if (parseData["name"] != null) {
      return Result(nameError: parseData["name"]["msg"], success: false);
    }
    if (parseData["email"] != null) {
      return Result(emailError: parseData["email"]["msg"], success: false);
    }

    return Result(success: true);
  }

  Future<Result> stap2(
      {required String password, required String coPassword}) async {
    if (password != coPassword) {
      return Result(
          success: false,
          co_password_Error: "Password and confirm password does not match");
    }
    Map<String, String> body = {
      'password': password,
    };
    final response =
        await http.post(Uri.parse("http://168.192.1.108:4000/auth/stap2"),
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

  Future<Result> stap3({File? image, String? imageName, String? email}) async {
    if (image != null) {
      var postUri = Uri.parse("http://168.192.1.108:4000/auth/file");
      var request = http.MultipartRequest("POST", postUri);
      request.fields["file"] = imageName!;
      request.fields["email"] = email!;
      request.files.add(http.MultipartFile.fromBytes(
        'file',
        await File.fromUri(image.uri).readAsBytes(),
      ));

      final response = await request.send();
      print(response.statusCode);
      if (response.statusCode == 413) {
        return Result(fileError: "File too large", success: false);
      } else if (response.statusCode == 405) {
        return Result(success: false, fileError: "only png, jpg, jpeg allow");
      }
    }
    var postUri = Uri.parse("http://168.192.1.108:4000/auth/file");
    var request = http.MultipartRequest("POST", postUri);
    request.fields["file"] = 'null';
    request.fields["email"] = email!;
    final response = await request.send();
    return Result(success: true);
  }

  Future<Result> stap4(
      {required String code,
      required String name,
      required String password,
      required String email,
      File? image}) async {
    var postUri = Uri.parse("http://168.192.1.108:4000/auth/final");
    var request = http.MultipartRequest("POST", postUri);
    request.fields["name"] = name;
    request.fields["email"] = email;
    request.fields["password"] = password;
    request.fields["hash_code"] = code;
    if (image != null) {
      request.files.add(http.MultipartFile.fromBytes(
        'file',
        await File.fromUri(image.uri).readAsBytes(),
      ));
    }

    final response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 401) {
      return Result(codeError: "Invalid hash-code", success: false);
    }
    return Result(success: true);
  }
}
