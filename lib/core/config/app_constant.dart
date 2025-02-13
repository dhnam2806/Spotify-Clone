class AppConstant {
  static const String clientId = '04150fb2ac8f42fab2982c8445848251';
  static const String clientSecret = 'e5ca036807d245f99a59fa00d3f075f9';
}

RegExp emailRexExp = RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$');

RegExp passwordRexExp =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$');

RegExp specialCharRexExp = RegExp(r'^(?=.*?[!@#$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^])');
