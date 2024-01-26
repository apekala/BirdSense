

// import 'package:bird_sense/application/markers%20copy/bloc/markers_bloc.dart';
// import 'package:bird_sense/application/markers/bloc/markers_bloc.dart';
// import 'package:bird_sense/data/model/color.dart';
// import 'package:bird_sense/presentation/bottom_bar.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';

// class MapPage extends HookWidget {
//   const MapPage({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
    
//     var _mapController = MapController();
//     var addState = useState(false);
//     var moveState = useState(false);
//     var positionState = useState(const LatLng(0, 0));
//     var indexState = useState(0);
//     var replaceMarkerState = useState(false);
    
//     List istapped = [];
//     MarkersBlocCopy().add(MarkersAdd(marker: const LatLng(52.21769884997918, 21.01443708154715)));
    

    


//     return BlocBuilder<MarkersBlocCopy, MarkersStateCopy>(
//         builder: (context, state) {
          
//           // context.read<MarkersBloc>().add(MarkersAdd(marker: LatLng(52.21769884997918, 21.01443708154715)));
//           // print(state);
//           if (state is MarkersCopyLoaded){
            
//               if (state.markers.isEmpty){
//                     context.read<MarkersBlocCopy>().add(MarkersAdd(marker: const LatLng(52.21769884997918, 21.01443708154715)));
      
      
//               }
//               if(state.markers.isNotEmpty){
//             for (var i = 0; i < state.markers.length; i++) {
//               istapped.add(false);
//             } 
//             }
           
            
      
//           return Scaffold(
            
//             floatingActionButton: addState.value ? null : FloatingActionButton(onPressed: () {
//               addState.value = true;
              

              
//             },
//             backgroundColor: BSColors.buttonColor,
//             child: const Icon(Icons.add,),

            
//             ),
            
//             body: Stack(
//               children: [
//              FlutterMap(
//                 mapController: _mapController,
//                 options: MapOptions(
//                   initialCenter: const LatLng(52.21769884997918, 21.01443708154715),
//                   initialZoom: 13.0,
//                   onMapEvent: (p0) {
//                     if(p0 is MapEventMove){
//                       moveState.value = true;
//                     }
//                     if(p0 is MapEventMoveEnd){
//                       moveState.value = false;
                       
//                     }
                    
                    
//                   },
//                   onPositionChanged: (position, hasGesture) {
//                       positionState.value = position.center!;
                    
//                   },
//                 ),
//                 children: [
//                   TileLayer(
                    
//                     urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//                     userAgentPackageName: 'com.example.app',
//                     subdomains: const ['a', 'b', 'c'],
//                   ),
//                   MarkerLayer(markers: [
//                       for(int index = 0; index <state.markers.length; index++)
//                       Marker(
//                          width: 120.0,
//                          height: 140.0,
//                         point: state.markers[index],
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                               istapped[index] ? Container(
//                                 padding: const EdgeInsets.only(left: 5,right: 5),
//                                 width: 106,
//                                 height: 40,
//                                 decoration: BoxDecoration(
//                                   color: BSColors.backgroundColor,
//                                   borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  
//                                   ),
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       IconButton(
//                                         onPressed: () {
//                                            addState.value = true;
//                                            indexState.value = index;
//                                            replaceMarkerState.value = true;

//                                         },
//                                         splashRadius: 1,
//                                         iconSize: 20,
//                                         icon: 
//                                         const Icon(
//                                           Icons.settings,
//                                           // size: 10,
                                        
//                                         ),
//                                       ),
//                                       IconButton(
//                                         splashRadius: 5,
//                                         iconSize: 20,
//                                         color: Colors.black,                                      
//                                         onPressed:() {
//                                           context.read<MarkersBlocCopy>().add(MarkersRemove(marker: state.markers[index]));
//                                           istapped[index] = false;
//                                         }, 
//                                         icon: const Icon(Icons.delete,
//                                         ))
//                                     ],
                    
//                                   ),
//                               ) : const SizedBox(),
//                             IconButton(
//                               onPressed: addState.value?(){}:() {
                                
//                                  istapped[index] = true;
//                                 for(var i=0; i<istapped.length; i++){
//                                   if(i!=index){
//                                     istapped[i] = false;
//                                   }
//                                 }
//                                  context.read<MarkersBlocCopy>().add(MarkersRefresh());
                                
                                
//                               },
//                               icon: const Icon(
//                               Icons.place,
//                               color: Colors.blueAccent,
//                               size: 40,
//                                                   ),
//                             ),
//                             istapped[index] ? const SizedBox(height: 40,): const SizedBox(),
//                           ],
//                         )
//                         )
                    
//                   ])
//                 ],
//               ),
//               addState.value ?
//               Align(
//                 alignment: Alignment.center,
//                 child: Icon(Icons.pin_drop_sharp,
//                 color: moveState.value ? Colors.blueGrey : BSColors.primaryColor,
//                 size: 30,
//                  ),
                
//               )
              
              
//               :const SizedBox(),




//               addState.value ?
//               Align(
//                 alignment: const Alignment(0, 0.9),
//                 child: GestureDetector(
//                   onTap: () {
//                     if(moveState.value == false){
//                     addState.value  = false;
//                     if(replaceMarkerState.value ){
//                       // context.read<MarkersBlocCopy>().add(MarkersChange(marker: positionState.value, index: indexState.value));

//                       replaceMarkerState.value = false;
//                     }
//                     else{     
//                     context.read<MarkersBlocCopy>().add(MarkersAdd(marker: positionState.value ));
//                     }

//                     }
//                   },
//                   child: Container(
                    
//                     width: 170,
//                     height: 60,
//                     decoration: BoxDecoration(
//                       color: BSColors.buttonColor,
//                       borderRadius: const BorderRadius.all(Radius.circular(20))
                      
//                     ),
//                     child: Center(
//                       child: Text('Save',
//                       style: TextStyle(
//                         color: BSColors.textColor,
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold
//                       ),
//                       )
//                     ),
                                
//                                 ),
//                 ),
//               )
//               : const SizedBox()
              
//               ]
//             ),
            
//           );
//           }
//           else{
//             return const Center(child: CircularProgressIndicator(),);
//           }
//         },
//       );
    
//   }
// }
