part of image_search;

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
 class Photo {
  num width, height;
  String ownerName;
  String photoFileUrl;
  var photoId;
  String title;
  
  PhotoFlickr(Map<String, dynamic> values) {
    this.photoId = values['photo_id'];
    this.width = values['width'];
    this.height = values['height'];
    this.ownerName = values['owner_name'];
    this.photoFileUrl = values['photo_file_url'];
    this.title = values['photo_title'];
  }
  
  toString() =>
     'Photo[$photoId, $ownerName, ${width}X${height}, $title, $photoFileUrl]';
}
