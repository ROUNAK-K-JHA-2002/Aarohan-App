import 'package:aarohan_app/game/game_start.dart';
import 'package:aarohan_app/interficio/interficio.dart';
import 'package:aarohan_app/models/event.dart';
import 'package:aarohan_app/resources/firestore_provider.dart';
import 'package:aarohan_app/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'screens/home_page.dart';
import 'package:aarohan_app/screens/event_screen.dart';
import 'package:aarohan_app/models/schedule.dart';
import 'package:aarohan_app/screens/timeline.dart';
import 'package:aarohan_app/screens/about_us.dart';
import 'package:aarohan_app/screens/leaderboard.dart';
import 'package:aarohan_app/screens/contributors.dart';
import 'package:aarohan_app/models/contributor.dart';
import 'package:aarohan_app/models/sponsor.dart';
import 'package:aarohan_app/screens/sponsors.dart';
import 'package:aarohan_app/screens/transaction.dart';
import 'package:aarohan_app/screens/eurekoin_home.dart';
import 'package:aarohan_app/models/contact_us.dart';
import 'package:aarohan_app/screens/contact.dart';
import 'package:aarohan_app/screens/coming_soon.dart';
import 'package:aarohan_app/models/coming_soon.dart';
import 'package:aarohan_app/screens/prelims.dart';
import 'package:aarohan_app/models/prelim.dart';
import 'package:aarohan_app/screens/ar.dart';
import 'package:flutter/services.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      StreamProvider<List<EventItem>>(
          create: (_) => FirebaseService().eventListStream(), initialData: []),
      StreamProvider<List<DayItem>>(
          create: (_) => FirebaseService().scheduleListStream(),
          initialData: []),
      StreamProvider<List<ContributorItem>>(
          create: (_) => FirebaseService().contributorStream(),
          initialData: []),
      StreamProvider<List<SponsorItem>>(
          create: (_) => FirebaseService().sponsorStream(), initialData: []),
      StreamProvider<List<ContactItem>>(
          create: (_) => FirebaseService().contactStream(), initialData: []),
      StreamProvider<List<ComingItem>>(
          create: (_) => FirebaseService().comingListStream(), initialData: []),
      StreamProvider<List<PrelimItem>>(
          create: (_) => FirebaseService().prelimStream(), initialData: []),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      routes: {
        '/eventpage': (context) => Event_Detail(),
        '/timeline': (context) => Timeline(),
        '/home': (context) => Dashboard(),
        '/leaderboard': (context) => Leaderboard(),
        '/about': (context) => About(),
        '/contributor': (context) => Contributors(),
        '/sponsor': (context) => Sponsors(),
        '/eurekoin': (context) => Eurekoin_Home(),
        '/contact': (context) => Contact(),
        '/coming': (context) => Coming(),
        '/game': (context) => MyHomePage("Dino Game"),
        '/journo': (context) => Interfecio(),
        '/transaction': (context) => Transaction(),
        '/prelims': (context) => Prelims(),
        '/ar': (context) => AR()
      },
    ),
  ));
}
