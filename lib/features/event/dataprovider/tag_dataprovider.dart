import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:kese_events/injector.dart';
import 'package:kese_events/models/event/event.dart';
import 'package:kese_events/models/tag/tag.dart';

class TagDataProvider {
  final http.Client httpClient;
  // static const int limit = 20;
  TagDataProvider(
    this.httpClient,
  );

    Future<List<Tag>> getTags() async {
    final config = await DependencyInjector.getAppConfig();

    try {
      // TODO: Add Token
      // final uri = Uri.parse(config!.apiUrl + url + params);
      final uri = Uri.parse('http://192.168.43.250:8000/event/tags');
      final response = await http.get(uri);

      // print(response.body);

      final res = jsonDecode(response.body);
      // print(res);
      final map = res['data'];
      // print(map);

      List<Tag> tags = [];
      for (int i = 0; i < map.length; i++) {
        Tag tag = Tag.fromMap(map[i]);
        tags.add(tag);
      }

      // print(tags);
      // print(response.statusCode);
      if (response.statusCode == 200) {
        return tags;
      } else {
        final err = jsonDecode(response.body);
        throw err;
      }
    } catch (err) {
      // return throw AppMsg(err.toString());
      // print(err.toString());
      return throw const SocketException("Check Your Conncetion");
    }
  }



}