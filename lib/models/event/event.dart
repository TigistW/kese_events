// import 'package:kese_events/models/tag/tag.dart';
// import 'package:kese_events/models/user/organizer.dart';

// class Event {
//   final int id;
//   final String name;
//   final String description;
//   final double price;
//   final String createdDate;
//   final String updatedDate;
//   final String eventEndDate;
//   final String eventStartDate;
//   final String thumbnail;
//   final List<Tag> tags;
//   final Organizer organizerId;

//   Event({
//     required this.createdDate,
//     required this.updatedDate,
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.eventEndDate,
//     required this.eventStartDate,
//     required this.price,
//     required this.thumbnail,
//     required this.tags,
//     required this.organizerId,
// });

//     Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'description': description,
//       'price': price,
//       'eventEndDate': eventStartDate,
//       'eventStartDate': eventEndDate,
//       'thumbnail': thumbnail,
//       'created_date':createdDate,
//       'updated_date': updatedDate,
//       'tags': tags
//     };
//   }
//   factory Event.fromMap(Map<String, dynamic> map) {
//     return Event(
//     id : map['id'] ?? "",
//     organizerId: map['organizer'] ?? "",
//     name: map['title'] as String,
//     description : map['description'] as String,
//     price : map['ticket_price'] ?? 0,
//     eventStartDate : map['start_date'] ??'',
//     eventEndDate : map['end_date'] ?? '',
//     thumbnail : map['image'] as String,
//     createdDate: map['created_at'] ?? "",
//     updatedDate: map['updated_at'] ?? "",
//     tags: map['tags'] ?? "",
//     );
//   }

// }
import 'package:kese_events/models/tag/tag.dart';
import 'package:kese_events/models/user/organizer.dart';

class Event {
  final int id;
  final String name;
  final String description;
  final double price;
  final String createdDate;
  final String updatedDate;
  final DateTime eventEndDate;
  final DateTime eventStartDate;
  final String location;
  final int capacity;
  final String thumbnail;
  final List<Tag> tags;
  final Organizer organizerId;

  Event({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.createdDate,
    required this.updatedDate,
    required this.eventEndDate,
    required this.eventStartDate,
    required this.location,
    required this.capacity,
    required this.thumbnail,
    required this.tags,
    required this.organizerId,
  });

  factory Event.fromMap(Map<String, dynamic> map) {
    print("llllllllllllllllllllllllllllllggggggggggggggggggggggggggglllllll");
    final organizer = Organizer.fromMap(map['organizer']);
    
     List<dynamic> tagList = map['tags'];
    List<Tag> tags = tagList.map((tagMap) => Tag.fromMap(tagMap)).toList();
    print("bbbbbbbbbbbbbbbb");

    return Event(
      id: map['id'],
      name: map['title'],
      description: map['description'],
      price: double.tryParse(map['ticket_price'] ?? '0') ?? 0,
      createdDate: map['created_at'],
      updatedDate: map['updated_at'],
      eventStartDate: DateTime.parse(map['start_date']),
      eventEndDate: DateTime.parse(map['end_date']),
      location: map['location'],
      capacity: map['capacity'] ?? 0,
      thumbnail: map['image_url'],
      //   tags: map['tags'],
      // organizerId: map['organizer'],
      tags: tags,
      organizerId: organizer,
    );
  }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'id': id,
  //     'title': name,
  //     'description': description,
  //     'ticket_price': price.toString(),
  //     'created_at': createdDate,
  //     'updated_at': updatedDate,
  //     'start_date': eventStartDate,
  //     'end_date': eventEndDate,
  //     'location': location,
  //     'capacity': capacity.toString(),
  //     'image': thumbnail,
  //     'organizer': organizerId.toMap(),
  //     'tags': tags.map((tag) => tag.toMap()).toList(),
  //   };
  // }
}
