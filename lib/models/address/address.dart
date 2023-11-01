class Address {
  final String country;
  final String region;
  final String zone;
  final String woreda;
  final String city;
  final String subCity;
  final double longitude;
  final double latitude;
  final String summary;
  final String id;

  Address({
    required this.country,
    required this.region,
    required this.zone,
    required this.woreda,
    required this.city,
    required this.subCity,
    required this.longitude,
    required this.latitude,
    required this.summary,
    required this.id,
  });

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      country: map['country'] ?? "country",
      region: map['region'] ?? "region",
      zone: map['zone'] ?? "zone",
      woreda: map['woreda'] ?? "woreda",
      city: map['city'] ?? "city",
      subCity: map['subCity'] ?? "subCity",
      longitude: map['longitude'] ?? 0.0,
      latitude: map['latitude'] ?? 0.0,
      summary: map['summary'] ?? "address summary",
      id: map['id'] ?? "id",
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'country': country,
      'region': region,
      'zone': zone,
      'woreda': woreda,
      'city': city,
      'subCity': subCity,
      'longitude': longitude,
      'latitude': latitude,
      'summary': summary,
      'id': id,
    };
  }
}
