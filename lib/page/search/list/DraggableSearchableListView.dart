import 'package:flutter/material.dart';
import 'package:tripadvisor/page/search/list/PlaceList.dart';
import 'package:tripadvisor/bloc/bloc.dart';
import 'package:tripadvisor/page/search/list/PlaceDetail.dart';
import 'package:tripadvisor/generated/l10n.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tripadvisor/page/search/list/Filter.dart';
import 'package:tripadvisor/page/search/SearchPlaceDelegate.dart';

class DraggableSearchableListView extends StatefulWidget {
  DraggableSearchableListView({Key key}) : super(key: key);

  @override
  _DraggableSearchableListViewState createState() =>
      _DraggableSearchableListViewState();
}

class _DraggableSearchableListViewState
    extends State<DraggableSearchableListView> {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableActuator(
      child: Stack(
        children: <Widget>[
          DraggableScrollableSheet(
            initialChildSize: 0.18,
            minChildSize: 0.18,
            maxChildSize: 0.85,
            builder: (BuildContext context, ScrollController scrollController) {
              return BlocBuilder<DraggableListViewBloc, DraggableListViewState>(
                builder: (context, state) {
                  if (state is ShowSearch) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: CustomScrollView(
                        controller: scrollController,
                        slivers: <Widget>[
                          SliverAppBar(
                            bottom: PreferredSize(
                              preferredSize: const Size.fromHeight(45),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    decoration: new BoxDecoration(
                                      borderRadius:
                                          new BorderRadius.circular(16.0),
                                      color: Colors.black12,
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        Flexible(
                                          child: BlocBuilder<FilteredSearchBloc,
                                              FilteredSearchState>(
                                            builder: (context, state) {
                                              if (state is SearchLoadSuccess) {
                                                return TextField(
                                                  focusNode: FocusNode(),
                                                  enableInteractiveSelection:
                                                      false,
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    prefixIcon:
                                                        Icon(Icons.search),
                                                    hintText: (state.pivot ==
                                                            null)
                                                        ? S
                                                            .of(context)
                                                            .search_hint
                                                        : S
                                                            .of(context)
                                                            .input_nearby(state
                                                                .pivot.name),
                                                  ),
                                                  onTap: () => showSearch(
                                                    context: context,
                                                    delegate:
                                                        SearchPlaceDelegate(),
                                                  ),
                                                );
                                              } else {
                                                return TextField(
                                                  focusNode: FocusNode(),
                                                  enableInteractiveSelection:
                                                      false,
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    prefixIcon:
                                                        Icon(Icons.search),
                                                    hintText: (state.pivot ==
                                                            null)
                                                        ? S
                                                            .of(context)
                                                            .search_hint
                                                        : S
                                                            .of(context)
                                                            .input_nearby(state
                                                                .pivot.name),
                                                  ),
                                                  onTap: () => showSearch(
                                                    context: context,
                                                    delegate:
                                                        SearchPlaceDelegate(),
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                        Container(
                                          width: 5,
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.cancel),
                                          onPressed: () {
                                            BlocProvider.of<SearchBloc>(context)
                                                .add(PivotUpdated(null));
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  Filter(),
                                ],
                              ),
                            ),
                            backgroundColor: Colors.white,
                            pinned: true,
                          ),
                          PlaceList()
                        ],
                      ),
                    );
                  } else if (state is ShowDetailSuccess) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: PlaceDetail(place: state.place),
                      ),
                    );
                  }
                  return Container(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Center(
                        child: Text(''),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
