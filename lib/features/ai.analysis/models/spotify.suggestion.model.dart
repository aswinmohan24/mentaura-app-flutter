class SpotifySuggestionsModel {
  final Playlist? playlist;
  final Podcast? podcast;
  SpotifySuggestionsModel({
    this.playlist,
    this.podcast,
  });

  factory SpotifySuggestionsModel.fromMap(Map<String, dynamic> map) {
    return SpotifySuggestionsModel(
      playlist: map['playlist'] != null
          ? Playlist.fromMap(map['playlist'] as Map<String, dynamic>)
          : null,
      podcast: map['podcast'] != null
          ? Podcast.fromMap(map['podcast'] as Map<String, dynamic>)
          : null,
    );
  }
}

class Playlist {
  final String name;
  final String spotifyUrl;
  final String thumbnail;
  final String description;
  Playlist(
      {required this.name,
      required this.spotifyUrl,
      required this.thumbnail,
      required this.description});

  factory Playlist.fromMap(Map<String, dynamic> map) {
    return Playlist(
      name: map['name'],
      spotifyUrl: map['url'],
      thumbnail: map['image'],
      description: map['description'],
    );
  }
}

class Podcast {
  final String name;
  final String spotifyUrl;
  final String thumbnail;
  final String description;
  final String publisher;
  Podcast(
      {required this.name,
      required this.spotifyUrl,
      required this.thumbnail,
      required this.description,
      required this.publisher});

  factory Podcast.fromMap(Map<String, dynamic> map) {
    return Podcast(
        name: map['name'],
        spotifyUrl: map['url'],
        thumbnail: map['image'],
        description: map['description'],
        publisher: map['publisher']);
  }
}
