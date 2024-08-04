import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:test_p/views/utils/app_extensions/app_extensions.dart';

import '../../../controllers/controllers/home/home_controller.dart';
import '../../utils/app_colors/app_colors.dart';

class HomeWidgets {
  HomeWidgets(this.context);

  BuildContext context;

  Widget searchView(
      {required TextEditingController controller,
      required String hint,
      IconData? endIcon,
      void Function(String? value)? onChange,
      void Function()? onFilterTap}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 0),
        decoration:
            BoxDecoration(borderRadius: 40.borderRadius, color: AppColor.soft),
        child: TextFormField(
          controller: controller,
          maxLines: 1,
          onChanged: onChange,
          cursorColor: AppColor.white,
          decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  5.height,
                  FaIcon(
                    FontAwesomeIcons.magnifyingGlass,
                    color: AppColor.gray,
                    size: 20,
                  ),
                ],
              ),
              hintText: hint,
              hintStyle: TextStyle(color: AppColor.gray),
              suffixIcon: SizedBox(
                  width: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "|",
                        style: TextStyle(fontSize: 25, color: AppColor.gray),
                      ),
                      5.width,
                      InkWell(
                          onTap: onFilterTap,
                          child: FaIcon(
                            endIcon ?? FontAwesomeIcons.filter,
                            color: AppColor.white,
                            size: 20,
                          ))
                    ],
                  ))),
        ),
      ),
    );
  }

  PopupMenuItem menuTitleView({
    required String title,
  }) {
    return PopupMenuItem(
      enabled: false,
      height: 20,
      child: Text(
        title,
        style: TextStyle(color: AppColor.gray),
      ),
    );
  }

  PopupMenuItem menuItemView({required String text, void Function()? onTap}) {
    return PopupMenuItem(
      onTap: onTap,
      height: 40,
      child: Center(
          child: Text(
        text,
        style: TextStyle(color: AppColor.blueAccent),
      )),
    );
  }

  void openPopMenu(
      {required BuildContext context,
      required HomeWidgets view,
      required HomeController homeController}) {
    showMenu(
        context: context,
        color: AppColor.darkGray,
        surfaceTintColor: AppColor.darkGray,
        shape: 15.shapeBorderRadius,
        elevation: 30,
        constraints: const BoxConstraints(minWidth: 100),
        position: const RelativeRect.fromLTRB(100, 100, 10, 90),
        items: [
          view.menuTitleView(title: "modified date"),
          view.menuItemView(
              text: "new to old",
              onTap: () {
                homeController.videoList
                    ?.sort((a, b) => b.modifiedDate!.compareTo(
                          a.modifiedDate!,
                        ));
              }),
          view.menuItemView(
              text: "old to new",
              onTap: () {
                homeController.videoList
                    ?.sort((a, b) => a.modifiedDate!.compareTo(
                          b.modifiedDate!,
                        ));
              }),
          view.menuTitleView(title: "Size"),
          view.menuItemView(
              text: "big to small",
              onTap: () {
                homeController.videoList?.sort(
                  (a, b) {
                    return b.size!.compareTo(a.size!);
                  },
                );
              }),
          view.menuItemView(
              text: "small to big",
              onTap: () {
                homeController.videoList?.sort(
                  (a, b) {
                    return a.size!.compareTo(b.size!);
                  },
                );
              }),
          view.menuTitleView(title: "Duration"),
          view.menuItemView(
              text: "Long to Short",
              onTap: () {
                homeController.videoList?.sort(
                  (a, b) {
                    return b.duration.compareTo(a.duration);
                  },
                );
              }),
          view.menuItemView(
              text: "Short to Long",
              onTap: () {
                homeController.videoList?.sort(
                  (a, b) {
                    return a.duration.compareTo(b.duration);
                  },
                );
              }),
        ]);
  }

  Widget albumListView(
          {required List<Album> albumList,
          required void Function(int) onAlbumTap,
          required int currentIndex,
          double? height}) =>
      SizedBox(
          height: height ?? context.screenHeight * 0.05,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            dragStartBehavior: DragStartBehavior.start,
            physics: const BouncingScrollPhysics(),
            itemCount: albumList.length,
            itemBuilder: (context, index) => albumItem(
                album: albumList[index],
                backgroundColor:
                    index == currentIndex ? AppColor.blueAccent : AppColor.soft,
                onTap: () {
                  onAlbumTap(index);
                }),
            separatorBuilder: (BuildContext context, int index) => 20.width,
          ));

  Widget albumItem(
      {required Album album,
      required backgroundColor,
      required void Function()? onTap,
      double? width,
      double? height}) {
    return Center(
        child: Container(
            height: double.minPositive,
            constraints: const BoxConstraints(
                minWidth: 50, minHeight: 30, maxHeight: 50),
            child: GestureDetector(
              onTap: onTap,
              child: PhysicalModel(
                  color: backgroundColor,
                  borderRadius: 9.borderRadius,
                  shape: BoxShape.rectangle,
                  elevation: 0,
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(album.name ?? "root"),
                  ))),
            )));
  }

  Widget allVideoListView(
      {required List<Medium> videoList,
      required void Function(dynamic index) onVideoTap,
      required void Function(dynamic index) onMoreTap,
      double? height}) {
    return SizedBox(
      height: height ?? context.screenHeight * 0.9,
      child: Scrollbar(
        child: ListView.separated(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          itemCount: videoList.length,
          itemBuilder: (context, index) => videoItem(
              video: videoList[index],
              onVideoTap: () {
                onVideoTap(index);
              },
              onMoreTap: () {
                onMoreTap(index);
              }),
          separatorBuilder: (BuildContext context, int index) => 10.height,
        ),
      ),
    );
  }

  Widget videoItem(
      {required Medium video,
      required Null Function() onVideoTap,
      void Function()? onMoreTap}) {
    video.duration;
    return Center(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: InkWell(
        onTap: onVideoTap,
        child: SizedBox(
          height: 90,
          child: PhysicalModel(
            color: AppColor.dark,
            borderRadius: 10.borderRadius,
            child: Container(
              height: double.minPositive,
              constraints: const BoxConstraints(minHeight: 70),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: 100,
                      height: double.minPositive,
                      constraints: const BoxConstraints(
                        minWidth: 90,
                        minHeight: 80,
                      ),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: ClipRRect(
                                // borderRadius: BorderRadius.only(topLeft: 10.radius,bottomLeft: 10.radius),
                                borderRadius: 10.borderRadius,
                                child: Image(
                                  image: ThumbnailProvider(
                                      mediumId: video.id, highQuality: true),
                                  fit: BoxFit.cover,
                                  filterQuality: FilterQuality.high,
                                )),
                          ),
                          Positioned.fill(
                            top: 60,
                            left: 55,
                            right: 5,
                            bottom: 5,
                            child: Center(
                                child: PhysicalModel(
                                    color: AppColor.darkGray,
                                    borderRadius: 3.borderRadius,
                                    shape: BoxShape.rectangle,
                                    elevation: 0,
                                    child: Center(
                                        child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 3.0),
                                      child: Text(
                                        video.duration.formateDuration,
                                        style: const TextStyle(fontSize: 8),
                                      ),
                                    )))),
                          )
                        ],
                      )),
                  15.width,
                  // Text("${mediaList[index].filename}",overflow:TextOverflow.ellipsis ,),
                  Flexible(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "${video.title}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${video.modifiedDate?.formateDate}",
                            style: const TextStyle(fontSize: 10),
                          ),
                          IconButton(
                              onPressed: onMoreTap,
                              style: IconButton.styleFrom(
                                  fixedSize: const Size(15, 15)),
                              icon: Icon(
                                Icons.more_vert,
                                size: 15,
                                color: AppColor.white,
                              ))
                        ],
                      )
                    ],
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }

  Widget bottomBarItem(
      {required void Function() onItemTap,
      required String label,
      required IconData icon,
      required bool selected}) {
    return InkWell(
      onTap: onItemTap,
      child: AnimatedContainer(
          padding: 10.allPadding,
          duration: const Duration(milliseconds: 0),
          decoration: BoxDecoration(
            color: selected ? AppColor.soft : AppColor.dark,
            borderRadius: 20.borderRadius,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: selected ? AppColor.blueAccent : AppColor.whiteGray,
              ),
              4.width,
              Visibility(
                visible: selected ? true : false,
                child: Text(
                  label,
                  style: TextStyle(color: AppColor.blueAccent),
                ),
              ),
            ],
          )),
    );
  }

  void showBottomSheetView(
      {required BuildContext context, required Widget child}) {
    showModalBottomSheet(
      useSafeArea: true,
      backgroundColor: AppColor.dark,
      context: context,
      constraints: BoxConstraints(minWidth: context.screenWidth),
      builder: (context) => Column(
        children: [
          20.height,
          SizedBox(
              width: 50,
              child: Divider(
                height: 1,
                thickness: 3,
                color: AppColor.white,
              )),
          20.height,
          child,
        ],
      ),
    );
  }

  Widget listItem({
    required String title,
    IconData? icon,
    Color? textColor,
    Color? iconColor,
    void Function()? onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon ?? Icons.playlist_add_outlined,
        color: iconColor ?? AppColor.white,
      ),
      title: Text(
        title,
        style: TextStyle(color: textColor ?? AppColor.white),
      ),
      onTap: onTap,
    );
  }

  void showAlertDialog(
      {required BuildContext context,
      required Widget child,
      Color? bgColor,
      double? width,
      double? height}) {
    showDialog(
        context: context,
        useSafeArea: true,
        builder: (context) => AlertDialog(
              contentPadding: 0.allPadding,
              backgroundColor: bgColor ?? AppColor.black,
              shape: 10.shapeBorderRadius,
              content: Container(
                width: double.minPositive,
                height: double.minPositive,
                padding: 10.allPadding,
                constraints: BoxConstraints(
                    minWidth: width ?? 300, minHeight: height ?? 150),
                child: child,
              ),
            ));
  }

  Widget newPlaylistDialogView(
      {required TextEditingController controller,
      required void Function()? onCreateTap,
      required void Function()? onCancelTap,
      String? title}) {
    return Column(
      children: [
        10.height,
        Text(title ?? "Create new playlist"),
        10.height,
        10.height,
        SizedBox(
          height: 30,
          child: TextFormField(
            controller: controller,
            maxLines: 1,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: AppColor.green,
                      style: BorderStyle.solid,
                      width: 1,
                      strokeAlign: 1)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: AppColor.green,
                      style: BorderStyle.solid,
                      width: 2,
                      strokeAlign: 1)),
              hintText: "Enter a name",
              hintStyle: TextStyle(color: AppColor.gray),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
                onPressed: onCancelTap,
                style: TextButton.styleFrom(
                    shape: 5.shapeBorderRadius,
                    foregroundColor: AppColor.blueAccent),
                child: Text(
                  "Cancel",
                  style: TextStyle(color: AppColor.green),
                )),
            TextButton(
                onPressed: onCreateTap,
                style: TextButton.styleFrom(
                    shape: 5.shapeBorderRadius,
                    foregroundColor: AppColor.blueAccent),
                child: Text(
                  "Create",
                  style: TextStyle(color: AppColor.green),
                )),
          ],
        )
      ],
    );
  }
}
