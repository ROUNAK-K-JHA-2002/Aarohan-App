import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';



class Eurekoin{

  static User currentUser=FirebaseAuth.instance.currentUser;    static final String baseUrl = "https://eurekoin.nitdgplug.org";static int userEurekoin;
   static String userReferralCode; static var transHistory;

  // Future _getUser() async {
  //
  //   print(user);
  //
  //     currentUser = user;
  //
  //   isEurekoinUserRegistered();
  // }

  static Future fetchLeaderboard() async {

    String url = "https://eurekoin.nitdgplug.org/api/leaderboard/";
    http.Response response = await http.get(Uri.parse(url));
    List<dynamic> dataList = json.decode(response.body);

    print(dataList);
    return dataList;

  }
  static Future<int> transferEurekoin(String amount, String transferTo) async {
    await dotenv.load(fileName: ".env");
    var bytes = utf8.encode("${currentUser.providerData[0].email}" + "${dotenv.env['LOGIN_KEY']}");
    var encoded = sha1.convert(bytes);
    String apiUrl =
        "https://eurekoin.nitdgplug.org/api/transfer/?token=$encoded&amount=$amount&email=$transferTo";
    print(apiUrl);
    http.Response response = await http.get(Uri.parse(apiUrl));
    print(response.body);
    var status = json.decode(response.body)['status'];
    return int.parse(status);
  }
 static Future  getReferralCode() async {
   await dotenv.load(fileName: ".env");

   var email = currentUser.providerData[0].email;
    var bytes = utf8.encode("$email" + "${dotenv.env['LOGIN_KEY']}");
    var encoded = sha1.convert(bytes);
    String apiUrl =
        "https://eurekoin.nitdgplug.org/api/invite_code/?token=$encoded";
    http.Response response = await http.get(Uri.parse(apiUrl));
    print(response.body);
    var referralCode = json.decode(response.body)['invite_code'];

   return referralCode;

  }
 static Future getAllUsers(String email) async {

      String apiUrl =
          "https://eurekoin.nitdgplug.org/api/users/?pattern=$email";
      http.Response response = await http.get(Uri.parse(apiUrl));
      print(response.body);
      return json.decode(response.body)['users'];

  }

 static Future getUserEurekoin() async {
   await dotenv.load(fileName: ".env");

   var email = currentUser.providerData[0].email;
    var bytes = utf8.encode("$email" + "${dotenv.env['LOGIN_KEY']}");
    var encoded = sha1.convert(bytes);
    String apiUrl = "https://eurekoin.nitdgplug.org/api/coins/?token=$encoded";
    http.Response response = await http.get(Uri.parse(apiUrl));
    print(response.body);
    var status = json.decode(response.body)['coins'];
    return status;
  }
  static Future isEurekoinUserRegistered() async {
    await dotenv.load(fileName: ".env");

    var email = currentUser.providerData[0].email;
    var bytes = utf8.encode("$email" + "${dotenv.env['LOGIN_KEY']}");
    var encoded = sha1.convert(bytes);
    String apiUrl = "$baseUrl/api/exists/?token=$encoded";
    http.Response response = await http.get(Uri.parse(apiUrl));
    var status = json.decode(response.body)['status'];
     print(status);

    return status;

  }
  static Future<List> suggestionListBuilder(String email) async {
    if (email != '') {
      String apiUrl =
          "https://eurekoin.nitdgplug.org/api/users/?pattern=$email";
      http.Response response = await http.get(Uri.parse(apiUrl));
      print(response.body);
      return json.decode(response.body)['users'];
    }
  }

  static Future transactionsHistory() async {
    await dotenv.load(fileName: ".env");

    var email = currentUser.providerData[0].email;
    var bytes = utf8.encode(email + "${dotenv.env['LOGIN_KEY']}");
    var encoded = sha1.convert(bytes);

    String apiUrl =
        "https://eurekoin.nitdgplug.org/api/history/?token=$encoded";
    print(apiUrl);
    http.Response response = await http.get(Uri.parse(apiUrl));

      transHistory = json.decode(response.body)['history'];
      print(transHistory);
      return transHistory;

  }
  static Future<int> couponEurekoin(String coupon) async {
    await dotenv.load(fileName: ".env");


    var email = currentUser.providerData[0].email;
    var bytes = utf8.encode(""+email + '${dotenv.env['LOGIN_KEY']}');

    var encoded = sha1.convert(bytes);
    print(encoded.toString());
    String apiUrl =
        "https://eurekoin.nitdgplug.org/api/coupon?token=$encoded&code=$coupon";
    print(apiUrl);
    http.Response response = await http.get(Uri.parse(apiUrl));
    print(response.statusCode);
    var status = json.decode(response.body)['status'];

    return int.parse(status);
  }


  static Future registerEurekoinUser(var referalCode) async {
   print("NKJBJB");
    var email = currentUser.providerData[0].email;
    var name = currentUser.providerData[0].displayName;

    String apiUrl =
        "$baseUrl/api/register?name=$name&email=$email&referred_invite_code=$referalCode&image=${currentUser.providerData[0].photoURL}";
    http.Response response = await http.get(Uri.parse(apiUrl));
    print(response.statusCode);
    var status = jsonDecode(response.body)['status'];
    print("status = $status");
    if (status == '0') {
      getUserEurekoin();
    }
      return status;
  }
}