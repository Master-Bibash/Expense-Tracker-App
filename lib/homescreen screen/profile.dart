import 'dart:io';
import 'package:flutter/material.dart';
import 'package:project/controller/auth_controller.dart';
import 'package:project/provider/profile_imageProvider.dart';
import 'package:project/widgest/image_picking.dart';
import 'package:project/widgest/logout.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);

    return Scaffold(
    backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Icon(
            Icons.person,
            color: Colors.grey[700],
          ),
        ),
        title: Text(
          "Profile Screen",
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
        ),
        centerTitle: false,
      
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Consumer<ProfileImageProvider>(
                      builder: (context, value, child) {
                        return value.filePath == null
                            ? const CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.red,
                              )
                            : CircleAvatar(
                                radius: 60,
                                backgroundImage: FileImage(File(
                                  value.filePath!.path,
                                )),
                              );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                const Text(
                  "WelCome",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                Text(
                  auth.currentUser!.email?? "Guest",
                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: size.height * 0.020,
                ),
                SizedBox(
                  width: size.width * 0.40,
                  height: size.height * 0.062,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          backgroundColor: const Color.fromARGB(255, 0, 0, 0)),
                      onPressed: () {
                        ImagepickerProfile.BottomSheet(context);
                      },
                      child: const Text("Change Profile",style: TextStyle(color: Colors.white),)),
                ),
                SizedBox(
                  height: size.height * 0.020,
                ),
                const Divider(),
                SizedBox(
                  height: size.height * 0.010,
                ),
               bottons(size: size, text: "Settings", icon: Icons.settings, ontap: (){}),
                  const Divider(),
                SizedBox(
                  height: size.height * 0.010,
                ),
               bottons(size: size, text: "Account", icon: Icons.wallet, ontap: (){}),
                  const Divider(),
                SizedBox(
                  height: size.height * 0.010,
                ),
               bottons(size: size, text: "Share", icon:Icons.share, ontap:(){}),
                  const Divider(),
                SizedBox(
                  height: size.height * 0.010,
                ),
               bottons(size: size, text: "Logout", icon:Icons.logout_sharp, ontap:(){
                UserLogout.askLOgout(context);
               }),
               


                // Add more user profile information here
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class bottons extends StatelessWidget {
  const bottons({
    super.key,
    required this.size, required this.text, required this.icon, required this.ontap,
  });
  final String text;
  final IconData icon;
 final  Function() ontap;

  final Size size;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: ontap,
      leading: Container(
        width: size.width * 0.10,
        height: size.height * 0.062,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.red.withOpacity(1),
        ),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
      title: Text(
        text,
        style: const TextStyle(fontSize: 16),
      ),
      trailing: Container(
        width: size.width * 0.09,
        height: size.height * 0.050,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.transparent,
        ),
        child: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.white,
          size: 15,
        ),
      ),
    );
  }
}
