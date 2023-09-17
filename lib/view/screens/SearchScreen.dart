import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:wallzo/model/apioperation.dart';
import 'package:wallzo/model/photosmodel.dart';

import 'package:wallzo/view/screens/widgets/CustomAppBar.dart';


import 'fullscreenview.dart';

class SearchPage extends StatefulWidget {
  final String query;
  SearchPage ({super.key,required this.query});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isloading=true;
  bool resultfound=false;
  static final customCachemanager=CacheManager(
    Config('customCachekey',
    maxNrOfCacheObjects: 75,
    stalePeriod:const Duration(days: 3)
    )
    , 
  );

 late List<PhotosModel> searchresult=[];
 
  GetSearchResluts()async{
    try{
   searchresult= await ApiOperation.searchwallpapers(widget.query);}catch(e){
   
   }

   setState(() {
     isloading=false;
     
     if(searchresult.isEmpty){
     resultfound=true;}
   });
   
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetSearchResluts();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: CustomAppBar(),
        centerTitle: true,
        
      ),
      body:isloading?Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        LinearProgressIndicator(),

         


      Text("searching results for"),
      
      Text(widget.query)] )
       :SingleChildScrollView(
        child: Column(
          children: [
            Text("showing results for"),
      
           Text(widget.query),

          
      
            Padding(
             padding: const EdgeInsets.only(top: 15,bottom: 25),
              child: Container(
                
                
                
                
                
                
                child:resultfound?Column(
                  children: [

                    Center(
                      child: Container(
                        height: 300,
                        width: 360,
                              
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                               color: Colors.amber,
                               image:const  DecorationImage(image:AssetImage("images/taj_mahal.png",),fit: BoxFit.cover )
                              ),
                              child:
                      
                      const Center(
                        
                        child: Text(" ")),),

                    )
                    ,const Text("result not found.. ")
                  ],
                ) :GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
    mainAxisExtent: 350,
               
    
            
        
        
    ),
    itemCount: searchresult.length,
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    

    
    
     itemBuilder: (context, index) =>Hero(
      tag: searchresult[index].imgsrc,
       child: InkWell(
        onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => MyView(url:searchresult[index].imgsrc),));
          },
         child: Container(
          width: 50,
          margin: EdgeInsets.symmetric(horizontal: 7,vertical: 5),
              decoration: BoxDecoration(
                
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 139, 138, 138).withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // Adjust the shadow's position
          ),]
                
                           
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  cacheManager: customCachemanager,
                  
                  imageUrl: searchresult[index].imgsrc,fit: BoxFit.cover,),
                
                ),
              ),
               
              
              
                         ),
       ),
     ),
        ),
                 ),
            
            
            
      
          ],
        ),
      ),
    );
  }
}

