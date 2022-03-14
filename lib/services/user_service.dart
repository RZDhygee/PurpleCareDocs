
import 'dart:convert';

import 'package:purplecaredocs/models/API_response.dart';
import 'package:purplecaredocs/models/user_model.dart';
import 'package:purplecaredocs/models/user_param.dart';
import 'package:http/http.dart' as http;
import 'package:purplecaredocs/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {

  static const API = Utils.endPoint + "users/";


  Future<APIResponse<User>> Login(UserParam item) {
    return http.post(
        API + "auth", headers: Utils.headers, body: json.encode(item.toJson()))
        .then((data) {
      if (data.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(data.body);
        var item = jsonData["user"];
        print(item);

        final user = User(
            item['id'],
            item['name'],
            item['surname'],
            item['email'],
            item['password'],
            item['role'],
            item['nation'],
            item['city'],
            item['prefix'],
            item['phone'],
            item['creationDate'],
            item['status'],
            item['hospital'],
            item['specialization'],
            item['token']);
        return APIResponse<User>(data: user);
      }
      return APIResponse<User>(error: true, errorMessage: "An error 1");
    }).catchError((_) =>
        APIResponse<User>(error: true, errorMessage: "An error 2"));
  }

}