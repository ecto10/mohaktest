import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/captcha_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();
  final CaptchaService _captchaService = CaptchaService();
  bool _isLoading = false;
  bool _captchaVerified = false;

  Future<void> _verifyCaptcha() async {
    setState(() => _isLoading = true);
    try {
      _captchaVerified = await _captchaService.verifyCaptcha();
      if (!_captchaVerified) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please verify you are not a robot')),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _signInWithGoogle() async {
    if (!_captchaVerified) {
      await _verifyCaptcha();
      if (!_captchaVerified) return;
    }

    setState(() => _isLoading = true);
    try {
      await _authService.signInWithGoogle();
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error signing in: ${e.toString()}')),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _signInWithFacebook() async {
    if (!_captchaVerified) {
      await _verifyCaptcha();
      if (!_captchaVerified) return;
    }

    setState(() => _isLoading = true);
    try {
      await _authService.signInWithFacebook();
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error signing in: ${e.toString()}')),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue[400]!,
              Colors.blue[800]!,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: _isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.lock_outline,
                        size: 100,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 50),
                      const Text(
                        'Welcome Back!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Sign in to continue',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 30),
                      if (!_captchaVerified)
                        ElevatedButton.icon(
                          icon: const Icon(Icons.security),
                          label: const Text('Verify CAPTCHA'),
                          onPressed: _verifyCaptcha,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black87,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        icon: Image.asset(
                          'assets/images/google_logo.png',
                          height: 24.0,
                        ),
                        label: const Text('Sign in with Google'),
                        onPressed: _captchaVerified ? _signInWithGoogle : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black87,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        icon: Image.asset(
                          'assets/images/facebook_logo.png',
                          height: 24.0,
                        ),
                        label: const Text('Sign in with Facebook'),
                        onPressed: _captchaVerified ? _signInWithFacebook : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1877F2),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}