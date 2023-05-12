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
