import 'package:flutter/material.dart';

class Sort_Events{

  dynamic func(dynamic dayItem){
    Map <String,List> M={};
    for (var i in dayItem){
      if(M[i['time']]==null){
        M[i['time']]= [i['name']];
      }
      else
      M[i['time']].add(i['name']);
    }
    return M;
  }
}