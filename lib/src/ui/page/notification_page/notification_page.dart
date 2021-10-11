import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zong_islamic_web_app/src/cubit/notification_cubit/notification_cubit.dart';
import 'package:zong_islamic_web_app/src/model/notification.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_colors.dart';
import 'package:zong_islamic_web_app/src/resource/utility/image_resolver.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    BlocProvider.of<NotificationCubit>(context).getNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        if (state is NotificationInitial) {
          return const SizedBox.shrink();
        } else if (state is NotificationLoadingState) {
          return const Center(child: Text('loading'));
        } else if (state is NotificationSuccessState) {
          return _NotificationPage(notification: state.notificationList!);
        } else if (state is NotificationErrorState) {
          return const Center(child: Text('something Went Wrong'));
        } else {
          return const Center(child: Text('something Went Wrong'));
        }
      },
    );
  }
}

class _NotificationPage extends StatelessWidget {
  final List<Notifications> notification;

  const _NotificationPage({Key? key, required this.notification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) => ListTile(
              title: Text(notification[index].title!),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [Text(notification[index].ago!)],
              ),
              leading: const CircleAvatar(
                radius: 30.0,
                backgroundImage: AssetImage(ImageResolver.placeHolderImage),
                backgroundColor: Colors.transparent,
              ),
            ),
        separatorBuilder: (context, index) =>
            const Divider(color: AppColor.pinkTextColor),
        itemCount: 5);
  }
}
