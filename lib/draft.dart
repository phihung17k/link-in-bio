// ignore_for_file: avoid_print

void main(List<String> arguments) {
  //link
  //https: //developer.android.com/guide/components/intents-common.html#java
  //https: //developer.android.com/reference/android/content/Intent#ACTION_SEND
  //https://developer.android.com/reference/android/Manifest.permission#SEND_SMS
  ///

  // console.printUri("https://www.facebook.com/phihung17k");
  printUri("sms:12321sad 43241?21321");
  Uri uri = Uri(scheme: "sms", path: "12321sad 43241", query: "213123");
  print(uri.toString());
}

void printUri(String url) {
  Uri uri = Uri.parse(url);

  print("uri.authority: ${uri.authority}");
  print("uri.data: ${uri.data}");
  print("uri.fragment ${uri.fragment}");
  print("uri.host ${uri.host}");
  print("uri.isAbsolute ${uri.isAbsolute}");

  //Origin is only applicable to schemes http and https
  if (uri.scheme.startsWith("http")) {
    print("uri.origin ${uri.origin}");
  }
  print("uri.path ${uri.path}");
  print("uri.pathSegments ${uri.pathSegments}");
  print("uri.port ${uri.port}");
  print("uri.query ${uri.query}");
  print("uri.queryParameters ${uri.queryParameters}");
  print("uri.queryParametersAll ${uri.queryParametersAll}");
  print("uri.scheme ${uri.scheme}");
  print("uri.userInfo ${uri.userInfo}\n");
}

/// To install the same app with a different version in Flutter, 
/// you can use the following steps:
/// 1. Update the version number in the pubspec.yaml file of your Flutter project. 
///   The version number is specified under the "version" field.
///   version: 1.0.0+1
/// 
/// 2. In the terminal, navigate to the project directory and run the following
///   command to update the dependencies: flutter packages get
///
/// 3. Build the app using the following command: flutter build apk
///
/// 4. Install the new version of the app: flutter install --apk <path-to-apk>
///
/// 5. If you want to keep the previous version of the app on your device, 
///    you can change:
/// <application android:label="new_name" android:name="${applicationName}" android:icon="@mipmap/ic_launcher">
/// 1.android/app/src/debug/AndroidManifest.xml
//2.android/app/src/main/AndroidManifest.xml
//3.android/app/src/profile/AdroidManifest.xml
//4.buildgradle file defaultConfig { applicationId ""}
//5.MainActivity.java on "package" OR MainActivity.kotlin