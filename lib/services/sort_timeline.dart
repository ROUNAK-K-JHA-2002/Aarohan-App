import 'package:flutter/material.dart';

class Sort_Events {
  dynamic func(dynamic dayItem) {
    List<dynamic> M = dayItem;
    M.sort((a, b) {
      int x = a['time'].compareTo(b['time']);
      int y = a['time'].substring(6).compareTo(b['time'].substring(6));
      print(y);
      if (y < 0) {
        return 0;
      }
      if (y > 0) {
        return 1;
      }
      if (y == 0) {
        if (a['time'].substring(6) == "PM") {
          if (a['time'].substring(0, 2) == "12" &&
              b['time'].substring(0, 2) != "12") {
            return 0;
          }
          if (a['time'].substring(0, 2) != "12" &&
              b['time'].substring(0, 2) == "12") {
            return 1;
          }
        }
        if (a['time'].substring(6) == "AM") {
          if (a['time'].substring(0, 2) == "12" &&
              b['time'].substring(0, 2) != "12") {
            return 0;
          }
          if (a['time'].substring(0, 2) != "12" &&
              b['time'].substring(0, 2) == "12") {
            return 1;
          }
        }
        return x;
      }
      return 1;
    });

    Map<String, List> N = {};
    for (var i in M) {
      if (N[i['time']] == null) {
        N[i['time']] = [i['name']];
      } else
        N[i['time']].add(i['name']);
    }
    return N;
  }
}
