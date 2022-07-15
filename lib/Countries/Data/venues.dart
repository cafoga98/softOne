import 'package:equatable/equatable.dart';
///```html
///<h2>Description</h2>
/// ```
/// The [Venues] class is used to create a complete model of venues
/// - Constructor: ({required this.[lat], required this.[lon], required this.[category], required this.[name], required this.[geolocationDegrees]})
/// - Use [Equatable] to control the model
///
class Venues extends Equatable{

  //#region Variables
  final double lat;
  final double lon;
  final String category;
  final String name;
  final String geolocationDegrees;
  //endregion

  //#region Constructor
  const Venues({required this.lat, required this.lon, required this.category, required this.name, required this.geolocationDegrees});
  //endregion

  //#region Override Methods
  @override
  // TODO: implement props
  List<Object?> get props => [lat, lon, category, name, geolocationDegrees];
  //endregion
}