import 'dart:convert';

import 'package:myapp2/models/car.dart';
import 'package:myapp2/models/models.dart';
import 'package:myapp2/services/globals.dart';
import 'package:http/http.dart' as http;
import 'package:myapp2/services/sharedPreferences.dart';

const String baseURL = "http://10.0.2.2:8000/api/";

class AuthServices {
  static Future<http.Response> register(
      String name, String email, String password) async {
    Map data = {
      "name": name,
      "email": email,
      "password": password,
    };
    var body = json.encode(data);
    var url = Uri.parse(baseURL + 'auth/register');
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    print(response.body);
    return response;
  }

  static Future<http.Response> login(String email, String password) async {
    Map data = {
      "email": email,
      "password": password,
    };
    var body = json.encode(data);
    // ignore: prefer_interpolation_to_compose_strings
    var url = Uri.parse('http://10.0.2.2:8000/api/auth/login');
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      String userId = jsonResponse['user_id']
          .toString(); // Adjust according to your API response
      await PreferencesService.saveUserId(userId);
    } else {
      // Handle error
      throw Exception('Failed to login');
    }
    print(response.body);
    return response;
  }

  static Future<List<car_model>> fetchCarModels() async {
    var url = Uri.parse(baseURL + 'show_models');
    http.Response response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body)['data'] as List;
      return data.map((json) => car_model.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load car models');
    }
  }

  // Function to fetch car models from the API
  static Future<List<car>> fetchCars() async {
    var url = Uri.parse(baseURL + 'show_cars');
    http.Response response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body)['data'] as List;
      return data.map((json) => car.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load cars');
    }
  }

  static Future<http.Response> sendQuoteRequest({
    required String userId,
    required String carId,
    required String carName,
    required int carPrice,
  }) async {
    var url = Uri.parse(baseURL + 'quote-request');
    Map<String, dynamic> data = {
      "user_id": userId,
      "car_id": carId,
      "car_name": carName,
      "car_price": carPrice,
    };

    var body = json.encode(data);
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    print(response.body); // For debugging purposes
    return response;
  }
}
