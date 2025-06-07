const KDictionaryBox = 'dictionaryBox';
const KSavedwordsBox = 'SavedwordsBox';

class ApiUrls {
  //static const baseURL = "http://10.0.2.2:3000";
  static const baseURL = 'http://127.0.0.1:5000';
  static const imageBaseURL = 'http://127.0.0.1:5000/static/';


  static const login = "$baseURL/api/auth/login";
  static const register = "$baseURL/api/auth/register";
  static const getAllLevels = "$baseURL/api/level";
  static const sectionById = "$baseURL/api/section";
  static const allQuestion = "$baseURL/api/question";
 
}
String fixImageUrl(String url) {
  return url.replaceAll("http://localhost:3000", "http://192.168.1.10:3000");
}