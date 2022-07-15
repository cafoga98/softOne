import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softone/Countries/BloC/bloc.dart';
import 'package:softone/Countries/Ui/venues_list.dart';
import 'package:softone/Countries/Ui/widget_appbar.dart';
import 'package:http/http.dart' as http;

class VenuesPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetAppBar(platformType: currentPlatform.isAndroid).appBarIos(context),
      body: BlocProvider(
          create: (_) => VenuesBloc(httpClient: http.Client())..add(VenuesFetched()),
        child: VenuesList(),
      ),
    );
  }
}
