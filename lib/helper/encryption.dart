import 'dart:convert';

String generateEncodedApiKey(String input){
  Codec<String, String> stringToBase64 = utf8.fuse(base64);
  print(stringToBase64.encode(input));
 return stringToBase64.encode(input);
}
// eyJhdXRoUHJvdmlkZXIiOiJHTUFJTCIsImF1dGhVc2VySWQiOiIxMDQ4OTMzNDM1OTY5NDcwMzUyODAifQ==