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

  Future<List<ListItem>> fetchListItems(int weekNumber) async {
    final response = await http
        .get(Uri.parse('$baseUrl/test/group_training_object/$weekNumber'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
          json.decode(utf8.decode(response.bodyBytes));
      List<ListItem> items = [];

      // Проходите по ключам времени
      data.forEach((timeKey, activitiesList) {
        // activitiesList - это список, содержащий активности в это время
        if (activitiesList is List) {
          for (var activity in activitiesList) {
            // Преобразуйте каждый элемент в объект ListItem
            items.add(ListItem.fromJson(activity));
          }
        }
      });

      return items;
    } else {
      throw Exception('Failed to load list items');
    }
  }
}
