import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
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
            return ListView.separated(
                itemCount: result.data!.length,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                separatorBuilder: (_, index) => const Divider(
                      color: Colors.transparent,
                      height: 10,
                    ),
                itemBuilder: (_, index) {
                  return Center(
                    child: GestureDetector(
                      onTap: () => Navigator.pushNamed(_, "/details"),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(0),
                            padding: const EdgeInsets.all(0),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  result.data!["allMovies"]["nodes"][index]
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
                                ? const BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        Colors.black,
                                        Colors.transparent,
                                      ],
                                    ),
                                  )
                                : const BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        Colors.white,
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
                                result.data!["allMovies"]["nodes"][index]
                                    ["title"],
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
