class Api {
  static const String authority = 'www.thecocktaildb.com';
  static const String path = '/api/json/v1/1';
  static const String search = '$path/search.php';
  static const String list = '$path/list.php';
  static const String filter = '$path/filter.php';
  static const String lookup = '$path/lookup.php';
  static String getImgUrl(String ingredient) {
    final urlify = ingredient.replaceAll(' ', '%20');
    return 'https://www.thecocktaildb.com/images/ingredients/$urlify-Small.png';
  }
}