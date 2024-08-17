
# Flutter Firebase Authentication

This is a Flutter project demonstrating Firebase Authentication using phone number and OTP verification.

## Project Overview

This application provides a simple implementation of phone number authentication using Firebase. It includes a login screen where users can enter their phone number, receive an OTP, and verify it to access the home screen.

## Features

- Phone number authentication
- OTP verification
- Simple home screen with logout functionality

## Project Structure

- `main.dart`: The entry point of the application. It initializes Firebase and sets up the app theme.
- `login_screen.dart`: Handles the phone number input and OTP verification process.
- `home_screen.dart`: A simple home screen displayed after successful authentication, with a logout option.

## Setup

1. Clone the repository:
   ```
   git clone https://github.com/dudhathardik/firebase_authentication.git
   ```

2. Install dependencies:
   ```
   flutter pub get
   ```

3. Set up Firebase:
   - Create a new Firebase project in the Firebase Console
   - Add your Android and iOS apps to the Firebase project
   - Download and add the `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS) to the respective folders in your Flutter project
   - Enable Phone Number sign-in method in the Firebase Console under Authentication > Sign-in method

4. Run the app:
   ```
   flutter run
   ```

## Dependencies

- firebase_core: ^1.10.0
- firebase_auth: ^3.3.0
- flutter: sdk: flutter

## Usage

1. Launch the app
2. Enter your phone number with country code (e.g., +91xxxxxxxxxx)
3. Press "Send" to receive OTP
4. Enter the OTP received
5. Press "Verify" to authenticate

After successful authentication, you'll be redirected to the Home Screen. You can log out using the floating action button.


## License

This project is open source and available under the [MIT License](LICENSE).

