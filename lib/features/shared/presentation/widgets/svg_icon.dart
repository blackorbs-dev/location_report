import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class SvgIcon extends StatelessWidget{
  const SvgIcon(this.assetName, {super.key, this.color, this.size = 24});

  final String assetName;
  final Color? color;
  final double size;

  @override
  Widget build(BuildContext context) =>
      SvgPicture.asset(
        assetName, width: size, height: size,
        colorFilter: color == null? null : ColorFilter.mode(color!, BlendMode.srcIn)
      );

}