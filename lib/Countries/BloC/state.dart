part of 'bloc.dart';

enum FetchStatus{initial, success, failed}

class VenuesState extends Equatable {
  final FetchStatus status;
  final List<Venues> venues;
  final bool hasLimit;

  const VenuesState({
    this.status = FetchStatus.initial,
    this.venues = const <Venues>[],
    this.hasLimit = false
  });

  VenuesState copyWith({
    FetchStatus? status,
    List<Venues>? venues,
    bool? hasLimit,
  }){
    return VenuesState(
      status: status?? this.status,
      venues: venues?? this.venues,
      hasLimit: hasLimit?? this.hasLimit
    );
  }

  @override
  String toString() {
    return '''VenuesState {status: $status, hasLimit: $hasLimit, venues: ${venues.length}}''';
  }

  @override
  // TODO: implement props
  List<Object?> get props => [status, venues, hasLimit];

}