import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:test_p/views/utils/app_extensions/app_extensions.dart';
import 'package:video_player/video_player.dart';
import '../../../controllers/services/app_storage_services/videos/app_storage_service.dart';
import '../../utils/app_colors/app_colors.dart';
import 'PlayVideoScreen.dart';

class ShowAllDeviceVideoScreen extends StatefulWidget {
  const ShowAllDeviceVideoScreen({super.key});

  @override
  State<ShowAllDeviceVideoScreen> createState() =>
      _ShowAllDeviceVideoScreenState();
}

class _ShowAllDeviceVideoScreenState extends State<ShowAllDeviceVideoScreen> {
  var selectAlbumIndex = 0;
  Album? selectedAlum;
  List<Medium>? videoList = [];
  List<Medium> mediaList = [];
  int _activeIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
          setState(() {
            mediaList.shuffle();
          });
        },
        child: ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                padding: const EdgeInsets.symmetric(horizontal: 0),
                decoration: BoxDecoration(
                    borderRadius: 40.borderRadius, color: AppColor.soft),
                child: TextFormField(
                  controller: _searchController,
                  maxLines: 1,
                  cursorColor: AppColor.white,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          5.height,
                          Icon(
                            Icons.search_outlined,
                            color: AppColor.gray,
                          ),
                        ],
                      ),
                      hintText: "Search a title..",
                      hintStyle: TextStyle(color: AppColor.gray),
                      suffixIcon: SizedBox(
                          width: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "|",
                                style: TextStyle(
                                    fontSize: 25, color: AppColor.gray),
                              ),
                              5.width,
                              Icon(
                                Icons.filter,
                                color: AppColor.white,
                              )
                            ],
                          ))),
                ),
              ),
              // Padding(padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),child: TextFormField(controller: TextEditingController(),decoration: InputDecoration(border:OutlineInputBorder(borderRadius: 20.borderRadius,borderSide: BorderSide(color: Colors.white,width: 10,style: BorderStyle.solid)))),),
              (selectedAlum != null)
                  ? FutureBuilder<List<Medium>?>(
                      future: AppStorageService.getAllVideosFromAlbum(album: selectedAlum!),
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return Center(
                            child: progressIndicator,
                          );
                        }
                        return Column(
                          children: [
                            CarouselSlider.builder(
                              itemCount: snapshot.data!.length > 5 ? 5 : snapshot.data!.length,
                              itemBuilder: (context, index, realIndex) {
                                return Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      context.push(PlayVideoScreen(
                                          medium: snapshot.data![index]));
                                    },
                                    child: Stack(
                                      children: [
                                        Positioned.fill(
                                          child: ClipRRect(
                                            borderRadius: 20.borderRadius,
                                            child: Image(
                                                image: ThumbnailProvider(
                                                  mediumId:
                                                      snapshot.data![index].id,
                                                  highQuality: true,
                                                ),
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                        Positioned.fill(
                                            child: Icon(
                                          Icons.play_arrow_outlined,
                                          color: AppColor.blueAccent,
                                          size: 30,
                                        )),
                                        Positioned.fill(
                                            top: 95,
                                            left: 10,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${snapshot.data![index].title}",
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: AppColor.lineDark),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 18.0),
                                                  child: Text(
                                                    snapshot
                                                        .data![index]
                                                        .modifiedDate!
                                                        .formateDate,
                                                    style: TextStyle(
                                                        fontSize: 9,
                                                        color:
                                                            AppColor.lineDark),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            )),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              options: CarouselOptions(
                                  scrollDirection: Axis.horizontal,
                                  initialPage: 0,
                                  autoPlay: true,
                                  aspectRatio: 4 / 3,
                                  height: 180,
                                  autoPlayAnimationDuration:
                                      const Duration(milliseconds: 500),
                                  onPageChanged: (index, reason) {
                                    _activeIndex = index;
                                    setState(() {});
                                  },
                                  pauseAutoPlayOnTouch: true,
                                  enableInfiniteScroll: true,
                                  scrollPhysics: const BouncingScrollPhysics(
                                      decelerationRate:
                                          ScrollDecelerationRate.normal,
                                      parent: BouncingScrollPhysics())),
                            ),
                            10.height,
                            AnimatedSmoothIndicator(
                                activeIndex: _activeIndex,
                                count: snapshot.data!.length > 5
                                    ? 5
                                    : snapshot.data!.length,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                                axisDirection: Axis.horizontal,
                                effect: ExpandingDotsEffect(
                                    activeDotColor: AppColor.blueAccent,
                                    dotWidth: 10,
                                    dotHeight: 10,
                                    paintStyle: PaintingStyle.stroke,
                                    dotColor: AppColor.darkGray,
                                    spacing: 20,
                                    expansionFactor: 7)),
                            10.height
                          ],
                        );
                      },
                    )
                  : SizedBox(
                      height: 180,
                      child: Center(child: progressIndicator),
                    ),
              10.height,
              FutureBuilder<List<Album>>(
                  future: AppStorageService.getAllVideoAlbums(),
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      List<Album> albumList = snapshot.data!;
                      return SizedBox(
                          height: context.screenHeight * 0.05,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            dragStartBehavior: DragStartBehavior.start,
                            physics: const BouncingScrollPhysics(),
                            itemCount: albumList.length,
                            itemBuilder: (context, index) => Center(
                                child: Container(
                                    height: double.minPositive,
                                    constraints: const BoxConstraints(
                                        minWidth: 50,
                                        minHeight: 30,
                                        maxHeight: 50),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectAlbumIndex = index;
                                          selectedAlum = albumList[index];
                                        });
                                      },
                                      child: PhysicalModel(
                                          color: index == selectAlbumIndex
                                              ? AppColor.blueAccent
                                              : AppColor.soft,
                                          borderRadius: 9.borderRadius,
                                          shape: BoxShape.rectangle,
                                          elevation: 0,
                                          child: Center(
                                              child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0),
                                            child: Text(
                                                "${albumList[index].name}"),
                                          ))),
                                    ))),
                            separatorBuilder:
                                (BuildContext context, int index) => 20.width,
                          ));
                    }
                    return const Center(
                      child: Text(""),
                    );
                  }),
              20.height,
              if (selectedAlum != null)
                FutureBuilder<List<Medium>?>(
                    future: AppStorageService.getAllVideosFromAlbum(
                        album: selectedAlum!),
                    builder: (context, snapshot) {
                      if (snapshot.data != null) {
                        var mediaList = snapshot.data!;
                        return SizedBox(
                          height: context.screenHeight * 0.9,
                          child: Scrollbar(
                            child: ListView.separated(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics()),
                              itemCount: mediaList.length,
                              itemBuilder: (context, index) => Center(
                                  child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PlayVideoScreen(
                                              medium: mediaList[index]),
                                        ));
                                    print("object $index");
                                  },
                                  child: PhysicalModel(
                                    color: AppColor.dark,
                                    borderRadius: 10.borderRadius,
                                    child: Container(
                                      height: double.minPositive,
                                      constraints: const BoxConstraints(
                                          minHeight: 70, maxHeight: 130),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              width: 100,
                                              height: 90,
                                              constraints: const BoxConstraints(
                                                  minWidth: 90,
                                                  minHeight: 80,
                                                  maxHeight: 100),
                                              child: Stack(
                                                children: [
                                                  Positioned.fill(
                                                    child: ClipRRect(
                                                        // borderRadius: BorderRadius.only(topLeft: 10.radius,bottomLeft: 10.radius),
                                                        borderRadius:
                                                            10.borderRadius,
                                                        child: Hero(
                                                          tag:
                                                              "video_thumbnail",
                                                          child: Image(
                                                            image: ThumbnailProvider(
                                                                mediumId:
                                                                    mediaList[
                                                                            index]
                                                                        .id,
                                                                highQuality:
                                                                    true),
                                                            fit: BoxFit.cover,
                                                            filterQuality:
                                                                FilterQuality
                                                                    .high,
                                                          ),
                                                        )),
                                                  ),
                                                  Positioned.fill(
                                                    top: 47,
                                                    left: 55,
                                                    right: 10,
                                                    bottom: 8,
                                                    child: Center(
                                                        child: PhysicalModel(
                                                            color: index ==
                                                                    selectAlbumIndex
                                                                ? AppColor
                                                                    .blueAccent
                                                                : AppColor
                                                                    .darkGray,
                                                            borderRadius:
                                                                3.borderRadius,
                                                            shape: BoxShape
                                                                .rectangle,
                                                            elevation: 0,
                                                            child: Center(
                                                                child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          3.0),
                                                              child: Text(
                                                                getDuration(
                                                                    mediaList[
                                                                            index]
                                                                        .duration),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        10),
                                                              ),
                                                            )))),
                                                  )
                                                ],
                                              )),
                                          30.width,
                                          // Text("${mediaList[index].filename}",overflow:TextOverflow.ellipsis ,),
                                          Flexible(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${mediaList[index].title}",
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                  "${mediaList[index].modifiedDate?.formateDate}")
                                            ],
                                          ))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      10.height,
                            ),
                          ),
                        );
                      }
                      return Center(
                        child: Text(""),
                      );
                    })
              else
                10.height
            ]),
      ),
    );
  }


  String getDuration(int duration) {

    return "${duration.milliseconds}";
  }

  void getData() async {
    await AppStorageService.getAllVideoAlbums().then((value) async {
      selectedAlum = value.first;
      for (var data in value) {
        videoList = await AppStorageService.getAllVideosFromAlbum(album: data);
      }
      if (videoList != null) {
        videoList!.shuffle();
      }
      setState(() {});
    });
  }
// String intToTimeLeft(int value) {
//   int h, m, s;
//
//   h = value ~/ 3600;
//
//   m = ((value - h * 3600)) ~/ 60;
//
//   s = value - (h * 3600) - (m * 60);
//
//   String hourLeft = h.toString().length < 2 ? "0" + h.toString() : h.toString();
//
//   String minuteLeft =
//   m.toString().length < 2 ? "0" + m.toString() : m.toString();
//
//   String secondsLeft =
//   s.toString().length < 2 ? "0" + s.toString() : s.toString();
//
//   String result = "$hourLeft:$minuteLeft:$secondsLeft";
//
//   return result;
// }
}
