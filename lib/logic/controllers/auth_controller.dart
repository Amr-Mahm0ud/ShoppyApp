import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:shoppy/bindings/welcome_binding.dart';
import 'package:shoppy/utils/consts.dart';
import 'package:shoppy/utils/keys.dart';
import 'package:http/http.dart' as http;
import 'package:shoppy/view/screens/home/main_screen.dart';
import 'package:shoppy/view/screens/welcome.dart';

import '../../bindings/main_binding.dart';

class AuthController extends GetxController {
  @override
  void onInit() {
    userName = _authStorage.read('userName');
    userImage = _authStorage.read('userImage');
    phoneNum = _authStorage.read('phoneNum');
    token = _authStorage.read('tokenKey');
    userId = _authStorage.read('idKey');
    userEmail = _authStorage.read('email');
    expiryDate = _authStorage.read('expiryKey') == null
        ? null
        : DateTime.parse(_authStorage.read('expiryKey'));
    super.onInit();
  }

//personal info
  RxInt selectedImage = 0.obs;
  String? userImage;
  String? userName;
  String? phoneNum;

  updateInfo({String? name, String? image, String? phone}) {
    userImage = image;
    userName = name;
    phoneNum = phone;
    _authStorage.write('userName', name);
    _authStorage.write('userImage', image);
    _authStorage.write('phoneNum', phone);
  }

  //authentication variables
  String? token;
  DateTime? expiryDate;
  String? userId;
  String? userEmail;
  Timer? authTimer;
  final GetStorage _authStorage = GetStorage();

  //animation variables
  bool obscure = true;
  bool acceptTerms = false;
  bool isLoading = false;

  //loadingAnimation
  animateLoading() {
    isLoading = !isLoading;
    update();
  }

  //logic of visibilty
  changeVisibility() {
    obscure = !obscure;
    update();
  }

  //logic of checkbox
  changeAcceptTerms() {
    acceptTerms = !acceptTerms;
    update();
  }

  saveAuthData(resBody) {
    token = resBody['idToken'];
    userId = resBody['localId'];
    userEmail = resBody['email'];
    expiryDate = DateTime.now().add(
      Duration(
        seconds: int.parse(resBody['expiresIn']),
      ),
    );
    _authStorage.write('tokenKey', token);
    _authStorage.write('idKey', userId);
    _authStorage.write('email', userEmail);
    _authStorage.write('expiryKey', expiryDate!.toIso8601String());
    update();
  }

  logout() {
    token = null;
    userId = null;
    expiryDate = null;
    _authStorage.remove('tokenKey');
    _authStorage.remove('userImage');
    _authStorage.remove('userName');
    _authStorage.remove('phoneNum');
    _authStorage.remove('idKey');
    _authStorage.remove('expiryKey');
    if (authTimer != null) {
      authTimer!.cancel();
      authTimer = null;
    }
    Get.offAll(
      () => const WelcomeScreen(),
      binding: WelcomeBinding(),
      transition: Transition.circularReveal,
    );
  }

  autoLogout() {
    if (authTimer != null) {
      authTimer!.cancel();
    }
    final timeToExpiry = expiryDate!.difference(DateTime.now()).inSeconds;
    authTimer = Timer(Duration(seconds: timeToExpiry), logout);
    update();
  }

  Future<bool> _authenticate({
    required String email,
    required String password,
    required String urlSign,
  }) async {
    try {
      Uri url = Uri.parse(
          'https://identitytoolkit.googleapis.com/v1/accounts:$urlSign?key=${AppKeys.authKey}');
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final resBody = json.decode(response.body);
      if (response.statusCode == 200) {
        saveAuthData(resBody);
        autoLogout();
        return true;
      } else {
        Consts.errorSnackBar(resBody['error']['message']);
        return false;
      }
    } catch (error) {
      Consts.errorSnackBar(error.toString());
      return false;
    }
  }

  signUp({
    required email,
    required password,
  }) async {
    if (await _authenticate(
      email: email,
      password: password,
      urlSign: 'signUp',
    )) {
      Get.off(
        () => const MainScreen(),
        transition: Transition.size,
        binding: MainBinding(),
      );
    }
  }

  login({
    required email,
    required password,
  }) async {
    if (await _authenticate(
      email: email,
      password: password,
      urlSign: 'signInWithPassword',
    )) {
      Get.off(
        () => const MainScreen(),
        transition: Transition.size,
        binding: MainBinding(),
      );
    }
  }

  bool tryAutoLogin() {
    if (token != null &&
        expiryDate != null &&
        expiryDate!.isAfter(DateTime.now())) {
      autoLogout();
      return true;
    } else {
      return false;
    }
  }

  sendPasswordResetEmail(String email) async {
    try {
      animateLoading();
      Uri url = Uri.parse(
          'https://identitytoolkit.googleapis.com/v1/accounts:sendOobCode?key=${AppKeys.authKey}');
      final response = await http.post(
        url,
        body: {
          'requestType': 'PASSWORD_RESET',
          'email': email,
        },
      );
      final resBody = json.decode(response.body);
      if (response.statusCode == 200) {
        animateLoading();
        Get.back();
        Consts.successSnackBar(
          title: 'Email sent',
          body: Lottie.asset(
            'assets/lotties/email_sent.json',
            height: Get.height * 0.15,
            repeat: false,
            onLoaded: (_) {},
          ),
          duration: const Duration(milliseconds: 1500),
        );
      } else {
        animateLoading();
        Consts.errorSnackBar(resBody['error']['message']);
      }
    } catch (error) {
      animateLoading();
      Consts.errorSnackBar(error.toString());
    }
  }
}
