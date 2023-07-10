import 'package:flutter/material.dart';



import '../util/colors.dart';
import '../util/size_config.dart';

class AuthBannerWidget extends StatelessWidget {
  final String description;
  final String title;

  const AuthBannerWidget({
    Key? key,
    required this.description,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: SizeConfig.height10(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/auth_banner.png',
            width: double.infinity,
            height: (SizeConfig.height20(context) * 11.8),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 24,
              ),
            ),
          ),
          Text(
            description,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              color: textFieldEnabledColor,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
