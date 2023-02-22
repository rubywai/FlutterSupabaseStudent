

import 'package:flutter/material.dart';

Future<bool> confirmDialog(BuildContext context) async{
  return await showDialog(context: context,
      builder: (context){
        return AlertDialog(
          title: const Text("Delete"),
          content: const Text('Are you sure to delete this sudent'),
          actions: [
            ElevatedButton(onPressed: (){
              Navigator.pop(context,false);
            }, child: const Text('No')),
            ElevatedButton(onPressed: (){
              Navigator.pop(context,true);
            }, child: const Text('Yes'))
          ],
        );
      });
}