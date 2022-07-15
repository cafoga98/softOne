import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softone/Countries/Data/venues.dart';
import 'package:http/http.dart' as http;

part 'event.dart';
part 'state.dart';

const _venuesLimit = 20;

class VenuesBloc extends Bloc<VenuesEvent, VenuesState> {
  final http.Client httpClient;

  VenuesBloc({required this.httpClient}) : super(const VenuesState()) {
    on<VenuesFetched>(_onVenuesFetched);
  }

  Future<void> _onVenuesFetched(
      VenuesFetched event, Emitter<VenuesState> emitter) async {
    if (state.hasLimit) return;
    try {
      if (state.status == FetchStatus.initial) {
        final venues = await _fetchVenues();
        return emitter(state.copyWith(
            status: FetchStatus.success, venues: venues, hasLimit: false));
      }
      final venues = await _fetchVenues(state.venues.length);
      emitter(venues.isEmpty
          ? state.copyWith(hasLimit: true)
          : state.copyWith(
              status: FetchStatus.success,
              venues: List.of(state.venues)..addAll(venues)));
    } catch (_) {
      emitter(state.copyWith(status: FetchStatus.failed));
    }
  }

  Future<List<Venues>> _fetchVenues([int offset = 0]) async {
    final response = await httpClient.get(
      Uri.https('coinmap.org', '/api/v1/venues/',
          <String, String>{'limit': '$_venuesLimit', 'offset': '$offset'}),
    );
    if (response.statusCode == 200) {
      final retriveBody = json.decode(response.body);
      final body = retriveBody["venues"] as List;
      return body.map((dynamic json) {
        return Venues(
            lat: json['lat'] as double,
            lon: json['lon'] as double,
            category: json['category'] as String,
            name: json['name'] as String,
            geolocationDegrees: json['geolocation_degrees'] as String);
      }).toList();
    }
    throw Exception('error fetching venues');
  }
}
