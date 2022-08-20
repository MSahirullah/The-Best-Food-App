import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivery_app/utils/dimentions.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationDialog extends StatelessWidget {
  final GoogleMapController mapController;

  const LocationDialog({Key? key, required this.mapController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    return Container(
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimentions.radius20/2,),
        ),
        child: SizedBox(
          width: Dimentions.screenWidth,
          child: Container(
            // child: Text(
              
            // ),
          ),
        ),
      ),
    );
  }
}
