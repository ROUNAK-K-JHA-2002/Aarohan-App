import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aarohan_app/repository/user_respository.dart';
import 'package:aarohan_app/screens/dashboard.dart';
import 'package:aarohan_app/screens/login.dart';
import 'package:aarohan_app/screens/loader_screen.dart';


class HomePage extends StatelessWidget {

int x=0;
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider<UserRepository>(
      create: (context) => UserRepository.instance(),
      child: Consumer(
          builder: (context, UserRepository user,child){
            switch (user.status){
              case Status.Uninitialized:
                return Center(child: CircularProgressIndicator());
              case Status.Unauthenticated:
                print("x");
                return Login();

              case Status.Authenticating:
                print("p");
                return Center(child: CircularProgressIndicator());
              case Status.Authenticated:
                x++;
                print(x);
                if(x==1)
                return  LoaderScreen();
                else
                  return Dashboard();
            }
            return null;
          }
      ),
    );
  }
}
