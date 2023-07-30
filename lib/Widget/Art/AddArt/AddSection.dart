import 'package:experiance/Widget/Art/AddArt/addDialogue.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddSection extends StatelessWidget {
  final User? user;
  const AddSection({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Column(
                  children: [
                    const Text(''),
                    Text(user!.displayName!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    )
                  ]
                ),
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[300]
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.search),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(left: 10.0,),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor.withOpacity(0.5)
                      ),
                      child: IconButton(
                        onPressed: () => showArtDialogue(context, user!),
                        icon: const Icon(Icons.add),
                      ),
                    )
                  ],
                )
              ],

            ),
          )
        ]
      ),
    );
  }

  void showArtDialogue(BuildContext context, User user){
    AddDialogue(user: user).showDialogue(context, ImageSource.gallery);
  }
}
