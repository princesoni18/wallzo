import 'package:flutter/material.dart';
import 'package:wallzo/model/photosmodel.dart';

import '../../../model/apioperation.dart';

class wallpapers extends StatefulWidget {
  const wallpapers({
    super.key,
  });

  @override
  State<wallpapers> createState() => _wallpapersState();
}

class _wallpapersState extends State<wallpapers> {
 late List<PhotosModel> walls=[];
  void GetTrending()async{
 walls=await ApiOperation.TrendingWallpappers();
 setState(() {
   
 });
  }
   @override

  void initState() {
    // TODO: implement initState
    GetTrending();
    super.initState();
  }
  Widget build(BuildContext context) {
    return GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
    mainAxisExtent: 350,
               
    
            
        
        
    ),
    itemCount: walls.length,
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    

    
    
     itemBuilder: (context, index) => Container(
      width: 50,
      margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
          decoration: BoxDecoration(
            color: Colors.amberAccent,
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
            child: Image.network(walls[index].imgsrc,
            fit: BoxFit.cover,
            ),
          ),
           
          
          
                     ),
        );
  }
}