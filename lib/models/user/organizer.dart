class Organizer{
  final int id;
  final String name;
  final String profilePicture;
  final String description;

  final String website;
  final String contactEmail;


  Organizer({
    required this.id,
    required this.name,
    required this.profilePicture,
    required this.website,
    required this.contactEmail,
    required this.description
  });

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'name': name,
      'logo':profilePicture
    };
  }

  factory Organizer.fromMap(Map<String, dynamic> map){
    return Organizer(
      id: map['id'] ?? "",
      name: map['name'] as String,
      profilePicture: map['logo_url'] as String,
      description: map['description'] as String,
      website: map['website'] as String,
      contactEmail: map['contact_email'] as String,

       );
  }

}