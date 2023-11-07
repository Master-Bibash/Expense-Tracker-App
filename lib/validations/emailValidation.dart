bool isEmailValid(String email) {
  final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
  return emailRegExp.hasMatch(email);
}


class EmailValidation{
  static validateRmail(String emailAdd){
    if (emailAdd.isEmpty){
      return "This field is required";
  }else if(isEmailValid(emailAdd)==true){
    return null;
  }else{
    return "Enter a valid email";
  }
}
}