/**
 * See http://www.panoramio.com/api/data/api.html
 * thanh june 10 2013
 */
part of image_search;


class PanoramioSearch {
  
  /**
   * Returns a stream of photos from Panoramio.
   */
  Completer myCompleter;
  
  Future<List<PhotoFlickr>> search(num lat, num lon, int radius, int nbPerPage, Function onError) {
    
    var url = '${_buildSearchUrl(lat, lon, radius, nbPerPage)}';
    var req = new HttpRequest();
    
    myCompleter = new Completer();
       
    req.onReadyStateChange.listen(_onReadyStateChange);
    req.onError.listen(_onError);
    req.open('GET', url);
    req.send();
    return myCompleter.future;// return to our caller.
  }

  /**
   * Callback called when the result comes back.
   */
  void _onReadyStateChange(ProgressEvent event) { 
    HttpRequest req = event.target;
    
    print('${event.loaded}% complete');
    
    /**
     * When done we parse the response
     */
    if (req.readyState == HttpRequest.DONE && req.status == 200) {
      Map<String, dynamic> data = parse(req.responseText);
      List<PhotoPano> photos = _parseJSONResponse(data);
      if (photos != null) {
        myCompleter.complete(photos);
      } else {
        myCompleter.completeError(new Exception("no result found!"));
      }
    }
  }

  /**
   * Parse the given json response.
   * {
   *
   *   {
   *     "count": 3296,
   *     "has_more": false,
   *     "map_location": {
   *       "lat": 37.225052,
   *       "lon": -3.2310273641083,
   *       "panoramio_zoom": 15
   *     },
   *     "photos": [
   *       {
   *         "height": 375,
   *         "latitude": 37.177195,
   *         "longitude": -3.585618,
   *         "owner_id": 6064321,
   *         "owner_name": "niteroi",
   *         "owner_url": "http:\/\/www.panoramio.com\/user\/6064321",
   *         "photo_file_url": "http:\/\/mw2.google.com\/mw-panoramio\/photos\/medium\/66150015.jpg",
   *         "photo_id": 66150015,
   *         "photo_title": "Vistas desde la Alhambra (dedicada a \"Ferlancor\") - Views from the Alhambra ",
   *         "photo_url": "http:\/\/www.panoramio.com\/photo\/66150015",
   *         "upload_date": "04 February 2012",
   *         "width": 500
   *       },
   *       ...
   *   }
   *
   */

List<PhotoPano>_parseJSONResponse(Map<String, dynamic> data) {
  if (data.containsKey('count')) {
    if (data.containsKey('photos')) {
      List<Map<String, dynamic>> photos = data['photos'];
      return _extractPhotos(photos);
    }
  }
  return null;
}

/**
 * Extract photos from a list of maps. Called from _parseJSONResponse(). 
 */
List<PhotoPano> _extractPhotos(List<Map<String, dynamic>> photoValues) {
  List<PhotoPano> list = new List<PhotoPano>();
  for (Map<String, dynamic> photoValues in photoValues) {
    list.add(new PhotoPano(photoValues));
  }
  return list;
}

 
  
  void _onError(ProgressEvent event) {
    // TODO: Improve this, add an error to the stream
  }

  
  /**
   * Build the search url. 
   * http://www.panoramio.com/api/data/api.html
   * Tested example: http://www.panoramio.com/map/get_panoramas.php?order=popularity&set=full&from=0&to=10&minx=-3.59&miny=37.17&maxx=-3.79&maxy=37.37&size=medium
   * 
   * 
   * 
   * 
   */
  String _buildSearchUrl(num lat, num lon, int radius, int nbPerPage) {
    /**
     * See http://www.flickr.com/services/api/flickr.photos.search.html
     * geo_context = 2 -> outdoors
     */
    
    int minY = lat - 0.2;
    int maxY = lat + 0.2;
    int minX = lon - 0.4;
    int maxX = lon + 0.4;
    return 'http://www.panoramio.com/map/get_panoramas.php?order=popularity&set=full&from=0&to=${nbPerPage}&size=medium'
      + '&minx=$minX&miny=$minY&maxx=$maxX&maxy=$maxY';
    
  }
}

/**
 * Fragment of json of one photo: 
 *  "height": 375,
 *  "latitude": 37.177195,
 *  "longitude": -3.585618,
 *  "owner_id": 6064321,
 *  "owner_name": "niteroi",
 *  "owner_url": "http:\/\/www.panoramio.com\/user\/6064321",
 *  "photo_file_url": "http:\/\/mw2.google.com\/mw-panoramio\/photos\/medium\/66150015.jpg",
 *  "photo_id": 66150015,
 *  "photo_title": "Vistas desde la Alhambra (dedicada a \"Ferlancor\") - Views from the Alhambra ",
 *  "photo_url": "http:\/\/www.panoramio.com\/photo\/66150015",
 *  "upload_date": "04 February 2012",
 *  "width": 500
 *
 */
 class PhotoPano {
  num width, height;
  String ownerName;
  String photoFileUrl;
  var photoId;
  String title;
  
  PhotoPano(Map<String, dynamic> values) {
    this.photoId = values['photo_id'];
    this.width = values['width'];
    this.height = values['height'];
    this.ownerName = values['owner_name'];
    this.photoFileUrl = values['photo_file_url'];
    this.title = values['photo_title'];
  }
  
  toString() =>
     'PhotoPano[$photoId, $ownerName, ${width}X${height}, $title, $photoFileUrl]';
}





