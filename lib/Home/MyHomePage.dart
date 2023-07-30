import 'package:experiance/Widget/Appbar/HomeAppBar.dart';
import 'package:experiance/shared-ui/List/userList/ArticleList.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Widget/Art/AddArt/AddSection.dart';
import 'Container_roule.dart';
import '../firebase/authentication.dart';
import '../Widget/Text/Small_text.dart';
import 'package:experiance/Widget/Text/Big_text_dart.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyHomePage extends StatefulWidget {

  final User? user;
  const MyHomePage({Key? key, this.user}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  bool isObscurePassword = true;
  bool inLoginProcess = false;
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabSelected,
        selectedItemColor: Colors.orange,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.orange),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add, color: Colors.orange),
            label: 'Ajouter',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.orange),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications, color: Colors.orange),
            label: 'Notification',
          ),
        ],
      ),
      body: buildPages(),
    );
  }

  Widget buildPages() {
    switch (_currentIndex) {
      case 0:
        return buildHomeIcons();
      case 1:
        return buildAddIcons();
      case 2:
        return buildPersonIcons();
      case 3:
        return buildNotificationIcons();
      default:
        return Container();
    }
  }

  Widget buildHomeIcons() {
    return Scaffold(
      body: Column(
        children: [
          //le debu du body
          Container(
            margin: const EdgeInsets.only(top: 45, bottom: 15),
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Big_Text(text: "SOKO", color: Colors.orange),
                    Row(children: [
                      SmallText(text: "TOGO", color: Colors.black54),
                      //Icon(Icons.arrow_drop_down_rounded),
                    ]),
                  ],
                ),
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.orange,
                  ),
                  child: const Icon(Icons.settings, color: Colors.white),
                ),
              ],
            ),
          ),
          //le milieu du body
          const Expanded(
            child: SingleChildScrollView(
              child: Article(),
            ),
          ),
        ],
      ),
    );
  }


  Widget buildAddIcons() {
    final user = Provider.of<User?>(context);

    return  Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            HomeAppBar(user: user),
            AddSection(user: user),
            ArticleList(userID: user!.uid),
          ],
        ),
      ),

    );
  }


  Widget buildPersonIcons() {

    return Scaffold(
      appBar: AppBar(
        title: const Text(' Profile Utilisateur'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        border: Border.all(width: 4, color: Colors.white),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1),
                          ),
                        ],
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            'https://example.com/profile_image.png',
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 4, color: Colors.white),
                          color: Colors.orange,
                        ),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              buildTextField("Full Name", "Demon", false),
              buildTextField("Email", "djadabrice@gmail.com", false),
              buildTextField("Password", "*********", false),
              buildTextField("ville", "Lome", false),
              const SizedBox(height: 30),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          AuthService().logout();
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          "CANCEL",
                          style: TextStyle(
                            fontSize: 15,
                            letterSpacing: 2,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          "SAVE",
                          style: TextStyle(
                            fontSize: 15,
                            letterSpacing: 2,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        inLoginProcess
                            ? const Center(child: Expanded(child: CircularProgressIndicator()))
                            :
                            Expanded(
                               child: ElevatedButton.icon(
                                onPressed: () => siginWithGoogle(),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                  padding: const EdgeInsets.symmetric(horizontal: 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                icon: const FaIcon(FontAwesomeIcons.google, color: Colors.white),
                                label: const Text(
                                  "connect with Google",
                                  style: TextStyle(
                                    fontSize: 15,
                                    letterSpacing: 2,
                                    color: Colors.white,
                                  ),
                                ),
                              ),

                            ),

                      ],


                    ),
                  )
                ]
              )

            ],
          ),
        ),
      ),
    );
  }


  siginWithGoogle() async {
    setState(()  {
      inLoginProcess = true;
      //AuthService().signInWithGoogle();
    });
    try {
      //attempt to sign in with google
      await AuthService().signInWithGoogle();
      //connexion avec google
      setState(() {
        inLoginProcess = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        inLoginProcess = false;
      });
    }

  }

  Widget buildTextField(
      String labelText,
      String placeholder,
      bool isPasswordTextField,
      ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: TextField(
        obscureText: isPasswordTextField ? isObscurePassword : false,
        decoration: InputDecoration(
          suffixIcon: isObscurePassword
              ? IconButton(
                icon: const Icon(Icons.remove_red_eye, color: Colors.grey),
                onPressed: () {
                  setState(() {
                    isObscurePassword = !isObscurePassword;
                  });
                },
          )
              : null,
          contentPadding: const EdgeInsets.only(bottom: 5),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget buildNotificationIcons() {
    return GridView.count(
      crossAxisCount: 2,
    );
  }
}
