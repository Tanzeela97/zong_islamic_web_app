import 'package:flutter/material.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_colors.dart';
import 'package:zong_islamic_web_app/src/resource/utility/image_resolver.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_icon_image.dart';

// class VideoListTile extends StatelessWidget {
//   final String imgUrl;
//   final String contentTitle;
//   final String contentSubTitle;
//   final String likes;
//   final String shares;
//   final bool highlight;
//
//   const VideoListTile(
//       {Key? key,
//         this.highlight= false,
//         required this.imgUrl,
//         required this.contentTitle,
//         required this.contentSubTitle,
//         required this.likes,
//         required this.shares})
//       : super(key: key);
//   final SizedBox _sizeBox = const SizedBox(height: 5);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: highlight?Colors.orange[50]:null,
//       width: double.infinity,
//       height: 100,
//       child: Row(
//         children: [
//           SizedBox(
//             width: 80,
//             height: 90,
//             child: FadeInImage(
//                 fit: BoxFit.fitWidth,
//                 placeholder: const AssetImage(ImageResolver.placeHolderImage),
//                 image: NetworkImage(imgUrl)),
//           ),
//           const SizedBox(width: 5),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SizedBox(
//                 width: 300,
//                 child: Text(contentTitle,
//                     style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                         fontSize: 16, overflow: TextOverflow.ellipsis)),
//               ),
//               _sizeBox,
//               Text(contentSubTitle,
//                   style: Theme.of(context)
//                       .textTheme
//                       .subtitle1!
//                       .copyWith(overflow: TextOverflow.ellipsis)),
//               _sizeBox,
//               Row(
//                 children: [
//                   WidgetIconImage(
//                     iconOne: Icons.thumb_up_off_alt,
//                     like: "$likes likes",
//                     share: "$shares share",
//                     iconTwo: Icons.share,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

class VideoListTileTwo extends StatelessWidget {
  final String imgUrl;
  final String contentTitle;
  final String contentSubTitle;
  final String likes;
  final String shares;
  final bool highlight;
  final String page;
  final String cateId;
  final String contId;
  final void Function(int val) isLikedByUser;
  final String isLiked;

  const VideoListTileTwo(
      {Key? key,
      this.highlight = false,
      required this.imgUrl,
      required this.contentTitle,
      required this.contentSubTitle,
      required this.likes,
      required this.cateId,
      required this.page,
      required this.contId,
      required this.shares,
      required this.isLikedByUser,
      required this.isLiked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: highlight ? Colors.orange[50] : null,
      leading: SizedBox(
        height: 250,
        width: 80,
        child: Stack(
          fit: StackFit.expand,
          children: [
            FadeInImage.assetNetwork(
              placeholder: ImageResolver.placeHolderImage,
              image: imgUrl,
              fit: BoxFit.cover,
            ),
            Icon(Icons.play_arrow_rounded, color: AppColor.darkPink, size: 35)
          ],
        ),
      ),
      title: Text(
        contentTitle,
        style: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(color: Colors.black, overflow: TextOverflow.ellipsis),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(contentSubTitle),
          const SizedBox(height: 10),
          Row(
            children: [
              //todo make it functional
              WidgetIconImage(
                iconOne: Icons.thumb_up_off_alt,
                like: "$likes likes",
                share: "$shares share",
                iconTwo: Icons.share,
                page: page,
                contId: contId,
                cateId: cateId,
                isLikedByUser: (int val) {
                  isLikedByUser(val);
                },
                isLiked: isLiked,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
