const KDictionaryBox = 'dictionaryBox';
const KSavedwordsBox = 'SavedwordsBox';

class ApiUrls {
  //static const baseURL = "http://10.0.2.2:3000";
  static const baseURL = 'http://192.168.1.10:3000';

  static const getGoldList = "$baseURL/api/golds";
  static const getHomeList = "$baseURL/api/times";
  static const getAllCurrencies = "$baseURL/api/currencies";
 
}
String fixImageUrl(String url) {
  return url.replaceAll("http://localhost:3000", "http://192.168.1.10:3000");
}