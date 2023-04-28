void main(List<String> arguments) {
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
