part of latlon_utils;

/**
 * LatLon of points.
 *
 * thanh. jul 2013
 * updated 12 Aug 2013.
 */
class LatLon {
  final num lat;
  final num lon;
    
  // lat should be between [-90, 90] and lon [-180, 180].
  LatLon(latval, lonval) : this._internall(_fixLatLimits(latval), _fixLonLimits(lonval));
  
  LatLon._internall(this.lat, this.lon);
  
  toString() => 'latlon($lat, $lon)';

  /**
   * Recursive fct to make in limits.
   * Example,
   *  - For lat: 95    ==return==> 85 (180 - 95)
   *  - For lat: -100  ==return==> -80 (-180 + 100)
   *  - For lon: 200   ==return==> -160 (-360 + 200)
   *  - For lon: -200  ==return==> 160 (360 -200)
   */
  static num _fixLatLimits(num value) =>
      value > 90 ? _fixLatLimits(180 - value) : value < -90 ? _fixLatLimits(-180 - value) : value;
      
  static num _fixLonLimits(num value) =>
      value > 180 ? _fixLonLimits(-360 + value) : value < -180 ? _fixLonLimits(360 + value) : value;
      
  
}