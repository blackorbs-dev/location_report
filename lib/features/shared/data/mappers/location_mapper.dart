import '../../domain/models/location.dart';
import '../entities/location.dart';

extension EntityToLocation on LocationEntity{
  LocationModel toLocation() => LocationModel(
      id: id,
      lat: lat,
      long: long,
      address: address,
    );
}

extension LocationToEntity on LocationModel{
  LocationEntity toEntity() =>
      LocationEntity(
        id: id ?? 0,
        lat: lat,
        long: long,
        address: address,
      );

}