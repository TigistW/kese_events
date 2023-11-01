class Validators{
      String? validateName(String? fullName) {
    RegExp regExp =
        RegExp(r"^[\w'\-,.][^0-9_!¡?÷?¿/\\+=@#$%ˆ&*(){}|~<>;:[\]]{2,}$");
    if (fullName?.length == 0) {
      return 'Field is required!';
    }
    if (!regExp.hasMatch(fullName!)) {
      return "Name must be Greater than 2";
    }
    return null;
  }

  String? validateNameString(String? name) {
    RegExp regExp =
        RegExp(r"^[\w'\-,.][^0-9_!¡?÷?¿/\\+=@#$%ˆ&*(){}|~<>;:[\]]{2,}$");
    if (name?.length == 0) {
      return 'Field is required!';
    }
    if (!regExp.hasMatch(name!)) {
      return "Name must be Greater than 2";
    }
    return null;
  }

  String? validateEmail(String? email) {
    if (email?.length == 0) {
      return 'Field is required!';
    }

    RegExp regExp =
        // RegExp(r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$');
        RegExp(r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$');

    if (!regExp.hasMatch(email!)) {
      return 'Invalid Email';
    }
    return null;
  }

  String? validateOTP(String? otpCode) {
    RegExp regExp = RegExp(r'^[0-9]{6}$');

    if (otpCode?.length == 0) {
      return 'Field is required!';
    }

    if (!regExp.hasMatch(otpCode!)) {
      return 'Invalid OTP!';
    }
    return null;
  }

  String? validatePhone(String? phone) {
    RegExp regExp = RegExp(r"(^(?:^[+])?[0-9]{9}$)");
    if (phone?.length == 0) {
      return 'Field is required!';
    }

    if (!regExp.hasMatch(phone!)) {
      return 'Invalid input!';
    }
    return null;
  }

  // validatePassword(String? value) {}

  String? validatePassword(String? password) {
    /*
      the below regex checks whether the password:
        * min length is 6
        * contains atleast one uppercase or lower_case letter
        * contains atleast one number
        * contains atleast one symbol
    */
    RegExp regExp =
    //     RegExp(r'^(?=.*?[A-Za-z])(?=.*?[0-9])(?=.*?[#?!@$%^+&*-]).{6,}$');
    RegExp(r'^.{4,}$');

    if (password!.isEmpty) {
      return 'Field is required!';
    }

    if (!regExp.hasMatch(password)) {
      return 'Weak Password!';
    }
    return null;
  }

  bool phoneNumberValidator(String value) {
    value = value.trim();
    if (!RegExp(r"(^(?:[0-9]{9}$))").hasMatch(value)) {
      // ^[+251])?
      return false;
    } else {
      return true;
    }
  }

  bool passwordValidator(String value) {
    value = value.trim();
    // if (!RegExp(r'^(?=.*?[A-Za-z])(?=.*?[0-9])(?=.*?[#?!@+$%^&*-]).{6,}$')
    //     .hasMatch(value))

    if (!RegExp(r'^.{4,}$')
        .hasMatch(value))
         {
      return false;
    } else {
      return true;
    }
  }

  bool emailValidator(String value) {
    value = value.trim();
    if (!RegExp(
            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
        .hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }

  String? validateConfirmPassword(String? password, String? confirmPassword) {
    if (password != confirmPassword) {
      return 'Password must match with Confirm password!';
    }
    return null;
  }
}