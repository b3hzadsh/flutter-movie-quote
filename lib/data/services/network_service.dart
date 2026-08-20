// import 'package:dio/dio.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';

// class NetworkService {
//   final Dio dio;
//   final Connectivity connectivity;

//   NetworkService(this.dio, this.connectivity);

//   Future<bool> isIranianIp() async {
//     try {
//       final response = await dio.get('https://ipwho.is/');
//       return response.data['country_code'] == 'IR';
//     } catch (_) {
//       return false;
//     }
//   }

//   Future<bool> hasInternet() async {
//     final List<ConnectivityResult> results = await connectivity
//         .checkConnectivity();
//     return !results.contains(ConnectivityResult.none);
//   }
// }
