//sms:phoneNumber?body=message
class SmsModel {
  final String? phoneNumber;
  final String? message;
  SmsModel({this.phoneNumber, this.message});
}

class UrlModel {
  // final String? title;
  final String? url;

  UrlModel({this.url});
}

// tel:1234,123
class PhoneModel {
  final String? phoneNumber;

  PhoneModel({this.phoneNumber});
}

//mailto:name@gmail.com?cc=name2@gmail.com&bcc=name3@gmail.com&subject=The%20subject&body=The%20body
class EmailModel {
  final String? address;
  final String? cc;
  final String? bcc;
  final String? subject;
  final String? body;

  EmailModel({this.address, this.cc, this.bcc, this.subject, this.body});
}

//WIFI:T:WPA;S:ssid;P:sa;H:true
//WIFI:T:<authentication-type>;S:<network-ssid>;P:<network-password>;H:<hidden-network>;;
//- <authentication-type>: WPA or WPA2, WEP, nopass
//- <network-ssid>: name
//- <network-password>: pass
class WifiModel {
  final String? networkName;
  final String? password;
  final String? encryption;
  final bool? isHidden;

  WifiModel({this.networkName, this.password, this.encryption, this.isHidden});
}
