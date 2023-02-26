//form error

// ignore_for_file: constant_identifier_names, valid_regexps
final RegExp nameValidatoRegExp = RegExp(
    r"^(?=[a-zA-ZÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶẸẺẼỀỀỂẾưăạảấầẩẫậắằẳẵặẹẻẽềềểếỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ\s\W|_]{5,20}$)(?!.*[_.]{2})[^_.].*[^_.]$");
final RegExp emailValidatoRegExp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
final RegExp phoneValidatoRegExp =
    RegExp(r"((^(\+84|84|0|0084){1})(3|5|7|8|9))+([0-9]{8})$");
final RegExp passwrodValidatoRegExp =
    RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$");
const String KEmailNullError = "Vui lòng nhập email";
const String KInvalidEmailError = "Vui lòng nhập email hợp lệ";
const String KPhoneNullError = "Vui lòng điền số điện thoại của bạn";
const String KInvalidPhoneError = "Vui lòng số điện thoại hợp lệ (10 chữ số)";
const String KPassNullError = "Vui lòng hãy điền mật khẩu";
const String KShortPassError = "Mật khẩu ngắn";
const String KMatchPassError = "Mật khẩu không khớp";
const String KComfirmPassNull = "Vui lòng nhập xác nhận mật khẩu";
const String KPhoneNumberNullError = "Vui lòng điền số điện thoại của bạn";
const String KAddressNullError = "Vui lòng nhập địa chỉ của bạn";
const String KInvalidNameError = "Tên không được chứa ký tự đặc biệt";
const String KNameNullError = "Vui lòng hãy nhập tên của bạn";
const String KNameLengthError = "Tên phải có từ 5 đến 20 ký tự";
const String KInvalidPasswordError =
    "Mật khẩu phải chứa ít nhất\n 1 chữ viết hoa,\n 1 chữ thường,\n 1 số và 1 kí tự đặc biệt";
