class Episode {
  final int id;
  final String name;
  final String episode;
  final String airDate;
  final bool watched;
  final bool liked;

  Episode({
    this.id,
    this.name,
    this.episode,
    this.airDate,
    this.watched,
    this.liked,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'episode': episode,
      'airDate': airDate,
      'watched': watched ? 1 : 0,
      'liked': liked ? 1 : 0,
    };
  }
}
