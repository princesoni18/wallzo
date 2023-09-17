import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';

class MyView extends StatefulWidget {
  final String url;
 const  MyView({super.key, required this.url});

  @override
  State<MyView> createState() => _MyViewState();
}

class _MyViewState extends State<MyView> {
  Future<void> setwallpaper(String url, BuildContext context) async {
    try {
      int location = WallpaperManager.HOME_SCREEN;
      var file = await DefaultCacheManager().getSingleFile(url);

      await WallpaperManager.setWallpaperFromFile(file.path, location);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("wallpaper set successfully"),
      ));
    } on PlatformException catch (value) {
      
       ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("failed to set wallpaper")));
    }
  }
  Future<void> setlockscreen(String url, BuildContext context) async {
    try {
      int location = WallpaperManager.LOCK_SCREEN;
      var file = await DefaultCacheManager().getSingleFile(url);

      await WallpaperManager.setWallpaperFromFile(file.path, location);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        
        content: Text("wallpaper set successfully"),
      ));
    } on PlatformException catch (value) {
      
       ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("failed to set wallpaper")));
    }
  }
  Future<void> setBoth(String url, BuildContext context) async {
    try {
      int location = WallpaperManager.BOTH_SCREEN;
      var file = await DefaultCacheManager().getSingleFile(url);

      await WallpaperManager.setWallpaperFromFile(file.path, location);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("wallpaper set successfully"),
      ));
    } on PlatformException catch (value) {
      
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("failed to set wallpaper")));
    }
  }

  Future<void> setwallpaperfromfile(String imgurl, BuildContext context) async {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("downloading..")));
    try {
      var imgid = FileDownloader.downloadFile(
        url: widget.url,
        onDownloadError: (errorMessage) {
          
        },
      );

      if (imgid == Null) {
        return;
      }

      //var path=await ImageDownloader.findPath(imgid);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("downloaded successfully")));
    } on PlatformException catch (error) {
      
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("downloaded failed due to some error")));
    }
  }
static final customCachemanager=CacheManager(
    Config('customCachekey',
    maxNrOfCacheObjects: 75,
    stalePeriod:const Duration(days: 3)
    )
    , 
  );
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(image:CachedNetworkImageProvider(
              cacheManager:customCachemanager,
              widget.url) 
            , fit: BoxFit.cover),
          ),
        ),
        Positioned(
            left: MediaQuery.of(context).size.width*0.24,
            top: MediaQuery.of(context).size.height*0.9,
            child: Row(
              children: [
                Container(
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: IconButton(
                      onPressed: () {
                        setwallpaperfromfile(widget.url, context);
                      },
                      icon: const Icon(
                        Icons.download_outlined,
                        color: Colors.black,
                        size: 30,
                      )),
                ),
               const SizedBox(
                  width: 15,
                ),
                Container(
                  height: 45,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.white.withOpacity(0.85)),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Apply"),
                            content: SizedBox(
                              height: 180,
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: ()async{
                                      await setwallpaper(widget.url, context);
                                      Navigator.pop(context);
                                    } ,
                                    child: const ListTile(
                                      title: Text("set as Home Screen"),
                                      trailing: Icon(
                                       Icons.check_box_outline_blank_rounded) 
                                    ),
                                  ),



                                  InkWell(
                                    onTap: ()async{
                                      await setlockscreen(widget.url, context);
                                      Navigator.pop(context);
                                    } ,

                                    child: const ListTile(
                                      title: Text("set as Lock Screen"),
                                      trailing:Icon(Icons.check_box_outline_blank_rounded) 
                                    ),
                                  ),




                                  InkWell(
                                    onTap: ()async{
                                      await setBoth(widget.url, context);
                                      Navigator.pop(context);
                                    } ,
                                    child: const ListTile(
                                      title: Text("set as Both"),
                                      trailing:Icon(Icons.check_box_outline_blank_rounded) 
                                    ),
                                  ),
                                  
                                    
                                  
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: const Text(
                      "set as wallpaper",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ))
      ]),
    );
  }
}
