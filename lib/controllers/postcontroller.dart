import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import '../resources/enums.dart';
import 'commondashcontroller.dart';

class PostController extends GetxController {
  final commonDashController = Get.put(CommonDashController());
  var selectedFilter = AlbumFilter.recent.obs;
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
    thumbnails.assignAll(thumbs as Map<String, Uint8List>);

    selectedIndex.value = mediaList.isNotEmpty ? 0 : 0;
  }

  var selectedIndex = RxnInt();
  var mediaList = <AssetEntity>[].obs;
  Rx<AssetEntity> selectedMedia = AssetEntity(
    id: "",
    typeInt: 1,
    width: 0,
    height: 0,
    duration: 0,
  ).obs;

  var hasPermission = false.obs;
  var thumbnails = <String, Uint8List>{}.obs;

  @override
  void onInit() {
    super.onInit();
    checkPermissionAndFetch();
  }

  Future<void> checkPermissionAndFetch() async {
    final ps = await PhotoManager.requestPermissionExtend(
      requestOption: const PermissionRequestOption(
        iosAccessLevel: IosAccessLevel.readWrite,
      ),
    );

    hasPermission.value = ps.isAuth;

    if (ps.isAuth) {
      await fetchMedia();
    } else {
      await PhotoManager.openSetting();
    }
  }

  Future<void> fetchMedia() async {
    final albums = await PhotoManager.getAssetPathList(type: RequestType.common);

    if (albums.isEmpty) {
      mediaList.clear();
      thumbnails.clear();
      selectedIndex.value = -1;
      return;
    }

    final media = await albums.first.getAssetListPaged(page: 0, size: 100);
    mediaList.assignAll(media);

    if (media.isNotEmpty) {
      selectedMedia.value = media.first;
      selectedIndex.value = 0;
    } else {
      selectedIndex.value = -1;
    }

    thumbnails.clear();

    for (final asset in media) {
      final thumb = await asset.thumbnailDataWithSize(
        const ThumbnailSize(300, 300),
      ) ?? Uint8List(0);

      thumbnails[asset.id] = thumb;
    }
  }



  void selectMedia(int index) {
    if (index < 0 || index >= mediaList.length) return;
    selectedIndex.value = index;
    selectedMedia.value = mediaList[index];
  }
}
