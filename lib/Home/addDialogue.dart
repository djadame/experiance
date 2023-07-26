import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddDialogue{
  User? user;
  AddDialogue({this.user});


  //pour visualiser la boite de dialogue

  void showDialogue(BuildContext context, ImageSource source) async{
    XFile? pickedFile = await ImagePicker().pickImage(source: source);
    File file = File(pickedFile!.path );
    final keyForm = GlobalKey<FormState>();
    String artName = '';
    String description = '';
    double? prix = 0;
    String Lieu = '';
    String nameFormerror = 'entre le nom!';
    String desFormerror = 'entre la description!';
    String pFormerror = 'Entre le prix!';
    String lFormerror = 'Entre le lieux';
    // ignore: use_build_context_synchronously
    showDialog(
        context: context,
        builder: (BuildContext context){
      return SimpleDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        contentPadding: EdgeInsets.zero,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              color: Colors.grey,
              image: DecorationImage(
                image: FileImage(
                  file
                ),
                fit: BoxFit.cover,
              )
            ),
          ),
          Column(
            children: [
              Form(
                key: keyForm,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: TextFormField(
                        maxLength: 20,
                        onChanged: (value) => artName = value,
                        validator: (value) => artName == '' ? nameFormerror : null,
                        decoration: const InputDecoration(
                          labelText: 'nom de l\'article',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: TextFormField(
                        //maxLength: 200,
                        onChanged: (value) => description = value,
                        validator: (value) => description == '' ?  desFormerror : null,
                        decoration: const InputDecoration(
                          labelText: 'Description',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        //maxLength: 200,
                        onChanged: (value) => prix = double.tryParse(value) ?? 0,
                        validator: (value) => value != null ?  pFormerror : null,
                        decoration: const InputDecoration(
                          labelText: 'Prix',
                          border: OutlineInputBorder(),
                          prefixIcon:  Icon(Icons.attach_money),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: TextFormField(
                        maxLength: 50,
                        onChanged: (value) => Lieu = value,
                        validator: (value) => value != null ?  lFormerror : null,
                        decoration: const InputDecoration(
                          labelText: 'Lieu',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ) ,


              ),
              Align(
                alignment: Alignment.centerRight,
                child: Wrap(
                  children: [
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text(
                          'Annuler'
                        ) ),
                    ElevatedButton(
                        onPressed: () {},
                        child: const Text(
                          'Publier'
                        )
                    )
                  ],
                ),
              )
            ],
          )
        ],
      );
    });
  }
}