import 'package:fitness_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void showBottomFunc(
    BuildContext context, String string, double latitude, double longitude) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 8.0, right: 8, top: 26, bottom: 6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                string,
                style: customStyle.copyWith(),
                maxLines: 1,
                overflow: TextOverflow.fade,
              ),
              const SizedBox(
                height: 6,
              ),
              TextButton(
                onPressed: () async {
                  await openMap(latitude, longitude);
                  if(context.mounted){
                    Navigator.of(context).pop();
                  }

                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  minimumSize: Size(MediaQuery.of(context).size.width, 36),
                  textStyle: customStyle,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text('Direction'),
              )
            ],
          ),
        ),
      );
    },
  );
}

Future<void> openMap(double latitude, double longitude) async {
  String googleMapUrl =
      "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude/directions";
  Uri uri = Uri.parse(googleMapUrl);
 if( await canLaunchUrl(uri)){
   await launchUrl(uri,);
 }
}
