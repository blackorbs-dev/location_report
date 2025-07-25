enum ReportType{
  dumpedRubbish('Dumped Rubbish', 'assets/icons/rubbish.svg'),
  graffitiVandalism('Graffiti or Vandalism', 'assets/icons/graffiti.svg'),
  pedestrianHazard('Pedestrian Hazard', 'assets/icons/pedestrian.svg'),
  trafficHazard('Traffic Hazard', 'assets/icons/traffic.svg'),
  other('Other', 'assets/icons/incident.svg');

  final String name;
  final String icon;

  const ReportType(this.name, this.icon);
}