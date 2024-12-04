# Flutter Social Media Login App - Version test1.0

A mobile application demonstrating social media login functionality with CAPTCHA verification using Flutter.

## New Features in test1.0
- Added Google reCAPTCHA v3 integration
- CAPTCHA verification before social login
- Enhanced security measures
- Updated UI with CAPTCHA verification button

## Features
- Google Sign In
- Facebook Sign In
- Firebase Authentication
- CAPTCHA Verification
- Modern UI Design

## Setup

1. Configure Firebase in your project
2. Add Google Sign In credentials
3. Configure Facebook Developer App
4. Set up Google reCAPTCHA v3:
   - Get your site key from Google reCAPTCHA admin console
   - Update the siteKey in lib/services/captcha_service.dart

## Running the App

```bash
flutter pub get
flutter run
```

## Project Structure

- lib/
  - main.dart (App entry point)
  - screens/
    - login_screen.dart (Login UI)
  - services/
    - auth_service.dart (Authentication logic)
    - captcha_service.dart (CAPTCHA verification)

## Dependencies

- firebase_auth
- google_sign_in
- flutter_facebook_auth
- firebase_core
- g_recaptcha_v3
- webview_flutter