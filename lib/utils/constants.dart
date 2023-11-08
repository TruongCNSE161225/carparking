abstract class Constants {
  static String baseUrl = 'https://api.fpt-ec.click/parkx/api/v1/app/';
  static String baseUrlAuth = 'https://api.fpt-ec.click/parkx/api/v1/auth/';
  static String baseUrlMedia = 'https://api.fpt-ec.click/parkx/api/v1/media/';
  static String baseUrlImage = 'https://api.fpt-ec.click/parkx';

  static Map<String, String> header(String token) {
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  static Map<String, String> headerMedia() {
    return {
      'Content-Type': 'multipart/form-data',
      'Accept': 'application/json',
    };
  }
}
