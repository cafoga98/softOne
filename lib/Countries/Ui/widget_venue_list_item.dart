/*
ElevatedButton(
onPressed: () async {
const String googleMapsUrl =
    "google.com";
const String appleMapsUrl =
    "maps.apple.com";

if (await canLaunchUrl(Uri(
scheme: 'https', host: googleMapsUrl, path: '/maps/search/', queryParameters: {'api': '1', 'query': '$lat,$lng'}))) {
await launchUrl(Uri(
scheme: 'https', host: googleMapsUrl, path: '/maps/search/', queryParameters: {'api': '1', 'query': '$lat,$lng'}));
}
if (await canLaunchUrl(Uri(
scheme: 'https', host: appleMapsUrl, queryParameters: {'q': '$lat,$lng'}))) {
await launchUrl(Uri(
scheme: 'https', host: appleMapsUrl, queryParameters: {'q': '$lat,$lng'}), mode: LaunchMode.externalApplication);
} else {
throw "Couldn't launch URL";
}
},
child: const Text("Hola"))*/

/*
final String lat = "47.3230";
final String lng = "-142.0212";
final Uri _url = Uri.parse('https://flutter.dev');

Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw 'Could not launch $_url';
  }
}*/

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:softone/Countries/Data/venues.dart';
import 'package:softone/Countries/Ui/Utils/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class VenueListItem extends StatelessWidget {
  const VenueListItem({Key? key, required this.venues}) : super(key: key);

  final Venues venues;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
      shadowColor: Colors.black,
      elevation: 4,
      child: Container(
        height: MediaQuery.of(context).size.height / 7,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(15),
        child: Wrap(
          direction: Axis.vertical,
          crossAxisAlignment: WrapCrossAlignment.start,
          runSpacing: 15,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 12,
              width: MediaQuery.of(context).size.width / 6,
              child: ElevatedButton(
                onPressed: () => _goToMaps(latitude: venues.lat, longitude: venues.lon),
                style: defaultBtnStyle,
                child: Center(
                  child: Text(
                    "GO",
                    style: subTitleCard,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.5,
              height: MediaQuery.of(context).size.height / 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(venues.name,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style: titleCard),
                  Text(venues.category,
                      softWrap: true,
                      overflow: TextOverflow.fade,
                      style: subTitleCard),
                  Text(venues.geolocationDegrees,
                      softWrap: true,
                      overflow: TextOverflow.fade,
                      style: subTitleCard)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

_goToMaps({required double latitude, required double longitude}) async {
  Uri googleMapsUrl = Uri(
      scheme: 'https',
      host: 'google.com',
      path: '/maps/search/',
      queryParameters: {'api': '1', 'query': '$latitude,$longitude'});
  Uri appleMapsUrl = Uri(
      scheme: 'https',
      host: 'maps.apple.com',
      queryParameters: {'q': '$latitude,$longitude'});

  if (Platform.isAndroid) {
    if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(
          googleMapsUrl,
          mode: LaunchMode.platformDefault);
    }
  } else {
    if (await canLaunchUrl(appleMapsUrl)) {
      await launchUrl(
          appleMapsUrl,
          mode: LaunchMode.platformDefault);
    } else {
      throw "Couldn't launch URL";
    }
  }
}