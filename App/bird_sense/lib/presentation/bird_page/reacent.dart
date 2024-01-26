

import 'dart:async';

import 'package:bird_sense/application/reacentBirds/bloc/reacent_birds_bloc.dart';
import 'package:bird_sense/application/reacentBirds/controller/bloc/controller_bloc.dart';
import 'package:bird_sense/application/reacentBirds/reacentBirdsEntity.dart';
import 'package:bird_sense/data/model/color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scroll_to_top/flutter_scroll_to_top.dart';
import 'package:quiver/strings.dart';


class ReacentBirds extends HookWidget {
  final String devEUI;
  const ReacentBirds({
    super.key, required this.devEUI
  });

  List<ReacentBirdsEntity>? getBirds3({required ReacentBirdsState from}) {
    final state = from;

    if (state is ReacentBirdsLoading) {
      
      return state.lastBirds;
    }

    if (state is ReacentBirdsLoaded) {
      
      return state.reacentBirds;
    }
    
    return null;
  }

  




  @override
  Widget build(BuildContext context) {
    var after =  DateTime.now().toUtc().millisecondsSinceEpoch / 1000 + DateTime.now().timeZoneOffset.inSeconds - 2*24*60*60;
   
    var loaded = false;
    var  _controller = ScrollController(      
    );
    
     
    var birdsLenght =  0;
    
    var request = 0;
    var isEmpty = 0;
    
    
    var countControler = 0;

    
    _scrollListener() {
      if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      
        print("reach the bottom");
        BlocProvider.of<ControllerBloc>(context).add(ControllerAddEvent(controllerAddState: true));
      
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
          countControler = 2;
          
        print("reach the top");
        BlocProvider.of<ControllerBloc>(context).add(ControllerAddEvent(controllerAddState: false));
      
    }
    //  if (_controller.offset >= _controller.position.maxScrollExtent / birdsLenght2 &&
    //     !_controller.position.outOfRange) {
      
    //     print("reach the bottom");
    //     BlocProvider.of<ControllerBloc>(context).add(ControllerAddEvent(controllerAddState: true));
      
    // }
 }
 _controller.addListener(_scrollListener);


       return BlocBuilder<ReacentBirdsBloc, ReacentBirdsState>(
      builder: (context, state) {
        
        
        final birds = getBirds3(from: state);
        
        final now = DateTime.now().millisecondsSinceEpoch / 1000 + DateTime.now().timeZoneOffset.inSeconds;
        
        // print('length: ${birds?.length}');
        // print("isEmpty: $isEmpty");
        if(birds?.isNotEmpty ?? false){
           
            if(birds!.length < 9 || (birdsLenght == birds.length && request < 10)){
              //  print('b');
              loaded = false;
              
              after = after - 2*24*60*60;
              BlocProvider.of<ReacentBirdsBloc>(context).add(ReacentBirdsCount(after: after.toInt(), before: now.toInt(),devEUI: devEUI));
              request += 1;
              
          }
          else{
            loaded = true;
            // request = 0;
            isEmpty = 0;
            //  print('c');
            
          }
          }
        else if(isEmpty < 15){
              after = after - 2*24*60*60;
              BlocProvider.of<ReacentBirdsBloc>(context).add(ReacentBirdsCount(after: after.toInt(), before: now.toInt(),devEUI: devEUI));
              //  print('d');
               isEmpty += 1;
        }
        // print(request);
        else{
          return Center(child: Text('No birds'),);
        }
        
        if(state is ReacentBirdsLoaded && loaded){
          
          // print(birds?.length);
          
           
          return 
            RefreshIndicator(
              onRefresh: () async {BlocProvider.of<ReacentBirdsBloc>(context).add(ReacentBirdsCount(after: after.toInt(), before: now.toInt(),devEUI: devEUI));},
              triggerMode: RefreshIndicatorTriggerMode.onEdge,
                  
              child: 
                  SafeArea(
                    top:false,
                    bottom: false,

                    child: BlocBuilder<ControllerBloc,ControllerState>(
                      builder: (contextController, state) {
                         
                         if(state is ControllerLoaded){
                          
                         
                         
                        return CustomScrollView(
                          controller: state.controlerState ? _controller : null,
                          
                          
                          
                          slivers:[ 
                            SliverOverlapInjector(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(contextController)),
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                
                                
                                
                                childCount: birds?.length,
                                (context, index) {
                                  // print(controller.position.maxScrollExtent );
                                  // print(index);
                                  if (index == 9 && countControler == 0) {
                                    countControler = 1;
                                    if (state.controlerState){
                                    contextController.read<ControllerBloc>().add(ControllerAddEvent(controllerAddState: false));
                                    }
                                    else{
                                      contextController.read<ControllerBloc>().add(ControllerAddEvent(controllerAddState: true));
                                    }
                                    

                                  }
                                   
                                  //  print(index);
                                  if(_controller.hasClients && countControler == 2){
                                  countControler = 0;
                                  
                                  }
                                  // print(controller);
                                  

                                  // print(controlertate);
                             
                              
                                
                                     
                                return Center(
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(5),
                                        width: 350.0,
                                        height: 100.0,
                                        decoration: BoxDecoration(
                                          color: BSColors.backgroundColor,
                                          borderRadius: BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color: BSColors.secondaryColor,
                                              // spreadRadius: 1,
                                              blurRadius: 5,
                                              offset: const Offset(
                                                  3, 3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              birds?[index].species ?? '',
                                              style: TextStyle(
                                                  fontSize: 23,
                                                  fontWeight: FontWeight.bold,
                                                  color: BSColors.textColor),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            
                                            Text(
                                              'Accuracy: ${(100 * (birds?[index].confidence ?? 0)).round()}% ',
                                              style: TextStyle(
                                                color: BSColors.secondaryColor,
                                                fontSize: 12,
                                              ),
                                              textAlign: TextAlign.justify,
                                            ),
                                            Text(
                                              'Time: ${formatDuration(Duration(seconds: (now - (birds?[index].time ?? 0)).toInt()))}',
                                              style: TextStyle(
                                                color: BSColors.secondaryColor,
                                                fontSize: 11,
                                              ),
                                              textAlign: TextAlign.right,
                                            ),
                                             
                                            
                                          ],
                                        ),
                                      ),
                                        

                                        

                                        
                                       index == birds!.length - 1 ? 
                                       const SizedBox(height: 10,) : const SizedBox(),
                                       index == birds.length - 1 ?
                                              GestureDetector(
                                              child: const SizedBox(
                                                height: 30,
                                              width: 350,
                                                child: Center(
                                                  child: 
                                                  Icon(
                                                    Icons.keyboard_double_arrow_down
                                                    )
                                                    )
                                                    ),
                                                    onTap: () {
                                                      request = 0;
                                                      after = after - 2*24*60*60;
                                                      BlocProvider.of<ReacentBirdsBloc>(context).add(ReacentBirdsCount(after: after.toInt(), before: now.toInt(),devEUI: devEUI));
                                                      
                                                      
                                                      _controller = ScrollController(
                                                        initialScrollOffset: _controller.position.maxScrollExtent
                                                        );
                                                         
                                                        
                                                        birdsLenght = birds.length;
                                                    },
                                                    )
                                             
                                              :
                                              const SizedBox()
                                    ],
                                  ),
                                );
                              
                                }
                                
                                            ),
                        
                            ),
                          ]
                        );
                        
                         }
                         else{
                          return const Center(child: CircularProgressIndicator(),);
                         }
                      }
                    ),
                  )
                // }
              // ),
            
          );
       
        }
        else{
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  String formatDuration(Duration duration) {
    if (duration.inDays > 0) {
      return '${duration.inDays} day(s), ${duration.inHours - duration.inDays * 24} hour(s), ${duration.inMinutes - (duration.inHours - duration.inDays * 24) * 60 - duration.inDays * 24 * 60} minute(s) and ${duration.inSeconds - duration.inMinutes * 60} second(s) ago';
    } else if (duration.inHours > 0) {
      return '${duration.inHours} hour(s), ${duration.inMinutes - duration.inHours * 60} minute(s) and ${duration.inSeconds - duration.inMinutes * 60} second(s) ago';
    } else if (duration.inMinutes > 0) {
      return '${duration.inMinutes} minute(s) and ${duration.inSeconds - duration.inMinutes * 60} second(s) ago';
    } else if (duration.inSeconds > 0) {
      return '${duration.inSeconds} second(s) ago';
    } else {
      return 'Now';
    }
  }
}
