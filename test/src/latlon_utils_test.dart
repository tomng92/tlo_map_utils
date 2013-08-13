
part of latlon_utils_test_lib;

/**
 * Testing latlon utils.
 * 
 * thanh june 23, 2013.
 */
void runLatLonUtilsTests() {
  group('--Main test group---', () {
    //setUp(setupTest)
    
    String aaa = 'eee';
    aaa.substring(0,0).toLowerCase().

    /**
     * Internal functions
     */

    test('Test library internal functions', () {
      //group('Basic tests') 
    
      /**
       * Verify that we clamp at 85 degree latitude (cannot go higher)
       * http://en.wikipedia.org/wiki/Longitude (see the table at 'Length of a degree of longitude'.)
       */
      num dellon85 = LatLonUtils.deltaLongitude(LatLonUtils.MAXLATITUDE, 1000);
      num dellon85Minus = LatLonUtils.deltaLongitude(-LatLonUtils.MAXLATITUDE, 1000);
      num dellon88 = LatLonUtils.deltaLongitude(88.0, 1000);
      num dellon90 = LatLonUtils.deltaLongitude(90.0, 1000);
      assert (dellon85 == dellon85Minus && dellon85 == dellon88 && dellon88 == dellon90);  
      
      /**
       * Verify at equator.
       */
      num dellon = LatLonUtils.deltaLongitude(0, 111000); // see wikipedia/longitude for the 111km value. 
      assert(withinOurTestBounds(dellon, 1.0));
      
      /**
       * Verify at 45degree latitude.
       */
      dellon = LatLonUtils.deltaLongitude(45.0, 78847); // at 45degree latitude, 
      assert(withinOurTestBounds(dellon, 1.0));
    });
    
    /**
     * External functions.
     */
    test('Test my add lat lon functions', () {
      
      
      
      /**
       * 
       * Test getBoundingBox at various points.
       */
      
      //Rectangle boundingbox = LatLonUtils.getBoundingBox(lat, lon, 1000);
      //print(boundingbox);
      
    });
  });
  
}

/**
 * Source for this table: http://en.wikipedia.org/wiki/Longitude.
 * 
 *  DeltaLat = length of a degree of latitude (segment direction is north south)
 *  DeltaLon =   ''      ''          longitude (segment direction is east west)
 * Lat  DeltaLat   DeltaLon
 * ---  ---------  ---------
 * 0°  110.574 km  111.320 km
 * 15° 110.649 km  107.551 km
 * 30° 110.852 km  96.486 km
 * 45° 111.132 km  78.847 km
 * 60° 111.412 km  55.800 km
 * 75° 111.618 km  28.902 km
 * 90° 111.694 km  0.000 km
 */
class LatLonTestData {
  LatLon pos;
  Rectangle bbOf1000m;
  LatLonTestData(this.pos, this.bbOf1000m);
 // var dataAt_0 = new LatLonTestData(new LatLon(0, 0), new Rectangle(p1, p2));
}

/**
 * Return true if our testValue falls within expectedValue bounds.
 */
bool withinOurTestBounds(num testValue, num expectedValue) {
  //new MyFloatMatcher(myname:'tom');
  return testValue > (expectedValue - 0.01) && testValue < (expectedValue + 0.01);
}

/**
class MyFloatLimitMatcher extends BaseMatcher {
  //final name;
  MyFloatMat
  cher({this.name);
    
  
  bool matches(item, Map matchState) {
    return true;
  }

  
  /**
   * Creates a textual description of a matcher,
   * by appending to [mismatchDescription].
   */
  Description describe(Description mismatchDesc) {
    mismatchDesc.add("Mismatch"
    
    
  }
 
*/


