import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class HeaderLoader extends StatelessWidget {
  const HeaderLoader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SkeletonAvatar(
          style: SkeletonAvatarStyle(shape: BoxShape.circle, width: 40, height: 40),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: SkeletonParagraph(
            style: SkeletonParagraphStyle(
              lines: 3,
              spacing: 6,
              lineStyle: SkeletonLineStyle(
                height: 6,
                borderRadius: BorderRadius.circular(100),
                maxLength: MediaQuery.of(context).size.width / 3,
              ),
            ),
          ),
        ),
        const SkeletonAvatar(
          style: SkeletonAvatarStyle(shape: BoxShape.circle, width: 28, height: 28),
        ),
      ],
    );
  }
}
