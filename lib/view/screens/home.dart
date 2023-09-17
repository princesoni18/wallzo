
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:wallzo/view/screens/SearchScreen.dart';
import 'package:wallzo/view/screens/fullscreenview.dart';

import 'package:wallzo/view/screens/widgets/CustomAppBar.dart';



import '../../model/apioperation.dart';
import '../../model/photosmodel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static final customCachemanager=CacheManager(
    Config('customCachekey',
    maxNrOfCacheObjects: 75,
    stalePeriod:const Duration(days: 3)
    )
    , 
  );
  
  bool isloading=true;
   List <String> category=["cars","nature","beach","superbike","city","abstract","pokemon"];
  
  late List<PhotosModel> walls=[];
  late PhotosModel banner;
  late List<PhotosModel> categorylist=[];
  void GetTrending()async{
 walls=await ApiOperation.TrendingWallpappers();
 
 for(int i=0;i<category.length;i++){
  banner=await ApiOperation.categorywallpapers(category[i]);
  categorylist.add(banner);
 
 }
 setState(() {
   isloading=false;
 });
  }
  @override

  void initState(){
    // TODO: implement initState
     GetTrending();
    super.initState();
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
      body:  SingleChildScrollView(
        child: Column(
          children: [
      SizedBox(
        height:5,
      ),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
              child: CupertinoSearchTextField(
                
                placeholder: "search latest wallpapers ",
                placeholderStyle: TextStyle(
                  color: Color.fromARGB(255, 126, 128, 135)
                ),
                
                onSubmitted: (value) {
                  if(value.trim().isNotEmpty){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage(query: value),));
                  }
                },
                
                
              ),
            ),
           
               Padding(
                 padding: const EdgeInsets.only(left: 10,top: 10),
                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                   children: [
                     Text(
                      "Categories :",
                      style: TextStyle(
                        
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                      ),
                             ),
                   ],
                 ),
               ),
            
           
          
            
              Padding(
                padding: const EdgeInsets.only(top: 10,bottom: 10),
                child: SizedBox(
                  
                  height: 170,
                  child:isloading?Container(): ListView.builder(itemBuilder:( (context, index) => InkWell(
                        
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage(query:category[index] ),));
                        },
                        child: Container(
                            height: 120,
                            width: 260,
                            
                            
                            decoration: BoxDecoration(
                              image: DecorationImage(image: CachedNetworkImageProvider(categorylist[index].imgsrc),fit: BoxFit.cover),
                              
                              
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 139, 138, 138).withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3), // Adjust the shadow's position
                                ),]
                            ),
                           margin: EdgeInsets.symmetric(horizontal: 10,vertical: 7),
                          
                            child: Center(child: Text(category[index],style: TextStyle(
                              fontFamily: GoogleFonts.actor().fontFamily,
                              color:  Colors.white,
                              fontSize: 35,
                              fontWeight: FontWeight.w600
                            ),)),
                          ),
                      )
                      
                
                            ),itemCount: category.length,scrollDirection: Axis.horizontal,),
                ),
              ),










             const Padding(
                 padding: const EdgeInsets.only(left: 12,bottom: 15),
                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                   children: [
                     Text(
                      "Trending :",
                      style: TextStyle(
                        
                        fontSize: 22,
                        fontWeight: FontWeight.w500
                      ),
                             ),
                             
                   ],
                 ),
               ),
      
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Container(
               
                
                
                
                
                
                child:  GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
    mainAxisExtent: 350,
               
    
            
        
        
    ),
    itemCount: walls.length,
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    

    
    
     itemBuilder: (context, index) => Hero(
      tag:walls[index].imgsrc ,
       child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MyView(url:walls[index].imgsrc),));
        },
         child: Container(
          width: 50,
          margin: EdgeInsets.symmetric(horizontal: 7,vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
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
                  imageUrl: walls[index].imgsrc,fit: BoxFit.cover,
                  )   
                // fit: BoxFit.cover,
                // ),
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

