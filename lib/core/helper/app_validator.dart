class AppValidator{
  AppValidator._();

  static String? validateRequired(String? value){
    if(value!= null && value.isNotEmpty){
      return null;
    }
    return 'this field is required';
  }
}