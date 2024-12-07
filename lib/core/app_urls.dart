String accessToken = "";

Map<String, String>? headers = {
  "Content-Type": "application/json",
  "authorization": "Bearer"
};

AppUrls appUrls = AppUrls();

bool isDev = false;

class AppUrls {
  String networkUrl =
      isDev ? "http://192.168.1.62:4000/" : "http://13.202.85.86/";
  String middleUrl = "api/student/";
}

Uri baseUrl({required String endPoint}) {
  // String _baseUrl = "${appUrls.networkUrl}${appUrls.middleUrl}";
  String baseUrl = 'https://mcq.teqsuit.com/api/student/';
  return Uri.parse(baseUrl + endPoint);
}

String getImageUrl({required String endPoint}) {
  return "${appUrls.networkUrl}storage/$endPoint";
}
