// ignore_for_file: file_names

import 'package:entertainment/models/moviesList.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class MovieTile extends StatelessWidget {
  final GetIt getIt = GetIt.instance;

  final double? height;
  final double? width;
  final MoviesList? movie;

  MovieTile({
    this.movie,
    super.key,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        moviePosterWidget(
          movie!.posterURL().toString(),
        ),
        movieInfoWidget(),
      ],
    );
  }

  Widget movieInfoWidget() {
    return SizedBox(
      height: height,
      width: width! * 0.70,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: width! * 0.52,
                child: Text(
                  movie!.name!,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Text(
                movie!.rating.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, height! * 0.02, 0, 0),
            child: Text(
              '${movie!.language!.toUpperCase()} | R: ${movie!.isAdult} | ${movie!.releaseDate}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(0, height! * 0.07, 0, 0),
              child: SingleChildScrollView(
                child: Text(
                  movie!.description!,
                  softWrap: true,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget moviePosterWidget(String imageURL) {
    if (imageURL.isNotEmpty) {
      return Container(
        height: height,
        width: width! * 0.35,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              imageURL,
            ),
          ),
        ),
        child: Image.network(imageURL),
      );
    } else {
      return Container();
    }
  }
}
