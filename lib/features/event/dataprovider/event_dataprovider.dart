import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:kese_events/injector.dart';
import 'package:kese_events/models/event/event.dart';

class EventDataProvider {
  final http.Client httpClient;
  // static const int limit = 20;
  EventDataProvider(
    this.httpClient,
  );


  Future<List<Event>> getUpcomingEvents() async {
    //  String params = "&limit=$limit";
    final config = await DependencyInjector.getAppConfig();
    try {
      final uri = Uri.parse('http://192.168.43.250:8000/event/upcoming-events');
      final response = await http.get(uri);
      final res = jsonDecode(response.body);
      final map = res['data'];
      // print(map);
      List<Event> events = [];
      for (int i = 0; i < map.length; i++) {
        // print(map[i]);
        Event event = Event.fromMap(map[i]);
          
        events.add(event);
        // print(event);
      }

      
      if (res['statusCode'] == 200) {
        print("evessssssssssssssssssssssssssnt");
        print(events);
        return events;
      } else {
        final err = jsonDecode(response.body);
        throw err;
      }
    } catch (err) {
      return throw const SocketException("Check Your Conncetion");
    }
  }


  Future<List<Event>> getEvents() async {
  //  String params = "&limit=$limit";
    final config = await DependencyInjector.getAppConfig();

    try {
      // TODO: Add Token
      // final uri = Uri.parse(config!.apiUrl + url + params);
      final uri = Uri.parse('http://192.168.43.250:8000/event/events');
      final response = await http.get(uri);

      final res = jsonDecode(response.body);

      final map = res['data'];
      List<Event> events = [];
      for (int i = 0; i < map.length; i++) {
        Event event = Event.fromMap(map[i]);
        events.add(event);
      }

      if (response.statusCode == 200) {

        return events;
      } else {
        final err = jsonDecode(response.body);
        throw err;
      }
    } catch (err) {
      return throw const SocketException("Check Your Conncetion");
    }

  }

  Future<Event> getEventById(int id) async {
    final config = await DependencyInjector.getAppConfig();
     try {
      final response = await httpClient.get(
        // Uri.parse("http://localhost:3001/event/$id"),
        Uri.parse("http://192.168.43.250:8000/event/events/$id"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization': "Bearer $token",
        },
      );

      print(Uri.parse("http://192.168.43.250:8000/event/events/$id"));
      final res = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final map = res['data'];
        return Event.fromMap(map);
      } else {
        final err = jsonDecode(response.body);
        throw err;
      }
    } catch (e) {
      return throw e.toString();
    }
  }


  Future<List<Event>> getEventByTag(int tag) async {
     print("ooooooooooooooooooooooooooooooo");
      print(tag);
      print("ooooooooooooooooooooooooooooooo");
    final config = await DependencyInjector.getAppConfig();
    try {
      final response = await httpClient.get(
        // Uri.parse("http://localhost:3001/event/$id"),
        Uri.parse("http://192.168.43.250:8000/event/events-by-tags-list/?tags=$tag"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // 'Authorization': "Bearer $token",
        },
      );
       print("kkkkkkkkkkvvvvvvvvkkkkkkkk");
      print(response.body);
      

      final res = jsonDecode(response.body);
      final map = res['data'];

      List<Event> events = [];
      for (int i = 0; i < map.length; i++) {
        print(i);
        Event event = Event.fromMap(map[i]);
        events.add(event);
      }
      print("kkkkkkkkkkkkkkkkkk");
      print(events);
      if (response.statusCode == 200) {
        return events;
      } else {
        final err = jsonDecode(response.body);
        throw err;
      }
    } catch (err) {
      print("nnnnnnnnnnnnn");
      print(err.toString());
      return throw const SocketException("Check Your Conncetion");
    }

  }}
