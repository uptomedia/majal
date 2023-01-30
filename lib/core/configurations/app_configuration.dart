import 'package:intl/intl.dart';

class AppConfigurations {
  static const String ApplicationName = 'lila';
  //
  static const String BaseUrl = 'https://test-leela-api.azurewebsites.net/api/';
  static const String BaseIdentityUrl =
      'https://test-leela-identity.azurewebsites.net/api/';

  // static const String BaseUrl = 'https://cert-leela-api.azurewebsites.net/api/';
  // static const String BaseIdentityUrl =
  //     'https://cert-leela-identity.azurewebsites.net/api/';
  static const String BaseImagesUrl = 'https://jsonplaceholder.typicode.com/';

  static const Map<String, String> BaseHeaders = {
    "accept": "text/plain",
    //  "Content-Type": "application/json",
  };

  static const GOOGLE_MAP_KEY = 'AIzaSyAB0E9skzggsaitNGRklPMlUydmYlpLBG8';

  /// formats
  static DateFormat appDisplayDateFormat = DateFormat('dd/MM/yyyy', 'en');
  static DateFormat appDisplayDateOfBirth = DateFormat('dd-MM-yyyy', 'en');
  static DateFormat appDisplayDateTimeFormat =
      // DateFormat('dd/MM/yyyy hh:mm aa ','en');
      DateFormat('dd/MM/yyyy   HH:mm  ', 'en');
  static DateFormat appointmentApiDateTimeFormat =
      DateFormat("E,d LLL yyyy HH:mm:ss", 'en'); // "Tue,13 Jul 2021 00:00:43 ",
  static DateFormat appointmentApiTimeFormat = DateFormat("HH:mm"); // "00:00",
  static DateFormat profileDateFormat =
      DateFormat("yyyy-MM-dd", 'en'); // "00:00",
  static DateFormat appointmentDateFormat =
      //DateFormat("yyyy-MM-dd hh:mm aa",'en');// "00:00",
      DateFormat("yyyy-MM-dd HH:mm ", 'en'); // "00:00",
  static DateFormat appointmentCreateApiDateTimeFormat =
      DateFormat("yyyy-MM-ddTHH:mm:ss", 'en');
  static DateFormat dayDispalyApiDateTimeFormat =
      DateFormat("E,d LLL yyyy", 'en');
  static DateFormat hourDispalyApiDateTimeFormat = DateFormat("HH:mm", 'en');
}
