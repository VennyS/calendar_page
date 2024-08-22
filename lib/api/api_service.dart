import 'package:calendar_gymatech/models/list_item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  late String baseUrl;

  factory ApiService() {
    return _instance;
  }

  ApiService._internal();

  Future<void> setBaseUrl(String url) async {
    baseUrl = url;
  }

  Future<List<ListItem>> fetchListItems() async {
    final response =
        await http.get(Uri.parse('$baseUrl/test/group_training_object/0'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
          json.decode(utf8.decode(response.bodyBytes));
      List<ListItem> items = [];

      data.forEach((key, value) {
        if (value is Map<String, dynamic>) {
          value.forEach((time, activities) {
            if (activities is List) {
              for (var activity in activities) {
                items.add(ListItem.fromJson(activity));
              }
            }
          });
        }
      });

      return items;
    } else {
      throw Exception('Failed to load list items');
    }
  }
}
