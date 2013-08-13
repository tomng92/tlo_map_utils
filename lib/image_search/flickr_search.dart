/**
 *
 *  This "library" exposes a few classes and methods
 *  that implement the "flickr.photo.search" Flickr service
 *  (only implements JSON for the request format and response format).
 *
 *  TODO:
 *  If this where a real library, it would probably
 *  be separated in several "parts":
 *  (see http://www.flickr.com/services/api/)
 *  For example: request_formats, response_formats and
 *  api_methods (with all its objects ...)
 *  Improve the usage of Streams.
 */
part of image_search;


const String NO_JSON_CALLBACK = '&nojsoncallback=1';
const String REST_ENDPOINT = 'http://api.flickr.com/services/rest/?format=json&method=';
const String STAT_FAIL = 'fail';
const String STAT_OK = 'ok';

// Photo constants
const int SQUARE_PHOTO  =   0;
const int THUMBNAIL_PHOTO = 1;
const int SMALL_PHOTO =     2;
const int MEDIUM_PHOTO =    3;
const int BIG_PHOTO =       4;

const String SQUARE_SUFFIX =    's';
const String THUMBNAIL_SUFFIX = 't';
const String SMALL_SUFFIX =     'm';
const String MEDIUM_SUFFIX =    '-';
const String BIG_SUFFIX =       'b';


/**
 * Contains info about a photo
 */
class PhotoFlickr {
  String id, owner, secret, title;
  String server; 
  int farm, ispublic, isfriend, isfamily;

  String url([int type = 4]) {
    var url, suffix;
    switch (type) {
      case SQUARE_PHOTO:
        suffix = SQUARE_SUFFIX;
        break;
      case THUMBNAIL_PHOTO:
        suffix = THUMBNAIL_SUFFIX;
        break;
      case SMALL_PHOTO:
        suffix = SMALL_SUFFIX;
        break;
      case MEDIUM_PHOTO:
        suffix = MEDIUM_SUFFIX;
        break;
      case BIG_PHOTO:
        suffix = BIG_SUFFIX;
        break;
    }
    return 'http://farm${farm}.static.flickr.com/${server}/${id}_${secret}_${suffix}.jpg';
  }

  PhotoFlickr.fromMap(Map<String, dynamic> map) {
    if (map.containsKey('id')) id = map['id']; 
    if (map.containsKey('owner'))  owner = map['owner'];
    if (map.containsKey('secret')) secret = map['secret'];
    if (map.containsKey('title'))  title = map['title'];
    if (map.containsKey('server')) server = map['server'];
    if (map.containsKey('farm')) farm = map['farm'];
    if (map.containsKey('ispublic')) ispublic = map['ispublic'];
    if (map.containsKey('isfriend')) isfriend = map['isfriend'];
    if (map.containsKey('isfamily')) isfamily = map['isfamily'];
  }
}

/**
 * Thanh's pavaju api key on Flickr:
 * Trippolo
 * Key: d28c9193354c280b2b32f9e08acfbb87
 * Secret: 96db101212299a95
 */
class FlickrSearch {
  String apiKey; // = 'd28c9193354c280b2b32f9e08acfbb87';// for trippolo app on Flicker
  

  FlickrSearch(String this.apiKey);

 
  String _buildUrl(String method) {
    assert(this.apiKey != null);
    return '${REST_ENDPOINT}${method}&api_key=${apiKey}';
  }



  /**
   * Returns a stream of photos.
   */
  Completer myCompleter;
  
  Future<List<PhotoFlickr>> searchByLatLonUsingFuture(String lat, String lon, int radius) {
    var url = '${_buildSearchUrl(lat, lon, radius)}';
    var req = new HttpRequest();
    
    myCompleter = new Completer();
    
    
    req.onReadyStateChange.listen(_onReadyStateChange2);
    req.onError.listen(_onError);
    req.open('GET', url);
    req.send();
    return myCompleter.future;
  }

  void _onError(ProgressEvent event) {
    // TODO: Improve this, add an error to the stream
  }

  
  void _onReadyStateChange2(ProgressEvent event) { 
    HttpRequest req = event.target;
    
    print('${event.loaded}% complete');
    
    /**
     * When done we parse the response
     */
    if (req.readyState == HttpRequest.DONE && req.status == 200) {
      var data = parse(req.responseText);
      List<PhotoFlickr> photos = _parseResponse2(data);
      if (photos != null) {
        myCompleter.complete(photos);
      } else {
        myCompleter.completeError(new Exception("no result found!"));
      }
    }
  }

  List<PhotoFlickr> _parseResponse2(Map<String, dynamic> data) {
     if (data.containsKey('stat')) {
      if (data['stat'] == STAT_OK) {
        if (data.containsKey('photos')) {
          var photos = data['photos'];
          if (photos.containsKey('photo')) {

            var it = photos['photo'].iterator;
            var photoList = [];
            var photo;
            while (it.moveNext()) {
              photo = new PhotoFlickr.fromMap(it.current);
              photoList.add(photo);
            }

              return photoList;
           } 
        }
      } else {
        return null;
      }
    }
    return null;
  }
 
  
  String _buildSearchUrl(String lat, String lon, int radius) {
    /**
     * See http://www.flickr.com/services/api/flickr.photos.search.html
     * geo_context = 2 -> outdoors
     */
    return '${_buildUrl("flickr.photos.search")}&lat=$lat&lon=$lon&radius=$radius&has_geo=1${NO_JSON_CALLBACK}';
    
  }

}
