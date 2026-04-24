import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import '../resources/enums.dart';
import 'homeScreencontroller.dart';

class UploadStoryController extends GetxController {
  final homeScreenController = Get.put(HomeScreenController());
  var mediaList = [].obs;
  var thumbnails = [].obs;
  var selectedIndex = 0.obs;
  var selectedFilter = AlbumFilter.recent.obs;

  @override
  void onInit() {
    super.onInit();
    loadMedia();
  }

  Future<void> loadMedia() async {
    final permission = await PhotoManager.requestPermissionExtend();
    if (permission.isAuth == false) {
      PhotoManager.openSetting();
      return;
    }
    await filterMedia(selectedFilter.value);
  }

  Future<void> filterMedia(AlbumFilter filter) async {
    selectedFilter.value = filter;

    RequestType type = RequestType.all;
    if (filter == AlbumFilter.photos) type = RequestType.image;
    if (filter == AlbumFilter.videos) type = RequestType.video;

    final albums = await PhotoManager.getAssetPathList(type: type, onlyAll: true);
    if (albums.isEmpty) return;

    final assets = await albums[0].getAssetListPaged(page: 0, size: 100);
    mediaList.assignAll(assets);

    final thumbs = await Future.wait(
      assets.map((a) => a.thumbnailDataWithSize( ThumbnailSize(300, 300)).then((b) => b ?? Uint8List(0))),
    );
    thumbnails.assignAll(thumbs);

    selectedIndex.value = mediaList.isNotEmpty ? 0 : 0;
  }

  void selectMedia(int index) {
    selectedIndex.value = index.clamp(0, mediaList.length - 1);
  }
}
