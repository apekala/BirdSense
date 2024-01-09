

import 'package:bird_sense/application/reacentBirds/bloc/reacent_birds_bloc.dart';
import 'package:bird_sense/application/reacentBirds/reacentBirdsEntity.dart';
import 'package:bird_sense/data/model/color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scroll_to_top/flutter_scroll_to_top.dart';


class ReacentBirds extends HookWidget {
  const ReacentBirds({
    super.key,
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
    var after =  DateTime.now().toUtc().millisecondsSinceEpoch / 1000 - 2*24*60*60;
    var loaded = false;
    var  _controller = ScrollController();
    
      

       return BlocBuilder<ReacentBirdsBloc, ReacentBirdsState>(
      builder: (context, state) {
        final birds = getBirds3(from: state);
        final now = DateTime.now().toUtc().millisecondsSinceEpoch / 1000;
        if(birds?.isNotEmpty ?? false){
            if(birds!.length < 12){
              loaded = false;
              after = after - 2*24*60*60;
              BlocProvider.of<ReacentBirdsBloc>(context).add(ReacentBirdsCount(after: after.toInt(), before: now.toInt()));
          }
          else{
            loaded = true;
          }
          }
        
        if(state is ReacentBirdsLoaded && loaded){
          return Scaffold(
            body: RefreshIndicator(
              onRefresh: () async {BlocProvider.of<ReacentBirdsBloc>(context).add(ReacentBirdsCount(after: after.toInt(), before: now.toInt()));},
              triggerMode: RefreshIndicatorTriggerMode.anywhere,
        
              child: ScrollWrapper(
                promptTheme: PromptButtonTheme(
                  color: BSColors.buttonColor,
                  elevation: 10,
                  
                ),
                promptAnimationCurve:Curves.fastOutSlowIn,
                
                
                  builder: (context,properties) {
                  return ListView.builder(
                    controller: _controller,
                    itemCount: birds?.length,
                    itemBuilder: (context, index) {
                      
                           
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
                                            after = after - 2*24*60*60;
                                            BlocProvider.of<ReacentBirdsBloc>(context).add(ReacentBirdsCount(after: after.toInt(), before: now.toInt()));
                                            // _scrollDown();
                                            _controller = ScrollController(
                                              initialScrollOffset: _controller.position.maxScrollExtent
                                              );
                                          },
                                          )
                                   
                                    :
                                    const SizedBox()
                          ],
                        ),
                      );
                    });
                }
              ),
            ),
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
