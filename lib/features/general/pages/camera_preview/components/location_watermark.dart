import 'package:boilerplate/core/core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LocationWatermark extends StatelessWidget {
  final LocationModel location;

  const LocationWatermark({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 10,
      right: 0,
      left: 0,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: Dimens.size5,
        ),
        padding: EdgeInsets.all(Dimens.size10),
        decoration: BoxDecoration(
          color: Colors.black..withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(Dimens.size10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              DateFormat("dd/MM/yy HH:mm").format(DateTime.now()),
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Palette.white,
                    fontSize: Dimens.text12,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(
              "Lat : ${location.lat} Long : ${location.lon}",
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Palette.white,
                    fontSize: Dimens.text8,
                  ),
              textAlign: TextAlign.right,
            ),
            Text(
              "${location.address?.road ?? "-"}, ${location.address?.suburb ?? "-"}, ${location.address?.city ?? "-"}, ${location.address?.region ?? "-"}",
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Palette.white,
                    fontSize: Dimens.text8,
                  ),
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
    );
  }
}
