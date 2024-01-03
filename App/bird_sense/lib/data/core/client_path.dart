
enum ClientPath{
  birds,
  condition;

  const ClientPath();

  String get path {
    switch (this) {
      case ClientPath.birds:
        return 'v1/detections';
      case ClientPath.condition:
        return '';
    }
  }

   Uri get baseUri => Uri.https(
        'saving-crow-bursting.ngrok-free.app',
        '',
      );

  Uri getUri([String? query]) {
    if (query == null) {
      return Uri.https(
        baseUri.authority,
        path,
        baseUri.queryParameters,
      );
    }

    return Uri.https(
      baseUri.authority,
      ClientPath.birds.path,
      <String, dynamic>{...baseUri.queryParameters, 'after': query},
    );
  }
}