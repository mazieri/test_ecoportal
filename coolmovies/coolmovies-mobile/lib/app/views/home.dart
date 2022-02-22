import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    var themeSystem = Theme.of(context).brightness;

    print(themeSystem);

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
          errorPolicy: ErrorPolicy.none,
        ),
        builder: (result, {fetchMore, refetch}) {
          if (result.hasException) {
            print("error");
            return Text(result.exception.toString());
          }
          if (result.isLoading) {
            print("loading");
            return const Center(child: CircularProgressIndicator());
          }
          if (result.data == null) {
            print("no data");
            return const Center(child: Text('No data'));
          }

          // final allInfosData = result.data?["allMovies"]["nodes"][1]["title"];
          // print(allInfosData);

          return ListView.separated(
              itemCount: result.data!.length,
              separatorBuilder: (_, index) => const Divider(
                    color: Colors.transparent,
                    height: 10,
                  ),
              itemBuilder: (_, index) {
                return Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      image: DecorationImage(
                        image: NetworkImage(
                          result.data!["allMovies"]["nodes"][index]["imgUrl"],
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    width: double.infinity,
                    height: h * 0.8,
                    child: Container(
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
                  ),
                );
              });
        },
      ),
    );
  }
}

// Text(
//                     result.data!["allMovies"]["nodes"][index]["title"],
//                   ),

// Stack(
//                       children: const [
//                         Align(
//                           alignment: Alignment(0, 0),
//                           child: Text(
//                             "Movie Title",
//                             style: TextStyle(
//                                 fontSize: 30,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white),
//                           ),
//                         )
//                       ],
//                     ),