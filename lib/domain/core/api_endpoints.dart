import 'package:netflix/core/constants.dart';
import 'package:netflix/infrastructure/api_key.dart';

class EndPoint {
  static const String downloads = "${baseurl}3/trending/all/day?api_key=$apiKey";
  static const String search = "${baseurl}3/search/movie?api_key=$apiKey";
}
