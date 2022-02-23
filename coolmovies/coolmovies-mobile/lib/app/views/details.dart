import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class DetailsPage extends StatelessWidget {
  final int i;
  const DetailsPage({Key? key, required this.i}) : super(key: key);

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
        currentUser {
          id
          name
        }
      }
      """;

    const newReviewMutation = """
  mutation {
  createMovieReview(input: {
    movieReview: {
      title: "blah blah blah",
      body: "eu fazendo um teste",
      rating: 1,
      movieId: "70351289-8756-4101-bf9a-37fc8c7a82cd",
      userReviewerId: "beb2473b-2c31-44a2-81e3-01efd5c7ac6e"
    }})
  {
    movieReview {
      id
      title
      body
      rating
      movieByMovieId {
        title
      }
      userByUserReviewerId {
        name
      }
    }
  }
}
""";

// void _removeReview(context, )

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text("Your Moview Review"),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.done),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.cancel_outlined),
                ),
              ],
              content: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Review Title",
                ),
                onChanged: (value) {
                  print(value);
                },
              ),
            ),
          );
          // Mutation(options: MutationOptions(document: gql(newReviewMutation)), builder: builder);
        },
        child: const Icon(
          Icons.edit_note,
          size: 50,
        ),
        backgroundColor:
            themeSystem == Brightness.dark ? Colors.white : Colors.black,
        foregroundColor:
            themeSystem == Brightness.dark ? Colors.black : Colors.white,
      ),
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
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Stack(
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
                                  result.data!["allMovies"]["nodes"][i]
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
                            SizedBox(
                              height: h * 0.8,
                              child: Align(
                                alignment: const Alignment(0, 0.925),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      result.data!["allMovies"]["nodes"][i]
                                              ["movieDirectorByMovieDirectorId"]
                                          ["name"],
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.majorMonoDisplay(
                                        fontSize: h * 0.025,
                                        fontWeight: FontWeight.bold,
                                        color: themeSystem == Brightness.dark
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const Icon(Icons.star),
                                        Text(
                                          //TODO: arrumar o rating
                                          {
                                            result.data!["allMovies"]["nodes"][i]
                                                        ["movieReviewsByMovieId"]
                                                    ["nodes"][0]["rating"] +
                                                result.data!["allMovies"]
                                                                    ["nodes"][i]
                                                                ["movieReviewsByMovieId"]
                                                            ["nodes"][0]
                                                        ["rating"] ~/
                                                    result.data!["allMovies"]
                                                                ["nodes"][i]
                                                            ["movieReviewsByMovieId"]
                                                        ["totalCount"]
                                          }.toString(),
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.majorMonoDisplay(
                                            fontSize: h * 0.025,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                themeSystem == Brightness.dark
                                                    ? Colors.white
                                                    : Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: h * 0.8,
                              child: Align(
                                alignment: const Alignment(0, 1),
                                child: Text(
                                  result.data!["allMovies"]["nodes"][i]
                                      ["title"],
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.majorMonoDisplay(
                                    fontSize: h * 0.02,
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
                        SizedBox(
                          width: double.infinity,
                          height: h / 2,
                          child: Align(
                            alignment: const Alignment(-1, -0.9),
                            child: ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder()),
                              child: Icon(
                                Icons.arrow_left_outlined,
                                size: 50,
                                color: themeSystem == Brightness.dark
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     // print(result.data!["allMovies"]["nodes"][i]
                    //     //         ["movieReviewsByMovieId"]["nodes"][0]
                    //     //     ["rating"]);
                    //     // print(result.data!["allMovies"]["nodes"][i]
                    //     //         ["movieReviewsByMovieId"]["nodes"][1]
                    //     //     ["rating"]);
                    //     // print(result.data!["allMovies"]["nodes"][i]
                    //     //         ["movieReviewsByMovieId"]["nodes"][2]
                    //     //     ["rating"]);
                    //     for (var d = 0; //esse for deu certo pra pegar as rating das reviews
                    //         d <
                    //             result
                    //                 .data!["allMovies"]["nodes"][i]
                    //                     ["movieReviewsByMovieId"]["nodes"]
                    //                 .length;
                    //         d++) {
                    //       // print(d);
                    //       print(result.data!["allMovies"]["nodes"][i]
                    //               ["movieReviewsByMovieId"]["nodes"][d]
                    //           ["rating"]);
                    //     }

                    //     // print(result.data!["allMovies"]["nodes"][i]
                    //     //             ["movieReviewsByMovieId"]["nodes"][0]
                    //     //         ["rating"] +
                    //     //     result.data!["allMovies"]["nodes"][i]
                    //     //             ["movieReviewsByMovieId"]["nodes"][1]
                    //     //         ["rating"] +
                    //     //     result.data!["allMovies"]["nodes"][i]
                    //     //                 ["movieReviewsByMovieId"]["nodes"]
                    //     //             [2]["rating"] /
                    //     //         result.data!["allMovies"]["nodes"][i]
                    //     //             ["movieReviewsByMovieId"]["totalCount"]);
                    //   },
                    //   child: Text("ausasuhsauh"),
                    // ),
                    Divider(
                      thickness: 2,
                      // height: h * 0.0,
                      color: themeSystem == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                    Text(
                      "Movie Reviws",
                      style: GoogleFonts.lato(
                        fontSize: h * 0.04,
                        color: themeSystem == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    const Divider(
                      color: Colors.transparent,
                    ),
                    Column(
                      children: [
                        for (var d =
                                0; //esse for deu certo pra pegar as rating das reviews
                            d <
                                result
                                    .data!["allMovies"]["nodes"][i]
                                        ["movieReviewsByMovieId"]["nodes"]
                                    .length;
                            d++)
                          Card(
                            child: SizedBox(
                              width: double.infinity,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            result.data!["allMovies"]["nodes"]
                                                            [i]
                                                        [
                                                        "movieReviewsByMovieId"]
                                                    ["nodes"][d][
                                                "userByUserReviewerId"]["name"],
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.lato(
                                              fontSize: h * 0.03,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  themeSystem == Brightness.dark
                                                      ? Colors.white
                                                      : Colors.black,
                                            ),
                                          ),
                                          Text(
                                            result.data!["allMovies"]["nodes"]
                                                    [i]["movieReviewsByMovieId"]
                                                    ["nodes"][d]["rating"]
                                                .toString(),
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.lato(
                                              fontSize: h * 0.03,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  themeSystem == Brightness.dark
                                                      ? Colors.white
                                                      : Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Divider(),
                                      Text(
                                        result.data!["allMovies"]["nodes"][i]
                                                ["movieReviewsByMovieId"]
                                            ["nodes"][d]["title"],
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.lato(
                                          fontSize: h * 0.03,
                                          fontWeight: FontWeight.bold,
                                          color: themeSystem == Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Text(
                                          result.data!["allMovies"]["nodes"][i]
                                                  ["movieReviewsByMovieId"]
                                              ["nodes"][d]["body"],
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.lato(
                                            fontSize: h * 0.02,
                                            color:
                                                themeSystem == Brightness.dark
                                                    ? Colors.white
                                                    : Colors.black,
                                          ),
                                        ),
                                      ),
                                      const Divider(
                                        color: Colors.transparent,
                                      ),
                                      result.data!["currentUser"]["id"] ==
                                              result.data!["allMovies"]["nodes"]
                                                          [i]
                                                      ["movieReviewsByMovieId"]
                                                  ["nodes"][d]["userReviewerId"]
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () {},
                                                  child: SizedBox(
                                                    width: w / 3,
                                                    child:
                                                        const Icon(Icons.edit),
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    var reviewID = result
                                                        .data!["allMovies"]
                                                            ["nodes"][i][
                                                            "movieReviewsByMovieId"]
                                                            ["nodes"][d]["id"]
                                                        .toString();

                                                    var deleteReview = """
                                                          mutation {
                                                            deleteMovieReviewById(input: {
                                                              id: "$reviewID",
                                                              clientMutationId: "delete"}
                                                            )
                                                            {
                                                              movieReview {
                                                                id
                                                              }
                                                            }
                                                          }""";

                                                    print("apagando");
                                                    print(deleteReview);
                                                    print(reviewID);

                                                    Mutation(
                                                      options: MutationOptions(
                                                        document:
                                                            gql(deleteReview),
                                                      ),
                                                      builder:
                                                          (runMutation, done) {
                                                        return const AlertDialog();
                                                      },
                                                    );

                                                    // Mutation(
                                                    //   options: MutationOptions(
                                                    //     document:
                                                    //         gql(deleteReview),
                                                    //   ),
                                                    //   builder: (MultiSourceResult Function(
                                                    //               Map<String,
                                                    //                   dynamic>,
                                                    //               {Object?
                                                    //                   optimisticResult})
                                                    //           runMutation,
                                                    //       QueryResult? result) {
                                                    //     return const AlertDialog();
                                                    //   },
                                                    // );
                                                  },
                                                  child: SizedBox(
                                                    width: w / 3,
                                                    child: const Icon(
                                                        Icons.delete_forever),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : const SizedBox(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                );
              },
            );
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
