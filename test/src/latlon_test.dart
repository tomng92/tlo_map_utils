

part of latlon_utils_test_lib;


runLatLonTests() {
  test("LatLon tests", () {
        
    // regular case
    LatLon limits = new LatLon(33, 100);
    assert(limits.lat == 33);
    assert(limits.lon == 100);

    // at bounds
    LatLon normal = new LatLon(90, 180);
    assert(normal.lat == 90);
    assert(normal.lon == 180);

    // over the bounds
    LatLon exceedlimitslatLon = new LatLon(-100, 200);
    assert(exceedlimitslatLon.lat == -80);
    assert(exceedlimitslatLon.lon == -160);

    // lets add 360
    LatLon exceedlimitslatLon2 = new LatLon(-100 - 360, 200 + 360);
    assert(exceedlimitslatLon2.lat == -80);
    assert(exceedlimitslatLon2.lon == -160);

    // at negative bounds
    LatLon exceedlimitslatLon3 = new LatLon(-90, -180);
    assert(exceedlimitslatLon3.lat == -90);
    assert(exceedlimitslatLon3.lon == -180);

    LatLon exceedlimitslatLon4 = new LatLon(360, 360);// should convert to zero for both lat lon.
    assert(exceedlimitslatLon4.lat == 0);
    assert(exceedlimitslatLon4.lon == 0);


  });
}