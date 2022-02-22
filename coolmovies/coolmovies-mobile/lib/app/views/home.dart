import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        builder: (QueryResult result, {fetchMore, refetch}) {
          if (result.hasException) {
            return Text(result.exception.toString());
          }
          if (result.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (result.data == null) {
            return const Center(child: Text('No data'));
          }

          // final allInfosData = result.data?["allMovies"]["nodes"][1]["title"];
          // print(allInfosData);

          return ListView.separated(
              itemCount: result.data!.length,
              separatorBuilder: (_, index) => const Divider(
                    color: Colors.black,
                  ),
              itemBuilder: (_, index) {
                return Center(
                  child: Text(
                    result.data!["allMovies"]["nodes"][index]["title"],
                  ),
                );
              });
        },
      ),
    );
  }
}
