import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:demo1/utils/utils.dart';
import 'package:demo1/providers/user_provider.dart';
import 'package:demo1/utils/zdrawer.dart';
import 'package:demo1/views/signup_view.dart';
import 'package:demo1/views/upload_wallpaper_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  bool _isExpanded = false;
  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void launchEmailApp(String emailAddress) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: emailAddress,
    );

    if (await canLaunchUrl(Uri.parse(emailLaunchUri.toString()))) {
      await launchUrl(Uri.parse(emailLaunchUri.toString()));
    } else {
      throw 'Could not launch email application';
    }
  }

  void launchInstagramProfile(String username) async {
    final String instagramUrl = 'https://www.instagram.com/$username/';

    if (await canLaunchUrl(Uri.parse(instagramUrl))) {
      await launchUrl(Uri.parse(instagramUrl));
    } else {
      throw 'Could not launch Instagram profile';
    }
  }

  void launchLinkedInProfile(String username) async {
    final String linkedInUrl = 'https://linkedin.com/in/$username';

    if (await canLaunchUrl(Uri.parse(linkedInUrl))) {
      await launchUrl(Uri.parse(linkedInUrl));
    } else {
      throw 'Could not launch Instagram profile';
    }
  }

  @override
  Widget build(BuildContext context) {
    const String email = 'abhishekpalog@gmail.com';
    const String username = '_audemars_ap';
    const String linkedInUsername = 'abhishekpalog';

    return Scaffold(
      backgroundColor: Colors.purple.shade100,
      body: ListView(
        children: [
          const SizedBox(height: 130),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: NeoPopButton(
              color: Colors.deepPurple,
              bottomShadowColor: Colors.green,
              rightShadowColor: Colors.red,
              onTapUp: () {
                if (Provider.of<UserProvider>(context, listen: false)
                        .user
                        .type ==
                    'admin') {
                  Navigator.pushNamed(context, UploadWallpaperView.routeName);
                } else {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const ZDrawer()),
                      (route) => false);
                  showSnackBar(
                    context: context,
                    title: 'Oh Snap!',
                    tesxt: 'Not authorized!',
                    contentType: ContentType.failure,
                  );
                }
              },
              border: Border.all(color: Colors.white, width: 2),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: SizedBox(
                  height: 15,
                  // width: MediaQuery.of(context).size.width * 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.upload,
                        color: Colors.green,
                        size: 18,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'Upload Wallpaper',
                        style: GoogleFonts.oswald(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 0.5,
            color: Colors.black,
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () => Provider.of<UserProvider>(context, listen: false)
                    .user
                    .token
                    .isNotEmpty
                ? () {}
                : Navigator.pushNamedAndRemoveUntil(
                    context, LoginSignupEmail.routeName, (route) => false),
            child: Row(
              children: [
                const Icon(
                  Icons.login_outlined,
                  color: Colors.blue,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                    Provider.of<UserProvider>(context).user.token.isNotEmpty
                        ? 'Logged-In'
                        : 'Log-In/Sign-Up',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500))
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 0.5,
            color: Colors.black,
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: _toggleExpand,
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.help,
                      color: Colors.deepOrange,
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      'How to Upload',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 5),
                          child: _isExpanded
                              ? const Icon(
                                  Icons.arrow_drop_up,
                                  size: 25,
                                  color: Colors.white,
                                )
                              : const Icon(
                                  Icons.arrow_drop_down,
                                  size: 25,
                                  color: Colors.white,
                                ),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                if (_isExpanded)
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 10, bottom: 5),
                    child: Text(
                        'Create a free account by clicking on Log-In/Sign-Up above.After that contact to developer using below socials or drop a mail at abhishekpalog@gmail.com to get authorized!. ',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade700,
                            fontStyle: FontStyle.italic),
                        maxLines: 8),
                  ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 0.5,
            color: Colors.black,
          ),
          const SizedBox(height: 10),
          Column(
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.person_2_outlined,
                    color: Colors.yellow,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Developer's Socials",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () => launchLinkedInProfile(linkedInUsername),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        'https://pbs.twimg.com/profile_images/1661161645857710081/6WtDIesg_400x400.png',
                        height: 30,
                        width: 30,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => launchInstagramProfile(username),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1634942536790-dad8f3c0d71b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OXx8aW5zdGFncmFtJTIwbG9nb3xlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80',
                        height: 30,
                        width: 30,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => launchEmailApp(email),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        'https://play-lh.googleusercontent.com/KSuaRLiI_FlDP8cM4MzJ23ml3og5Hxb9AapaGTMZ2GgR103mvJ3AAnoOFz1yheeQBBI',
                        height: 30,
                        width: 30,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
