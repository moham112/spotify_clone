import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_clone/common/widgets/button/basic_app_button.dart';
import 'package:spotify_clone/core/configs/assets/app_images.dart';
import 'package:spotify_clone/core/configs/assets/app_vectors.dart';
import 'package:spotify_clone/core/configs/theme/app_colors.dart';
import 'package:spotify_clone/presentation/choose_mode/pages/change_mode_page.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 40,
              horizontal: 40,
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  AppImages.introBG,
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.15),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 40,
              horizontal: 40,
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: SvgPicture.asset(AppVectors.logo),
                ),
                Spacer(),
                Text(
                  'Enjoy Listening to Music',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 21),
                Text(
                  textAlign: TextAlign.center,
                  'Lorem ipsum dolor sit amet,consectetur adipiscing elit. Sagittis enim purus sed phasellus.Cursus ornare id scelerisque aliquam.',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.grey,
                  ),
                ),
                SizedBox(height: 20),
                BasicAppButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChangeModePage()),
                    );
                  },
                  title: 'Get Started',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
