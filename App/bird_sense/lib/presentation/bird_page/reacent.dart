import 'dart:async';

import 'package:bird_sense/data/birds/model/birds_model.dart';
import 'package:bird_sense/data/core/client.dart';
import 'package:bird_sense/data/model/color.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:timer_builder/timer_builder.dart';

class ReacentBirds extends HookWidget{
   const ReacentBirds({
    super.key, 
    });
     
  Future<List<BirdModel>?> getBirds() async {
      Client birds =
          Client();
      final data = await birds.getBirds('1702985548');
      print(data);
      
      return data;
    }
    Future<void> getBirds2() async{
      var data=getBirds();



    }
  @override
   Widget build(BuildContext context) {
    
    Timer? timer;
    // useMemoized(() {
    //  getBirds();
    //   timer = Timer.periodic(Duration(seconds: 5), (Timer t) => getBirds());
    // });
    var future = useMemoized(getBirds);
    final snapshot = useFuture(future);
    var isLoaded = useState(false);
    // var data = useState(snapshot);
    
    
      if(snapshot.data != null){
        isLoaded = useState(true);
        print(snapshot.data);
      
      
    };
   return TimerBuilder.periodic(

    Duration(seconds: 5),
      alignment: Duration(seconds: 5),
      builder: (context) {
        
      
     return Scaffold(
      body: RefreshIndicator(
        onRefresh: getBirds2,
        child: Visibility(
          visible: isLoaded.value,
          replacement: const Center(child: CircularProgressIndicator()),
          child: ListView.builder(
            itemCount: snapshot.data?.length,
          itemBuilder: (context, index)
          {
            final now = DateTime.now().toUtc().millisecondsSinceEpoch/1000;
            
            print(now);
            
            return Center(
                        child: Column(
                          children: [
                            const SizedBox(height: 15,),
                            Container(
                              padding: EdgeInsets.all(5),
                              width: 350.0,
                              height: 100.0,
                              decoration: BoxDecoration(
                                color: BSColors.backgroundColor,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow:  [
                                  BoxShadow(
                                    color: BSColors.secondaryColor,
                                    // spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: Offset(3, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(snapshot.data![index].species,
                                  style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                  color: BSColors.textColor
                                  ),
                                  ),
                                  const SizedBox(height: 15,),
                                  Text(
                                    'Accuracy: ${(snapshot.data![index].confidence *100).toInt()}% ',
                                    style:  TextStyle(
                                      color: BSColors.secondaryColor,
                                      fontSize: 12,
                                    ),
                                    textAlign:TextAlign.justify,
                                  ),
                                  Text('Time: ${formatDuration(Duration(seconds: (now - snapshot.data![index].time).toInt()))}',
                                  style:  TextStyle(
                                      color: BSColors.secondaryColor,
                                      fontSize: 12,
                                    ),
                                    textAlign:TextAlign.right,
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
          }
          ),
        ),
      ),
     );
      }
   );
  }
  String formatDuration(Duration duration) {
    if (duration.inDays>0) {
      return '${duration.inDays} day(s), ${duration.inHours - duration.inDays*24} hour(s), ${duration.inMinutes - (duration.inHours - duration.inDays*24)*60 - duration.inDays*24*60} minute(s) and ${duration.inSeconds - duration.inMinutes*60} second(s) ago';
    }
    else if (duration.inHours > 0) {
    return '${duration.inHours} hour(s), ${duration.inMinutes - duration.inHours*60} minute(s) and ${duration.inSeconds - duration.inMinutes*60} second(s) ago';    
    }
    else if (duration.inMinutes>0) {
    return '${duration.inMinutes} minute(s) and ${duration.inSeconds - duration.inMinutes*60} second(s) ago';    
    }
    else if (duration.inSeconds>0) {
    return '${duration.inSeconds} second(s) ago';    
    }
    else {
      return 'Now';
    }
  }

}