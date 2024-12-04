import 'package:g_recaptcha_v3/g_recaptcha_v3.dart';

class CaptchaService {
  static const String siteKey = 'YOUR_RECAPTCHA_SITE_KEY';
  
  Future<bool> verifyCaptcha() async {
    try {
      final token = await GRecaptchaV3.execute(siteKey, 'login');
      // Here you would typically verify the token with your backend
      // For demo purposes, we'll return true if token is not null
      return token != null && token.isNotEmpty;
    } catch (e) {
      print('CAPTCHA verification failed: $e');
      return false;
    }
  }
}