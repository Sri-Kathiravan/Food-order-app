# Food Order App - Product list

A new product listing application developed on flutter. App contains three different screens and some bottom sheets.

1) [Login Screen](/example/screenshots/1_login.png) - To get phone number.
2) [Verification Screen](/example/screenshots/2_verify_otp.png) - To verify the phone number using otp.
3) [Home Screen](/example/screenshots/4_home_screen.png) - To list all the products.
3) [Location selection](/example/screenshots/5_location_switch.png) - To select the location.
3) [Logout](/example/screenshots/7_logout.png) - To logout. 

Please find an APK file in *example/apk* directory to install and verify. I've attached my screenshots and screen recordings in *example/screenshots* directory.


### Example
- [App flow: Screen recording](/example/screenshots/screen_recording.mp4)

### Note

I've spent around 4-5  hours to complete this and I've not given more importance to animations. Just attempted to develop best possible UI (Given screenshot) and operations.

Please find an screen recordings in *example/screenshots* directory.

In this app I've used some libraries from [pub.dev](https://pub.dev/)

- [Http Interceptor: To make HTTP requests](https://pub.dev/packages/http_interceptor)
- [Toast: To Show Toast message](https://pub.dev/packages/fluttertoast)
- [BLoC: For state management](https://pub.dev/packages/flutter_bloc)
- [Package Info: To get package related details](https://pub.dev/packages/package_info). This can be implemented without this package. To reduce the the time, I've used this.
- [Device Info: To get device id](https://pub.dev/packages/device_info). This can be implemented without this package. To reduce the the time, I've used this.

## Getting Started

To run this Project, execute the following commands:

1. **flutter pub get** - This command gets all the dependencies and assets listed in the pubspec.yaml file in the current working directory.
2. **flutter run** - To run this Flutter app on a connected device or simulator.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
