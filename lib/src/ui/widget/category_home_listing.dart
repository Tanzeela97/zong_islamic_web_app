import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zong_islamic_web_app/route_generator.dart';
import 'package:zong_islamic_web_app/src/model/cate_info.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_colors.dart';
import 'package:zong_islamic_web_app/src/resource/utility/image_resolver.dart';
import 'package:zong_islamic_web_app/src/resource/utility/screen_arguments.dart';
import 'package:zong_islamic_web_app/src/shared_prefs/stored_auth_status.dart';
import 'package:zong_islamic_web_app/src/ui/widget/video_detail_page.dart';

class CategoryHomeListing extends StatefulWidget {
  final CateInfo trending;

  const CategoryHomeListing({Key? key, required this.trending})
      : super(key: key);

  @override
  State<CategoryHomeListing> createState() => _CategoryHomeListingState();
}

class _CategoryHomeListingState extends State<CategoryHomeListing> {
  late final PageController controller;

  @override
  void initState() {
    controller = PageController(viewportFraction: 0.34, initialPage: 0);
    controller.addListener(listenToChanges);
    super.initState();
  }

  ValueNotifier<int> highlight = ValueNotifier(1);

  void listenToChanges() {}

  @override
  void dispose() {
    controller.dispose();
    highlight.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
          child: Row(
            children: [
              Text(widget.trending.title!.toUpperCase(),
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColor.black)),
              const Spacer(),
              TextButton(
                  onPressed: () {
                    Provider.of<StoredAuthStatus>(context, listen: false)
                            .authStatus
                        ? Navigator.pushNamed(
                            context, RouteString.categoryDetail,
                            arguments: ScreenArguments(
                                buildContext: context,
                                data: widget.trending.catId,
                                secondData: context
                                    .read<StoredAuthStatus>()
                                    .authNumber))
                        : Navigator.pushNamed(context, RouteString.signIn,
                            arguments: ScreenArguments(
                              flag: false,
                              data: '28',
                              secondData:
                                  context.read<StoredAuthStatus>().authNumber,
                            ));
                  },
                  child: Text(
                    'See All',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: AppColor.pinkTextColor),
                  ))
            ],
          ),
        ),
        const Divider(thickness: 1.5,endIndent: 16.0,indent: 16.0,),
        SizedBox(height: 15),
        SizedBox(
          height: 140,
          child: PageView.builder(
              onPageChanged: (val) {
                setState(() {
                  highlight.value = val + 1;
                });
              },
              padEnds: false,
              controller: controller,
              itemCount: widget.trending.cateInfoList!.length,
              itemBuilder: (_, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VideoDetailPage(
                                trending: widget.trending.cateInfoList!,
                                index: index)));
                  },
                  child: Align(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: highlight.value == index ? 0 : 10,
                          vertical:
                          highlight.value != index?15:0),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: SizedBox(
                              height: highlight.value == index ? 120 : 90,
                              child: Image.network(
                                widget.trending.cateInfoList![index].catImage!,
                                fit: BoxFit.cover,
                                errorBuilder: (_, obj, trace) =>
                                    Image(image: ImageResolver.fourZeroFour),
                              ),
                            ),
                          ),
                          Text(
                            widget.trending.cateInfoList![index].contentTitle!,
                            maxLines: 1,
                            textAlign: TextAlign.center,overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(fontSize: 16,fontWeight: highlight.value == index?FontWeight.bold:null),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
