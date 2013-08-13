part of latlon_utils;

/**
 * Used as a bounding box.
 * thanh july 
 * 31, 2013
 */
class Rectangle {
  final LatLon p1;
  final LatLon p2;
  Rectangle(this.p1, this.p2);
  toString() => 'rect($p1, $p2)';
}