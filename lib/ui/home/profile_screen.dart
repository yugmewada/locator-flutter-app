import 'package:flutter/material.dart';

import '../../base/base_app_bar.dart';
import '../../generated/assets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.imagesImageProfileBack),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                BaseAppBar(
                  backgroundColor: Colors.transparent,
                  statusBarColor: Colors.transparent,
                  centerTitle: true,
                  showTitle: true,
                  title: "Profile",
                ),

                const SizedBox(height: 39,),

                _buildProfileImage()

              ],
            ),
          ),
          // Your profile content here
        ],
      ),
    );
  }


  Widget _buildProfileImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: ClipOval(
            child: Container(
              height: 164,
              width: 164,
              color: Colors.white,
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Container(
                    width: 135,
                    height: 135,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    clipBehavior: Clip.antiAlias,
                    child:Image.asset(Assets.imagesDummyUser, fit: BoxFit.cover)
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

}
