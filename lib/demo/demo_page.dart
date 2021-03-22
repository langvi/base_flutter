import 'package:base_flutter/base/widgets/base_stateful.dart';
import 'package:base_flutter/demo/bloc/demo_bloc.dart';
import 'package:base_flutter/person/person_page.dart';
import 'package:base_flutter/utils/custom_tab.dart';
import 'package:base_flutter/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DemoPage extends StatefulWidget {
  DemoPage({Key key}) : super(key: key);

  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends BaseStatefulWidget<DemoPage, DemoBloc>
    with SingleTickerProviderStateMixin {
  int count = 0;
  TabController _tabController;
  Color colorActive = Colors.blue;
  Color colorUnActive = Colors.white;
  int _currentIndex = 0;
  Animation<double> animation;
  @override
  void initBloc() {
    _tabController = TabController(length: 4, vsync: this);
    animation = ChangeAnimation(_tabController);

    bloc = DemoBloc();
    _tabController.addListener(() {
      _currentIndex = _tabController.index;
setState(() {
  
});
      // bloc.updateState();
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void baseListener(BuildContext context, state) {
    if (state is Loading) {
      showLoading();
    } else if (state is Empty) {
      showEmpty();
    } else if (state is Success) {
      count++;
      showBody();
    }
  }

  @override
  PreferredSizeWidget buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('Demo base flutter'),
    );
  }

  @override
  Widget buildEmptyPage(BuildContext context) {
    return Center(
      child: Text('Empty...'),
    );
  }

  @override
  Widget buildLoading(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DefaultTabController(
            length: 4,
            initialIndex: _currentIndex,
            child: Column(
              children: [
                TabBar(
                    labelColor: colorActive,
                    unselectedLabelColor: colorUnActive,
                    controller: _tabController,
                    indicator: null,
                    indicatorColor: Colors.transparent,
                    tabs: [
                      ItemTab(
                        animation: animation,
                        isSelected: _currentIndex == 0,
                        currentIndex: _currentIndex,
                        itemIndex: 0,
                        offset: _tabController.offset,
                      ),
                      ItemTab(
                        animation: animation,
                        isSelected: _currentIndex == 1,
                        currentIndex: _currentIndex,
                        itemIndex: 1,
                        offset: _tabController.offset,
                      ),
                      ItemTab(
                        animation: animation,
                        isSelected: _currentIndex == 2,
                        currentIndex: _currentIndex,
                        itemIndex: 2,
                        offset: _tabController.offset,
                      ),
                      ItemTab(
                        animation: animation,
                        isSelected: _currentIndex == 3,
                        currentIndex: _currentIndex,
                        itemIndex: 3,
                        offset: _tabController.offset,
                      ),

                      // Tab(
                      //   icon: Container(
                      //       padding: EdgeInsets.all(8),
                      //       decoration: BoxDecoration(
                      //           shape: BoxShape.circle, border: Border.all()),
                      //       child: SvgPicture.asset(
                      //         'images/icon_active.svg',
                      //         color: _currentIndex == 0
                      //             ? colorActive
                      //             : colorUnActive,
                      //       )),
                      // ),
                      // Tab(
                      //   icon: Container(
                      //       padding: EdgeInsets.all(8),
                      //       decoration: BoxDecoration(
                      //           shape: BoxShape.circle, border: Border.all()),
                      //       child: SvgPicture.asset(
                      //         'images/icon_active.svg',
                      //         color: _currentIndex == 1
                      //             ? colorActive
                      //             : colorUnActive,
                      //       )),
                      // ),
                      // Tab(
                      //   icon: Container(
                      //       padding: EdgeInsets.all(8),
                      //       decoration: BoxDecoration(
                      //           shape: BoxShape.circle, border: Border.all()),
                      //       child: SvgPicture.asset(
                      //         'images/icon_active.svg',
                      //         color: _currentIndex == 2
                      //             ? colorActive
                      //             : colorUnActive,
                      //       )),
                      // ),
                      // Tab(
                      //   icon: Container(
                      //       padding: EdgeInsets.all(8),
                      //       decoration: BoxDecoration(
                      //           shape: BoxShape.circle, border: Border.all()),
                      //       child: SvgPicture.asset(
                      //         'images/icon_active.svg',
                      //         color: _currentIndex == 3
                      //             ? colorActive
                      //             : colorUnActive,
                      //       )),
                      // ),
                    ]),
                Container(
                  height: 300,
                  child: TabBarView(controller: _tabController, children: [
                    Center(child: Text('Home')),
                    Center(child: Text('Account')),
                    Center(child: Text('Notification')),
                    Center(child: Text('Message')),
                  ]),
                )
              ],
            ),
          )
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 20),
          //   child: Text('Value count = $count'),
          // ),
          // RaisedButton(
          //   onPressed: () {
          //     bloc.add(Counter());
          //   },
          //   child: Text('Count'),
          // ),
          // RaisedButton(
          //   onPressed: () {
          //     navToScreenWithTransition(context: context, toPage: PersonPage());
          //   },
          //   child: Text('To Screen >'),
          // )
        ],
      ),
    );
  }
}
