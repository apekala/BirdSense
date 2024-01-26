import 'package:bird_sense/application/markers/bloc/markers_bloc.dart';
import 'package:bird_sense/data/model/color.dart';
import 'package:bird_sense/presentation/bird_page/history.dart';
import 'package:bird_sense/presentation/bird_page/migration.dart';
import 'package:bird_sense/presentation/bird_page/reacent.dart';
import 'package:bird_sense/presentation/test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

class BirdPage extends HookWidget {
  const BirdPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState(0);
    void onItemTapped(int index) {
      selectedIndex.value = index;
    }

    
    return BlocBuilder<MarkersBloc, MarkersState>(
      builder: (context, state) {
        
        if(state is MarkersLoaded){
          
          final screens = [
           ReacentBirds(devEUI: state.devEui,),
           HistoryPage(devEUI: state.devEui,),
           MigrationPage(devEUI: state.devEui,),
        ];
        return DefaultTabController(
            length: 3,
            child: Scaffold(
              body: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverOverlapAbsorber(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context),
                      sliver: SliverSafeArea(
                        top: false,
                        sliver: SliverAppBar(
                            toolbarHeight: 150,
                            elevation: 0,
                            backgroundColor: BSColors.backgroundColor,
                            pinned: true,
                            floating: true,
                            // snap: true,
                            forceElevated: innerBoxIsScrolled,
                            bottom: TabBar(
                              onTap: onItemTapped,
                              labelColor: BSColors.secondaryColor,
                              indicatorColor: BSColors.primaryColor,
                              tabs: const [
                                Tab(icon: Icon(Icons.recent_actors)),
                                Tab(icon: Icon(Icons.history)),
                                Tab(icon: Icon(Icons.menu_book)),
                              ],
                            ),
                            title: Center(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Bird',
                                  style: TextStyle(
                                      color: BSColors.primaryColor,
                                      fontSize: 25,
                                      fontStyle: FontStyle.italic),
                                ),
                                Image.asset(
                                  'assets/birdSense(2).png',
                                  height: 150,
                                ),
                                Text(
                                  'Sense',
                                  style: TextStyle(
                                      color: BSColors.primaryColor,
                                      fontSize: 25,
                                      fontStyle: FontStyle.italic),
                                )
                              ],
                            ))),
                      ),
                    ),
                  ];
                },
                body: TabBarView(children: screens),
              ),
            ));
        }
        else{
          return(const Center());
        }
      },
    );
  }
}
