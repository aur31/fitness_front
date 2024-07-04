import 'package:fitness/components/comments.dart';
import 'package:fitness/components/market_place.dart';
import 'package:fitness/components/menu.dart';
import 'package:fitness/components/sport.dart';
import 'package:fitness/screens/dashboard/user_dashboard.dart';
import 'package:fitness/services/sharedPreferences.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({super.key});

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {

  late PageController pageController;

  int _currentIndex = 0;
  final List<Widget> _screens = [
    home(),
    Diet(),
    Comments(),
    Sport(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    pageController = PageController(
      initialPage: 0,
      viewportFraction: 1,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.black,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          pageController.animateToPage(index,duration: Duration(milliseconds: 200),curve: Curves.easeIn);

        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank),
            label: 'Diet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.comment),
            label: 'Comment',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports),
            label: 'Sport',
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: PageView.builder(
              controller: pageController,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 4,
              itemBuilder: (context,index){
                return _screens[index];
              }
          ),
        ),
      ),
    );
  }
}

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: (){
                    Navigator.of(context).pushNamed("/profile",arguments: context.read<AppSharedPreferences>().user);
                  },
                  child: CircleAvatar(
                    radius: 30,
                    child: Icon(Icons.person,size: 50,),
                  )
              ),
            ],
          ),
      
          Container(
            height: size/4,
            width: double.infinity,
            child: Card(
              child: Text("Motivation"),
            ),
          ),
          SizedBox(height: 15,),
          Card(
            child: TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
          )
        ],
      ),
    );
  }
}


class Diet extends StatefulWidget {
  const Diet({super.key});

  @override
  State<Diet> createState() => _DietState();
}

class _DietState extends State<Diet> {
  int floating = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
              onPressed: (){
                setState(() {
                  floating = 2;
                });
              },
              icon: Icon(Icons.info,size: 30,color: floating == 2 ? Colors.blueAccent : null,)
          ),
          IconButton(
              onPressed: (){
                setState(() {
                  floating = 1;
                });
              },
              icon: FaIcon(FontAwesomeIcons.city,color: floating == 1 ? Colors.blueAccent : null,)
          ),
          IconButton(
              onPressed: (){
                setState(() {
                  floating = 0;
                });
              },
              icon: Icon(Icons.food_bank_outlined,size: 30,color: floating == 0 ? Colors.blueAccent : null,)
          ),
        ],
      ),
      body: floating == 0 ? Menu() :
      floating == 1 ? MarketPlace() : Container()
    );
  }
}


