import 'package:graphql/client.dart';

class Graphql {
  final GraphQLClient _graphql = GraphQLClient(
    link: HttpLink('https://rickandmortyapi.com/graphql'),
    cache: GraphQLCache(),
  );

  Future<QueryResult> getAllEpisodes({int page}) async {
    var result = await _graphql.query(QueryOptions(
      document: gql(
        r'''
        query getEpisodes($page: Int!) {
          episodes(page: $page) {
            results {
              id
              name
              episode
              air_date
            }
          }
        }
      ''',
      ),
      variables: {'page': page},
    ));
    return result;
  }

  Future<QueryResult> getEpisode({int id}) async {
    var result = await _graphql.query(QueryOptions(
      document: gql(
        r'''
        query getEpisode($id: ID!) {
          episode(id: $id) {
            id
            name
            air_date
            episode,
            characters {
              id
              name
              species
              status
              image
            }
          }
        }
      ''',
      ),
      variables: {'id': id},
    ));
    return result;
  }

  Future<QueryResult> getCharacter({int id}) async {
    var result = await _graphql.query(QueryOptions(
      document: gql(
        r'''
        query getCharacter($id: ID!) {
          character(id: $id) {
            id
            name
            gender
            species
            species
            type
            origin {
              name
            }
            location {
              name
            }
            image
            episode {
              name
              episode
            }
          }
        }
      ''',
      ),
      variables: {'id': id},
    ));
    return result;
  }
}
