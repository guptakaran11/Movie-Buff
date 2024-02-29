// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: must_be_immutable

import 'dart:ui';

import 'package:entertainment/models/moviesList.dart';
import 'package:entertainment/models/searchCategory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  double? height;
  double? width;

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
    searchTextFieldcontroller = TextEditingController();
    return buildUI();
  }

  Widget buildUI() {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        height: height,
        width: width,
        child: Stack(
          alignment: Alignment.center,
          children: [
            backgrouondWidget(),
            foregroundWidgets(),
          ],
        ),
      ),
    );
  }

  Widget backgrouondWidget() {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          10.0,
        ),
        image: const DecorationImage(
          image: NetworkImage(
            'https://img00.deviantart.net/ebb2/i/2017/243/0/d/godzilla_by_tatianamakeeva-db1d5c6.png',
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
  }

  Widget foregroundWidgets() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, height! * 0.02, 0, 0),
      width: height! * 0.88,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          topBarWidget(),
          Container(
            height: height! * 0.83,
            padding: EdgeInsets.symmetric(
              vertical: height! * 0.01,
            ),
            child: movieListViewWidget(),
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
        onSubmitted: (input) {},
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          focusedBorder: border,
          border: border,
          prefixIcon: Icon(
            Icons.search,
            color: Colors.white24,
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
      value: SearchCategory.popular,
      icon: const Icon(
        Icons.menu,
        color: Colors.white24,
      ),
      underline: Container(
        height: 1,
        color: Colors.white24,
      ),
      onChanged: (value) {},
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

  Widget movieListViewWidget() {
    final List<MoviesList> movies = [];

    for (var i = 0; i < 20; i++) {
      movies.add(
        MoviesList(
          name: "Mortal Kombat",
          language: "EN",
          isAdult: false,
          description: "A fantastic game",
          posterPath: "/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg",
          backDropPath: "/hZkgoQYus5vegHoetLkCJzb17zJ.jpg",
          rating: 7.8,
          releaseDate: "07-01-2024",
        ),
      );
    }

    if (movies.isNotEmpty) {
      return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.symmetric(
                vertical: height! * 0.01,
              ),
              child: GestureDetector(
                onTap: () {},
                child: Text(movies[index].name),
              ),
            );
          });
    } else {
      return const Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
        ),
      );
    }
  }
}
