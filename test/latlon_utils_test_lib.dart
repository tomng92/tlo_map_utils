library latlon_utils_test_lib;

import 'package:tlo_map_utils/latlon_utils_lib.dart';
import 'package:unittest/unittest.dart';

part 'src/latlon_test.dart';
part 'src/latlon_utils_test.dart';

main() {
  //useVMConfiguration();
  runLatLonTests();
  runLatLonUtilsTests();
}