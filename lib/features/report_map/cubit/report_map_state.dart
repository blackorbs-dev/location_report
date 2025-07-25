part of 'report_map_cubit.dart';

sealed class ReportMapState extends Equatable {
  const ReportMapState();

  const factory ReportMapState.loading() = Loading;
}

final class Loading extends ReportMapState {
  const Loading();

  @override
  List<Object> get props => [];
}

final class Loaded extends ReportMapState {
  const Loaded({
    required this.currentLocation,
    required this.markers,
  });

  final LocationModel currentLocation;
  final Set<Marker> markers;

  Loaded copyWith({
    LocationModel? currentLocation,
    Set<Marker>? markers,
  }) {
    return Loaded(
      currentLocation: currentLocation ?? this.currentLocation,
      markers: markers ?? this.markers,
    );
  }

  @override
  List<Object?> get props => [currentLocation, markers];
}

final class Error extends ReportMapState {
  final String message;

  const Error(this.message);

  @override
  List<Object> get props => [message];
}
