import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../view_model/home_layout_cubit.dart';
import 'search_results_widget.dart';

class MySearchDelegate extends SearchDelegate {
  List<String> availableSuggestions;
  Cubit<HomeLayoutState> homeLayoutCubit;

  MySearchDelegate({
    required this.availableSuggestions,
    required this.homeLayoutCubit
  }) : super(
    searchFieldDecorationTheme: InputDecorationTheme(
    )
  );

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(
      icon: const Icon(Icons.clear),
      onPressed: () {
        if (query.isEmpty) {
          close(context, null);
        } else {
          query = '';
        }
      },
    )];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {

    return SizedBox(
      child: SearchResultsWidget(query : query, cubit: homeLayoutCubit),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionList = availableSuggestions.where((element) => element.toLowerCase().contains(query.toLowerCase())).toList();
    return ListView.builder(itemCount: suggestionList.length ,itemBuilder: (context, index) {
      final suggestion = suggestionList[index];
      return ListTile(
        title: Text(suggestion),
        onTap: () {
          query = suggestion;
          showResults(context);
        },
      );
    },);
  }
}
