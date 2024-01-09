
enum ClientPath{
  birds,
  condition,
  birdsSort;


  const ClientPath();

  String get path {
    switch (this) {
      case ClientPath.birds:
        return 'v1/detections';
      case ClientPath.condition:
        return '';
      case ClientPath.birdsSort:
        return 'v1/stats/detections-by-species';


    }
  }

   Uri get baseUri => Uri.http(
        '130.61.154.206:8000',
        '',
      );

  Uri getUri(String? after, String? before, String? devEUI) {
      if (after == null) {
      return Uri.http(
        baseUri.authority,
        path,
        baseUri.queryParameters,
      );
      
    }
     return Uri.http(
      baseUri.authority,
      ClientPath.birds.path,
      <String, dynamic>{...baseUri.queryParameters, 'after': after, 'before': before, 'devEui': devEUI },
    );
  }

   Uri getUriSorted(String? after, String? before, String? devEUI) {
    if (after == null) {
      return Uri.http(
        baseUri.authority,
        path,
        baseUri.queryParameters,
      );
    }

    return Uri.http(
      baseUri.authority,
      ClientPath.birdsSort.path,
      <String, dynamic>{...baseUri.queryParameters, 'after': after, 'before': before, 'devEui': devEUI },
    );
  }
}