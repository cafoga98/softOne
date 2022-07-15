import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softone/Countries/BloC/bloc.dart';
import 'package:softone/Countries/Ui/widget_venue_list_item.dart';

class VenuesList extends StatefulWidget {
  @override
  State<VenuesList> createState() => _VenuesListState();
}

class _VenuesListState extends State<VenuesList> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VenuesBloc, VenuesState>(
      builder: (context, state) {
        switch (state.status) {
          case FetchStatus.failed:
            return const Center(child: Text("Failed fetch posts"));
          case FetchStatus.success:
            if (state.venues.isEmpty) {
              return const Center(child: Text("No Venues"));
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.venues.length
                    ? const Center(
                        child: SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : VenueListItem(
                        venues: state.venues[index],
                      );
              },
              itemCount: state.hasLimit
                  ? state.venues.length
                  : state.venues.length + 1,
              controller: _scrollController,
            );
          default:
            return const Center(
              child: CircularProgressIndicator(),
            );
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<VenuesBloc>().add(VenuesFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final limitScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (limitScroll * 0.9);
  }
}
