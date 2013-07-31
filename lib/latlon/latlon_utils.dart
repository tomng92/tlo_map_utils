
part of latlon_utils;

/**
 * Utilities manipulating the lat&lon, bounding box computation, etc.
 *   - lines of constant longitude are meridian (pole to pole)
 *   - lines of constant latitude are parallels (paralle to the equator)
 *
 * thanh - june 23 2013. 
 */

class LatLonUtils {
  
  static const EARTHRADIUS =  6371000; // in kilometers.
  static const MAXLATITUDE =  85; // deltaLongitude will not work at the Poles. So we 
  
  /**
   * Compute the square bounding box at a given position.
   * Returns an array of 4 floats lat1, lon1, lat2, lon2. ([Float32List] in typed_data seems good to use for this.)
   * [distanceSpanned] is in kilometers.
   *
   * "Since the circumference of the Earth is roughly 25,000 miles,
   *  the length of each degree of latitude is about 111km ( 1/360 of 25,000 miles).
   *  (approx as earth is not perfect sphere.)
   *  The length of a degree of longitude, however, varies from about 69 miles at the equator
   *  to zero at the poles, where the meridians come together."
   * 
   *
   *  Longitude ranges from 180 to -180 degree ('western hemisphere').
   *  Latitude ranges from 90 to -90 degree  ('southern hemisphere').
   *
   *  +-----------------+ <-- Output: top left
   *  |                 |
   *  |                 |
   *  |                 |
   *  |        +        | <-- Input: our position [lat] & [lon].
   *  |                 |
   *  |                 |
   *  |                 |
   *  +-----------------+ <-- Output: bottom right
   * 
   * Resources:
   *  - convert min deg secs to decimal: 
   *     1) http://andrew.hedges.name/experiments/convert_lat_long/
   *     2) http://answers.yahoo.com/question/index?qid=20090115174952AAHR72i .. nice my friend
   */
  static List<LatLon> getBoundingBox(num lat, num lon, {num distanceSpanned: 1000}) {
    num delLat = LatLonUtils._deltaLatitude(distanceSpanned);
    num delLon = LatLonUtils.deltaLongitude(lat, distanceSpanned);
    return [new LatLon(lat - delLat/2, lon - delLon/2), new LatLon(lat - delLat/2, lon - delLon/2)];
  }
  
  /**
   * Returns the longitude angle covering the given distance.
   * 
   * See http://en.wikipedia.org/wiki/Longitude at the section 'Length of a degree of longitude'.
   * `
   * The formula is (assuming the earth is perfect sphere):
   *   delta-longitude = PI/180
   *    LenCircle  = length of circle at a latitude Lat : 2Pi * EarthRadius * sin (90 - Lat) = Pi * EarthRadius * cos (Lat)
   *    LenPerDegree = LenCircle / 360
   *    DelLon = LenPerDegree / size 
   *    
   *    For testing purpose:
   */
  static num deltaLongitude(num latitude, num distanceSpanned) {// should private but just for testing purpose
    
    /**
     * If we are near the Poles, clamp latitude to 85degree
     */
    latitude = Math.min(_mathAbs(latitude), MAXLATITUDE); 
    
    num latitudeRadians = latitude * Math.PI / 180;
    
    num lenCircle = 2 * Math.PI * EARTHRADIUS * Math.cos(latitudeRadians);
    num lenPerDegree = lenCircle / 360;
    return lenPerDegree / distanceSpanned;
  }
  
  
  
  /**
   * Returns the latitude angle covering the given distance.
   */
  static num _deltaLatitude(num distanceSpanned) {
    const num lenPerDegree = 111000; // 110.574km at equator to 111.694km at poles
    return lenPerDegree / distanceSpanned;
  }
  
  /**
   * Absolute fct (that should be in Math library).
   */
  static num _mathAbs(num val) {
    return val > 0 ? val : -val;
  }
  
}