
import "dart:json";


main() {
  var data = parse(jsonPano);
  List<PhotoPano> photos = _parseJSONResponse(data);
  print("Done: $photos");

}

List<PhotoPano>_parseJSONResponse(Map<String, dynamic> data) {
  if (data.containsKey('count')) {
    if (data.containsKey('photos')) {
      List<Map<String, dynamic>> photos = data['photos'];
      return _extractPhotos(photos);
    }
  }
  return null;
}

List<PhotoPano> _extractPhotos(List<Map<String, dynamic>> photoValues) {
  List<PhotoPano> list = new List<PhotoPano>();
  for (Map<String, dynamic> photoValues in photoValues) {
    list.add(new PhotoPano(photoValues));
  }
  return list;
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


String jsonPano =
'''
{
  "count": 3296,
  "has_more": false,
  "map_location": {
    "lat": 37.225052,
    "lon": -3.2310273641083,
    "panoramio_zoom": 15
  },
  "photos": [
    {
      "height": 375,
      "latitude": 37.177195,
      "longitude": -3.585618,
      "owner_id": 6064321,
      "owner_name": "niteroi",
      "owner_url": "http://www.panoramio.com/user/6064321",
      "photo_file_url": "http://mw2.google.com/mw-panoramio/photos/medium/66150015.jpg",
      "photo_id": 66150015,
      "photo_title": "Vistas desde la Alhambra (dedicada a 'Ferlancor') - Views from the Alhambra ",
      "photo_url": "http://www.panoramio.com/photo/66150015",
      "upload_date": "04 February 2012",
      "width": 500
    },
    {
      "height": 333,
      "latitude": 37.204218,
      "longitude": 71.536102,
      "owner_id": 5999301,
      "owner_name": "Nodir_Tursun-Zade",
      "owner_url": "http://www.panoramio.com/user/5999301",
      "photo_file_url": "http://mw2.google.com/mw-panoramio/photos/medium/54282120.jpg",
      "photo_id": 54282120,
      "photo_title": "Colors of Gharm Chashma (Colors of Hot Spring) (by WWW.EY8MM.COM)",
      "photo_url": "http://www.panoramio.com/photo/54282120",
      "upload_date": "16 June 2011",
      "width": 500
    },
    {
      "height": 375,
      "latitude": 37.272909,
      "longitude": -76.702294,
      "owner_id": 3864530,
      "owner_name": "Chinappi",
      "owner_url": "http://www.panoramio.com/user/3864530",
      "photo_file_url": "http://mw2.google.com/mw-panoramio/photos/medium/63492277.jpg",
      "photo_id": 63492277,
      "photo_title": "Colonial Williamsburg - Parade (fifes and drums) dans Palace Green - To watch: http://www.youtube.com/watch?v=lMCepphfrQc",
      "photo_url": "http://www.panoramio.com/photo/63492277",
      "upload_date": "14 December 2011",
      "width": 500
    }
  ]
}
''';

