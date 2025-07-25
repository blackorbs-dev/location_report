import 'package:flutter/cupertino.dart' hide Route;
import 'package:flutter/material.dart' hide Route;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:location_report/core/theme/extensions.dart';
import 'package:location_report/features/shared/presentation/widgets/primary_button.dart';

import '../../../router/routes.dart';
import '../../shared/presentation/widgets/add_report_button.dart';
import '../../shared/presentation/widgets/app_bar.dart';
import '../../shared/presentation/widgets/svg_icon.dart';
import '../cubit/report_map_cubit.dart';

class ReportMapScreen extends StatelessWidget{
  const ReportMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ReportMapCubit(Location()),
        child: const ReportMapView(),
    );
  }

}

class ReportMapView extends StatelessWidget{
  const ReportMapView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: 'Reports Map',
        leading: Padding(
            padding: const EdgeInsets.all(12),
            child: const SvgIcon('assets/icons/map_marker.svg')
        ),
        action: IconButton(
          onPressed: (){
            context.push(Route.search);
          },
          icon: const SvgIcon('assets/icons/search.svg'),
        ),
      ),
      body: Stack(
        children: [
          BlocBuilder<ReportMapCubit, ReportMapState>(
            builder: (context, state) {
              switch(state){
                case Loading():
                  return const Center(child: CupertinoActivityIndicator());
                case Error():
                  return Column(
                    children: [
                      Text(state.message, style: context.theme.textTheme.bodyMedium,),
                      const SizedBox(height: 8,),
                      PrimaryButton(
                          text: 'RETRY',
                          onPressed: (){
                            context.read<ReportMapCubit>().getCurrentLocation();
                          }
                      )
                    ],
                  );
                case Loaded(:final currentLocation, :final markers):
                  return GoogleMap(
                    initialCameraPosition: CameraPosition(
                        target: LatLng(currentLocation.lat, currentLocation.long),
                        zoom: 15
                    ),
                    markers: markers,
                    onTap: context.read<ReportMapCubit>().addMarker,
                  );
              }
            }
          ),
          AddReportButton(
            onPressed: (){
              final state = context.read<ReportMapCubit>().state;
              if(state is Loaded){
                context.push(Route.addReport, extra: state.currentLocation);
              }
            },
          )
        ],
      ),
    );
  }

}