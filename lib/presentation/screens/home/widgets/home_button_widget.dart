import 'package:flutter/material.dart';
import 'package:uber_clone/config/utils/colors.dart';

class HomeButtonWidget extends StatelessWidget {
  const HomeButtonWidget(
      {super.key,
      required this.icon,
      required this.isDisabled,
      required this.title,
      required this.function});
  final String icon;
  final String title;
  final bool isDisabled;
  final VoidCallback? function;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: isDisabled ? null : function,
          child: Container(
            height: 220,
            width: 130,
            padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppColors.secondaryColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  icon,
                  height: 100,
                  width: 120,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 6.0, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: AppColors.primaryColor,
                        ),
                        child: const Icon(
                          Icons.arrow_forward,
                          color: AppColors.whiteColor,
                          size: 20,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        isDisabled
            ? Container(
                height: 220,
                width: 130,
                color:
                    const Color.fromARGB(255, 238, 238, 238).withOpacity(0.6),
              )
            : const SizedBox.shrink()
      ],
    );
  }
}
