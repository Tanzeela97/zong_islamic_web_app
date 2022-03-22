import 'package:flutter/material.dart';
import 'package:zong_islamic_web_app/src/model/cate_info.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_colors.dart';
import 'package:zong_islamic_web_app/src/resource/utility/image_resolver.dart';
import 'package:zong_islamic_web_app/src/ui/page/home_page/home_detail_page.dart';

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
              Text(widget.trending.title!,
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(fontWeight: FontWeight.bold,color: AppColor.blackTextColor)),
              const Spacer(),
              TextButton(
                  onPressed: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => HomeDetailPage(
                    //             trending: widget.trending, index: 0)));
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
        SizedBox(height: 15),
        SizedBox(
          height: 120,
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
                return Align(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: highlight.value == index ? 0 : 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: SizedBox(
                        height: highlight.value == index ? 120 : 90,
                        child: Image.network(
                          widget.trending.cateInfoList![index].contentImage!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, obj, trace) =>
                              Image(image: ImageResolver.fourZeroFour),
                        ),
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
