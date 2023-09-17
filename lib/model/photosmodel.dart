class PhotosModel{
  String imgsrc;
  String photoname;
  PhotosModel({
required this.imgsrc,required this.photoname
  });
  static PhotosModel FromApiToApp(Map<String,dynamic> photomodel){
    return PhotosModel(imgsrc:(photomodel["src"])["portrait"] , photoname: photomodel["photographer"]);

  }

}