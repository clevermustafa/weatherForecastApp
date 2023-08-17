class Coord {
  double? lat;
  double? lon;

  Coord({this.lat, this.lon});

  @override
  String toString() => 'Coord(lat: $lat, lon: $lon)';

  factory Coord.fromJson(Map<String, dynamic> json) => Coord(
        lat: (json['lat'] as num?)?.toDouble(),
        lon: (json['lon'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lon': lon,
      };
}
