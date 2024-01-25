import 'package:dio/dio.dart';

import 'package:retrofit/retrofit.dart';
import 'package:simple_example_retrofit/model/ads_model.dart';
import 'package:simple_example_retrofit/model/ads_request.dart';

part 'ads_api.g.dart';

@RestApi(baseUrl: 'https://qutb.uz/api')
abstract class AdsApi {
  factory AdsApi(Dio dio, {String baseUrl}) = _AdsApi;

  @POST('/ads')
  Future<Ads> getAds(@Body() AdsRequest adsRequest);
}
