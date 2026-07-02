import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

import 'api_result.dart';

Future<ApiResults<T>> safeCall<T>(Future<ApiResults<T>> Function() call) async {
  try {
    return call();
  } on TimeoutException catch (e) {
    return Failure(e.toString(), e);
  } on DioException catch (e) {
    return Failure(e.toString(), e);
  } on IOException catch (e) {
    return Failure(e.toString(), e);
  } catch (e) {
    return Failure(e.toString(), e as Exception);
  }
}
