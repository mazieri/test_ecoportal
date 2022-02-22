import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class DetailsPage extends StatelessWidget {
  final int i;
  const DetailsPage({Key? key, required this.i}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    var themeSystem = Theme.of(context).brightness;

    const allInfosQuery = """query allInfos {
        allMovies {
          totalCount
          pageInfo {
            hasNextPage
            hasPreviousPage
          }
          nodes {
            id
            imgUrl
            movieDirectorByMovieDirectorId {
              name
            }
            title
            releaseDate
            movieReviewsByMovieId {
              totalCount
              nodes {
                id
                title
                rating
                body
                userReviewerId
                userByUserReviewerId {
                  name
                }
              }
            }
          }
        }
      }
      """;

    return Scaffold(
      body: Query(
        options: QueryOptions(
          document: gql(allInfosQuery),
        ),
        builder: (result, {fetchMore, refetch}) {
          if (result.hasException) {
            return const Center(
              child: Text(
                "Network Error",
              ),
            );
          }
          if (result.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (result.data == null) {
            return const Center(
              child: Text('No data'),
            );
          }
          if (result.isConcrete) {
            return ListView.builder(
                itemCount: 1,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                itemBuilder: (_, index) {
                  return Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          _,
                          "/details",
                          arguments: result,
                        );
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(0),
                            padding: const EdgeInsets.all(0),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  result.data!["allMovies"]["nodes"][i]
                                      ["imgUrl"],
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            width: double.infinity,
                            height: h * 0.795,
                          ),
                          Container(
                            height: h * 0.8,
                            width: double.infinity,
                            decoration: themeSystem == Brightness.dark
                                ? BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        Colors.black,
                                        Colors.black.withOpacity(0.75),
                                        Colors.transparent,
                                      ],
                                    ),
                                  )
                                : BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        Colors.white,
                                        Colors.white.withOpacity(0.75),
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                          ),
                          SizedBox(
                            height: h * 0.8,
                            child: Align(
                              alignment: const Alignment(0, 0.75),
                              child: Text(
                                result.data!["allMovies"]["nodes"][i]["title"],
                                textAlign: TextAlign.center,
                                style: GoogleFonts.majorMonoDisplay(
                                  fontSize: h * 0.06,
                                  fontWeight: FontWeight.bold,
                                  color: themeSystem == Brightness.dark
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          } else {
            return const Center(
              child: Text(
                "Big Problem",
              ),
            );
          }
        },
      ),
    );
  }
}


// Container(
//                             height: h * 0.8,
//                             width: double.infinity,
//                             decoration: themeSystem == Brightness.dark
//                                 ? BoxDecoration(
//                                     gradient: LinearGradient(
//                                       begin: Alignment.bottomCenter,
//                                       end: Alignment.topCenter,
//                                       colors: [
//                                         Colors.black,
//                                         Colors.black.withOpacity(0.75),
//                                         Colors.transparent,
//                                       ],
//                                     ),
//                                   )
//                                 : BoxDecoration(
//                                     gradient: LinearGradient(
//                                       begin: Alignment.bottomCenter,
//                                       end: Alignment.topCenter,
//                                       colors: [
//                                         Colors.white,
//                                         Colors.white.withOpacity(0.75),
//                                         Colors.transparent,
//                                       ],
//                                     ),
//                                   ),
//                           ),