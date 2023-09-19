import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wallzo/model/photosmodel.dart';

class ApiOperation{
 static List<PhotosModel> trendwallpapers=[]; 
 static List<PhotosModel> searchwallpaperslist=[];
 static late  PhotosModel categorywallpaperlist;
 static Future<List<PhotosModel>> TrendingWallpappers()async{
  

await http.get(Uri.parse("https://api.pexels.com/v1/curated"),
headers:{ "Authorization":"}).then((value) {
  Map<String,dynamic> jsondata=jsonDecode(value.body);
  List photos=jsondata["photos"];
  photos.forEach((element) {
trendwallpapers.add(PhotosModel.FromApiToApp(element));

   });
  
});
return  trendwallpapers;
  }

  static Future<List<PhotosModel>>searchwallpapers(String query)async{

    await http.get(Uri.parse("https://api.pexels.com/v1/search?query=$query&per_page=25&page=1"),

headers:{ "Authorization":""}).then((value) {

  Map<String,dynamic> jsondata=jsonDecode(value.body);
  List photos=jsondata["photos"];
  searchwallpaperslist.clear();
  photos.forEach((element) {
searchwallpaperslist.add(PhotosModel.FromApiToApp(element));

   });
  
});
return  searchwallpaperslist;

  }

  static Future <PhotosModel> categorywallpapers(String query)async{

    await http.get(Uri.parse("https://api.pexels.com/v1/search?query=$query&per_page=1&page=1"),

headers:{ "Authorization":""}).then((value) {

  Map<String,dynamic> jsondata=jsonDecode(value.body);
  List photos=jsondata["photos"];
  
 
categorywallpaperlist= (PhotosModel.FromApiToApp(photos[0]));

   
  
});
return  categorywallpaperlist;

  }
}
