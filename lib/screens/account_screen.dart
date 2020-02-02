import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class AccountScreen extends StatefulWidget {
 
 static const String id = 'account_screen';

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: true,
      backgroundColor: Color(0xff013243),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            // expandedHeight: 200,
            // backgroundColor: Color(0xff013243),
            // floating: false,
            // title: Text('Petr the Anteatr'),
            floating: true,
            pinned: true,
            delegate: CustomSliverDelegate(
              expandedHeight: 150,
            ),
          ),
          SliverFixedExtentList(
            itemExtent: 1350.0,
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: EdgeInsets.only(top: 25),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(10),
                        ),
                        Container(
                          height: 40,
                          width: 400,
                          child: Padding(
                            padding: EdgeInsets.only(left: 20),
                            //PUT PROFILE NAME HERE
                            child: Text(
                              'Peter Anteater',
                              style: TextStyle(
                                fontFamily: "Poppins-Bold",
                                fontSize: ScreenUtil.getInstance().setSp(65),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 30,
                          width: 400,
                          child: Padding(
                            padding: EdgeInsets.only(left: 22),
                            child: Text(
                              //Location of User
                              'Irvine, CA',
                              style: TextStyle(
                                fontFamily: "Poppins-Medium",
                                fontSize: ScreenUtil.getInstance().setSp(35),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 65,
                          width: 400,
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Image.asset('assets/trash.png',
                                    height: 45, width: 45),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 15, right: 15),
                                child: Text(
                                  "3,462 Posts Cleaned Up",
                                  style: TextStyle(
                                    fontFamily: "Roboto-Bold",
                                    fontSize:
                                        ScreenUtil.getInstance().setSp(50),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                              color: Color(0xff1e8bc3),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(0, 5),
                                  blurRadius: 10,
                                )
                              ]),
                        ),
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(15),
                        ),
                        Container(
                          height: 40,
                          width: 400,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              'Community Impact',
                              style: TextStyle(
                                fontFamily: "Poppins-Bold",
                                fontSize: ScreenUtil.getInstance().setSp(50),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: (ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.asset(
                              '/Users/kingsleyszeto/hacksc_pt_2/assets/sample_clean.png',
                            ),
                          )),
                        ),
                        Container(
                          height: 30,
                          width: 400,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              'Huntington Beach, CA',
                              style: TextStyle(
                                fontFamily: "Poppins-Medium",
                                fontSize: ScreenUtil.getInstance().setSp(35),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 40,
                          width: 400,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              'Requested Cleanups',
                              style: TextStyle(
                                fontFamily: "Poppins-Bold",
                                fontSize: ScreenUtil.getInstance().setSp(50),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: (ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.asset(
                              'assets/sample_dirty.jpg',
                            ),
                          )),
                        ),
                        Container(
                          height: 30,
                          width: 400,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              'Los Angeles, CA',
                              style: TextStyle(
                                fontFamily: "Poppins-Medium",
                                fontSize: ScreenUtil.getInstance().setSp(35),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: (ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.asset(
                              'assets/smonica.jpg',
                            ),
                          )),
                        ),
                        Container(
                          height: 30,
                          width: 400,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              'Santa Monica, CA',
                              style: TextStyle(
                                fontFamily: "Poppins-Medium",
                                fontSize: ScreenUtil.getInstance().setSp(35),
                              ),
                            ),
                          ),
                        ),
                      
                      ],
                    ),
                    height: 150.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            offset: new Offset(0.0, -13.0),
                            blurRadius: (5.0)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomSliverDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final bool hideTitleWhenExpanded;

  CustomSliverDelegate({
    @required this.expandedHeight,
    this.hideTitleWhenExpanded = true,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final appBarSize = expandedHeight - shrinkOffset;
    final cardTopPosition = expandedHeight / 2 - shrinkOffset;
    final proportion = 2 - (expandedHeight / appBarSize);
    final percent = proportion < 0 || proportion > 1 ? 0.0 : proportion;
    return Center(
      child: Stack(
        children: <Widget>[
          SizedBox(
            child: AppBar(
              backgroundColor: Color(0x00013243),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {},
              ),
              elevation: 0.0,
              title: Opacity(
                opacity: hideTitleWhenExpanded ? 1 - percent : 1.0,
                child: Text(
                  "petr_the_anteatr",
                  style: TextStyle(
                      fontFamily: "Poppins-Medium",
                      fontSize: ScreenUtil.getInstance().setSp(50)),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            top: cardTopPosition > 0 ? cardTopPosition : 0,
            bottom: 0.0,
            child: Opacity(
              opacity: hideTitleWhenExpanded ? percent : 1.0 - percent,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 128),
                child: Container(
                  child: ClipOval(
                    child: Image.asset(
                      "assets/petr.jpg",
                      width: expandedHeight,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight + expandedHeight / 2;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
