part of 'bloc.dart';

abstract class VenuesEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class VenuesFetched extends VenuesEvent{}