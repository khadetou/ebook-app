import 'dart:convert';

import 'package:ebook/widgets/my_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import "../widgets/app_color.dart" as AppColor;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late List popularBooks;
  late ScrollController _scrollController;
  late TabController _tabController;

  readData() async {
    await DefaultAssetBundle.of(context)
        .loadString("assets/json/popularBooks.json")
        .then((s) {
      setState(() {
        popularBooks = json.decode(s);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    readData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.background,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 10.0),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      "assets/images/four-squares.svg",
                      width: 24,
                      height: 24,
                      color: Colors.black,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Icon(Icons.search),
                        SizedBox(width: 8),
                        Icon(Icons.notifications_active),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Text(
                      "Popular Books",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15.0),
              SizedBox(
                height: 180,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: -20,
                      right: 0,
                      child: SizedBox(
                          height: 180,
                          child: PageView.builder(
                            controller: PageController(viewportFraction: 0.8),
                            itemCount: popularBooks.length,
                            itemBuilder: (_, i) {
                              return Container(
                                height: 180,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(17),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      popularBooks[i]["img"],
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          )),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: NestedScrollView(
                  controller: _scrollController,
                  headerSliverBuilder: (BuildContext context, bool isScroll) {
                    return [
                      SliverAppBar(
                        pinned: true,
                        backgroundColor: Colors.white,
                        bottom: PreferredSize(
                          preferredSize: const Size.fromHeight(50),
                          child: Container(
                            margin: const EdgeInsets.all(20.0),
                            child: TabBar(
                              indicatorPadding: const EdgeInsets.all(0),
                              indicatorSize: TabBarIndicatorSize.label,
                              labelPadding: const EdgeInsets.only(right: 10),
                              controller: _tabController,
                              isScrollable: true,
                              indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 7,
                                    offset: const Offset(0, 0),
                                  ),
                                ],
                              ),
                              tabs: const [
                                AppTab(
                                    text: "New", color: AppColor.menue1Color),
                                AppTab(
                                    text: "New", color: AppColor.menue2Color),
                                AppTab(
                                    text: "New", color: AppColor.menue3Color),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ];
                  },
                  body: TabBarView(
                    controller: _tabController,
                    children: const [
                      Material(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey,
                          ),
                          title: Text("Content"),
                        ),
                      ),
                      Material(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey,
                          ),
                          title: Text("Content"),
                        ),
                      ),
                      Material(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey,
                          ),
                          title: Text("Content"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
