import 'package:equatable/equatable.dart';

class LocationModel extends Equatable{
  final int? id;
  final double lat;
  final double long;
  final String address;

  const LocationModel({
    this.id = 0,
    required this.lat,
    required this.long,
    this.address = '',
  });

  @override
  List<Object?> get props => [lat, long, address];

  @override
  bool? get stringify => true;

}