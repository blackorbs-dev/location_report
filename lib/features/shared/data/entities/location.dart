import 'package:objectbox/objectbox.dart';

@Entity()
class LocationEntity{
  @Id()
  int id;
  double lat;
  double long;
  String address;

  LocationEntity({
    required this.id,
    required this.lat,
    required this.long,
    required this.address,
  });
}