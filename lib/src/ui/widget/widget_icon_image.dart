import 'dart:async';

import 'package:flash/src/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:zong_islamic_web_app/src/cubit/user_action_cubit/user_action_cubit.dart';

class WidgetIconImage extends StatefulWidget {
  String like;
  String share;
  final IconData iconOne;
  final IconData iconTwo;
  final String cateId;
  final String contId;
  final String page;
  String isLiked;
  final void Function(int val) isLikedByUser;

  WidgetIconImage(
      {Key? key,
      required this.like,
      required this.iconOne,
      required this.share,
      required this.iconTwo,
      required this.cateId,
      required this.contId,
      required this.isLiked,
      required this.page,
      required this.isLikedByUser})
      : super(key: key);

  @override
  State<WidgetIconImage> createState() => _WidgetIconImageState();
}

class _WidgetIconImageState extends State<WidgetIconImage> {
  final UserActionCubit _userActionCubit = UserActionCubit();

  static bool setEnumLike(EnumLikeStatus enumLikeStatus) =>
      enumLikeStatus == EnumLikeStatus.like;

  Future<void> updateUserAction() async {
    print(
        'cate ${widget.cateId},cont ${widget.contId},page ${widget.page},isLiked${widget.isLiked}');
    final Completer completer = Completer();
    context.showBlockDialog(dismissCompleter: completer);
    await _userActionCubit
        .setUserAction(
            cate_id: widget.cateId,
            cont_id: widget.contId,
            page: widget.page,
            action: setEnumLike(EnumLikeStatus.values[
                    widget.isLiked == '' ? 0 : int.parse(widget.isLiked)])
                ? 'unlike'
                : 'like')
        .then((value) {
      completer.complete();
      if (setEnumLike(EnumLikeStatus
          .values[widget.isLiked == '' ? 0 : int.parse(widget.isLiked)])) {
        setState(() {
          widget.isLiked = 0.toString();
          /////////

          int a = int.parse(widget.like) - 1;
          widget.like = a.toString();
          print(int.parse(widget.like));
        });
      } else {
        setState(() {
          widget.isLiked = 1.toString();
          //////////
          int a = int.parse(widget.like) + 1;
          widget.like = a.toString();
          print(int.parse(widget.like));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserActionCubit, UserActionState>(
      bloc: _userActionCubit,
      builder: (context, state) {
        return SizedBox(
          width: 230,
          child: Row(
            children: [
              Expanded(
                  child: IconButton(
                      onPressed: updateUserAction,
                      icon: Icon(
                          setEnumLike(EnumLikeStatus.values[widget.isLiked == ''
                                  ? 0
                                  : int.parse(widget.isLiked)])
                              ? Icons.thumb_up
                              : widget.iconOne,
                          size: 20,
                          color: Colors.pink))),
              Expanded(
                  flex: 2,
                  child: Text(widget.like!=null?'${widget.like} like':'Like',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 14, color: Colors.black54))),
              Expanded(
                  child: IconButton(
                      onPressed: () async {
                        _userActionCubit.setUserAction(
                            cate_id: widget.cateId,
                            cont_id: widget.contId,
                            page: widget.page,
                            action: 'share');
                      await  Share.share(
                            'https://zongislamicv1.vectracom.com/api/share_webpage.php?code=undefined');
                        setState(() {
                          int a =int.parse(widget.share);
                          print(a++);

                          widget.share = a.toString();
                        });
                      },
                      icon: Icon(widget.iconTwo, size: 20),
                      color: Colors.pink)),
              Expanded(
                  flex: 2,
                  child: Text(widget.share!=null?'${widget.share} share':'share',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 14, color: Colors.black54))),
            ],
          ),
        );
      },
    );
  }
}

enum EnumLikeStatus { unlike, like }
