class ApiPaths {
  static String token;
  String slug;
  static String mainApi = "http://khadamatty.com/api";
  static String userDetails = mainApi + "/user";

  static String login = mainApi + "/login";
  static String signUp = mainApi + "/register";
  static String allCategoryApi = mainApi + "/servicescategory";

  static String updateProfile = mainApi + "/updateprofile";
  static String allServices = mainApi + "/allservices";
  static String randomUsers = mainApi + "/users";
  static String randomServices = mainApi + "/randomservices";

  static String servicescategory(int id) {
    return mainApi + "/servicescategory/$id";
  }

  static String singleService(int id) {
    return mainApi + "/services/${id.toString()}";
  }

  static String makeOrder = mainApi + "/makeorder";
}
