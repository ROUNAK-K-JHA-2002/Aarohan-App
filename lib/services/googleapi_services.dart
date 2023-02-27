import "package:googleapis_auth/auth_io.dart";
import 'package:googleapis/calendar/v3.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:io' show Platform;

 const _scopes = const [CalendarApi.calendarScope];


var _credentials;

class GoogleApi_Services {
   initEvent(String date,String name)async {

     await dotenv.load(fileName: ".env");

    if (Platform.isAndroid) {
      _credentials = new ClientId(
          dotenv.env['OAUTH_ID'],
          "");
    }
    Event event = Event(); // Create object of event
    event.summary = name;

    final start = DateTime.parse(date);
    print(date);
    // final end = DateTime.parse('2022-02-14 13:30:04');
    final end = start.add(const Duration(hours: 3));
    EventDateTime startTime = new EventDateTime(); //Setting start time
    startTime.dateTime = start;
    startTime.timeZone = "GMT+05:30";
    event.start = startTime;

    EventDateTime endTime = new EventDateTime(); //setting end time
    endTime.timeZone = "GMT+05:30";
    endTime.dateTime = end;
    event.end = endTime;


   return  await addEvent(event);
  }

  Future<bool> addEvent(Event event)async{
    try {
     await clientViaUserConsent(_credentials, _scopes, prompt).then((
          AuthClient client)async {
        var calendar = CalendarApi(client);
        String calendarId = "primary";
       await calendar.events.insert(event, calendarId).then((value)async {
          print("ADDEDDD_________________${value.status}");

          if ( value.status == "confirmed") {
            return true;
          } else {
            print("Unable to add event in google calendar");
            return false;
          }
        });
      });
     return true;
    } catch (e) {
      print('Error creating event $e');
      return false;
    }
  }


  void prompt(String url) async {
      await launch(url);
  }
}