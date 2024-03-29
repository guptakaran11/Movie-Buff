// ignore_for_file: public_member_api_docs, sort_constructors_first, file_names, prefer_typing_uninitialized_variables, use_key_in_widget_constructors
// ignore_for_file: must_be_immutable

import 'dart:ui';

import 'package:entertainment/controllers/homePageDataController.dart';
import 'package:entertainment/models/homePageModel.dart';
import 'package:entertainment/models/moviesList.dart';
import 'package:entertainment/models/searchCategory.dart';
import 'package:entertainment/widgtes/movieTile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homePageDataControllerProvider =
    StateNotifierProvider<HomePageDataController, HomePageModel>((ref) {
  return HomePageDataController();
});

final selectedMoviePosterUrlProvider = StateProvider<String?>((ref) {
  final movies = ref.watch(homePageDataControllerProvider).movies!;
  return movies.isNotEmpty ? movies[0].posterURL() : null;
});

class HomePage extends ConsumerWidget {
  double? height;
  double? width;
  late var selectedMoviePosterURL;

  late HomePageDataController homePageDataController;
  late HomePageModel homePageModel;

  TextEditingController? searchTextFieldcontroller;

  HomePage({
    super.key,
    this.height,
    this.width,
    this.searchTextFieldcontroller,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    homePageDataController = ref.watch(homePageDataControllerProvider.notifier);
    homePageModel = ref.watch(homePageDataControllerProvider);
    selectedMoviePosterURL = ref.watch(selectedMoviePosterUrlProvider);

    searchTextFieldcontroller = TextEditingController();
    searchTextFieldcontroller!.text = homePageModel.searchText!;
    return buildUI(ref);
  }

  Widget buildUI(WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: SizedBox(
        height: height,
        width: width,
        child: Stack(
          alignment: Alignment.center,
          children: [
            backgroundWidget(),
            foregroundWidgets(ref),
          ],
        ),
      ),
    );
  }

  Widget backgroundWidget() {
    if (selectedMoviePosterURL != null) {
      return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            10.0,
          ),
          image: DecorationImage(
            image: NetworkImage(
              selectedMoviePosterURL,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 10.0,
            sigmaY: 10.0,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(
                0.1,
              ),
            ),
          ),
        ),
      );
    } else {
      return Container(
        height: height,
        width: width,
        color: Colors.black,
      );
    }
  }

  Widget foregroundWidgets(WidgetRef ref) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, height! * 0.02, 0, 0),
      width: width! * 0.90,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          topBarWidget(),
          Container(
            height: height! * 0.83,
            padding: EdgeInsets.symmetric(
              vertical: height! * 0.01,
            ),
            child: movieListViewWidget(ref),
          ),
        ],
      ),
    );
  }

  Widget topBarWidget() {
    return Container(
      height: height! * 0.08,
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(
          20.0,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          searchFieldWidget(),
          categorySelectionWidget(),
        ],
      ),
    );
  }

  Widget searchFieldWidget() {
    const border = InputBorder.none;
    return SizedBox(
      width: width! * 0.50,
      height: height! * 0.05,
      child: TextField(
        controller: searchTextFieldcontroller,
        canRequestFocus: true,
        onTapOutside: (event) {
          Focus(child: backgroundWidget());
        },
        onSubmitted: (input) {
          homePageDataController.updateTextSearch(input);
        },
        style: const TextStyle(color: Colors.white),
        autocorrect: true,
        decoration: const InputDecoration(
          alignLabelWithHint: true,
          focusedBorder: border,
          border: border,
          prefixIcon: Icon(
            Icons.search,
            color: Colors.white54,
          ),
          hintStyle: TextStyle(
            color: Colors.white54,
          ),
          filled: false,
          fillColor: Colors.white24,
          hintText: 'Search Movie....',
        ),
      ),
    );
  }

  Widget categorySelectionWidget() {
    return DropdownButton(
      dropdownColor: Colors.black38,
      value: homePageModel.searchCategory,
      icon: const Icon(
        Icons.menu,
        color: Colors.white24,
      ),
      underline: Container(
        height: 1,
        color: Colors.white24,
      ),
      onChanged: (dynamic value) {
        value.toString().isNotEmpty
            ? homePageDataController.updateSearchCategory(value)
            : null;
      },
      items: const [
        DropdownMenuItem(
          value: SearchCategory.popular,
          child: Text(
            SearchCategory.popular,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        DropdownMenuItem(
          value: SearchCategory.upcoming,
          child: Text(
            SearchCategory.upcoming,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        DropdownMenuItem(
          value: SearchCategory.none,
          child: Text(
            SearchCategory.none,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget movieListViewWidget(WidgetRef ref) {
    final List<MoviesList> movies =
        ref.watch(homePageDataControllerProvider).movies!;

    if (movies.isNotEmpty) {
      return NotificationListener(
        onNotification: (dynamic onScrollNotification) {
          if (onScrollNotification is ScrollEndNotification) {
            final before = onScrollNotification.metrics.extentBefore;
            final end = onScrollNotification.metrics.maxScrollExtent;
            if (before == end) {
              ref.read(homePageDataControllerProvider.notifier).getMovies();
              return true;
            }
            return false;
          }
          return false;
        },
        child: ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: movies.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.symmetric(
                vertical: height! * 0.01,
                horizontal: 0,
              ),
              child: GestureDetector(
                onTap: () {
                  ref.read(selectedMoviePosterUrlProvider.notifier).state =
                      movies[index].posterURL();
                },
                child: MovieTile(
                  movie: movies[index],
                  height: height! * 0.20,
                  width: width! * 0.85,
                ),
              ),
            );
          },
        ),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
        ),
      );
    }
  }
}
