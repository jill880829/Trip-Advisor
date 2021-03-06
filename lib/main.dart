import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tripadvisor/page/BottomNavigationController.dart';

import 'package:bloc/bloc.dart';
import 'package:tripadvisor/SimpleBlocObserver.dart';
import 'package:tripadvisor/bloc/bloc.dart';

import 'package:tripadvisor/api/api.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tripadvisor/generated/l10n.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(MainScreen());
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchBloc>(
          create: (BuildContext context) => SearchBloc(
            placeApiProvider: PlaceApiProvider(),
          ),
        ),
        BlocProvider<SuggestionBloc>(
          create: (BuildContext context) => SearchBloc(
            placeApiProvider: PlaceApiProvider(),
          ),
        ),
        BlocProvider<NavigationBloc>(
          create: (BuildContext context) => NavigationBloc(),
        ),
        BlocProvider<FilteredSearchBloc>(
          create: (BuildContext context) => FilteredSearchBloc(
            searchBloc: BlocProvider.of<SearchBloc>(context),
          ),
        ),
        BlocProvider<DraggableListViewBloc>(
          create: (BuildContext context) => DraggableListViewBloc(
            placeApiProvider: PlaceApiProvider(),
          ),
        ),
        BlocProvider<MapBloc>(
          create: (BuildContext context) => MapBloc(
            filteredSearchBloc: BlocProvider.of<FilteredSearchBloc>(context),
          ),
        ),
        BlocProvider<SaveFavoriteBloc>(
          create: (BuildContext context) => SaveFavoriteBloc(
            placeApiProvider: PlaceApiProvider(),
          ),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: Scaffold(
          body: BottomNavigationController(),
        ),
      ),
    );
  }
}
