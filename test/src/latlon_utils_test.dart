
part of latlon_utils_test_lib;

/**
 * Testing latlon utils.
 * 
 * thanh june 23, 2013.
 */
void runTests() {
  group('--Main test group---', () {
    //setUp(setupTest)

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
      //assert (dellon > lowerBound && dellon < upperBound);
      assert(withinOurTestBounds(dellon, 1.0));
      //expect(dellon, )
      
      /**
       * Verify at 45degree latitude.
       */
      dellon = LatLonUtils.deltaLongitude(45.0, 78847); // at 45degree latitude, 
      //assert (dellon > lowerBound && dellon < upperBound);
      assert(withinOurTestBounds(dellon, 1.0));
    });
    
    /**
     * External functions
     */
    test('Test library public functions', () {
      /**
       * Test the 
       */
      LatLon[] boundingbox = LatLonUtils.ge(lat, lon, 1000);
    });
  });
  
}
/**
 * Return true if our testValue falls within expectedValue bounds.
 */
bool withinOurTestBounds(num testValue, num expectedValue) {
  new MyFloatMatcher(myname:'tom');
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



}