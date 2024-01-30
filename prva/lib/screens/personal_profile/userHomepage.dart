import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:prva/form_filter_people_adj.dart';
import 'package:prva/models/filters.dart';
import 'package:prva/models/houseProfile.dart';
import 'package:prva/models/personalProfile.dart';
import 'package:prva/models/user.dart';
import 'package:prva/screens/chat/chat.dart';
import 'package:prva/screens/personal_profile/allHousesList.dart';
import 'package:prva/screens/personal_profile/filtersForm.dart';
import 'package:prva/screens/personal_profile/updatePersonalProfile.dart';
import 'package:prva/services/database.dart';
import 'package:prva/services/databaseForFilters.dart';
import 'package:prva/services/databaseForHouseProfile.dart';
import 'package:prva/services/match/match_service.dart';
import 'package:prva/shared/loading.dart';
import 'package:prva/show_details_personal_profile.dart';

class UserHomepage extends StatefulWidget {
  const UserHomepage({super.key});

  @override
  State<UserHomepage> createState() => _UserHomepageState();
}

class _UserHomepageState extends State<UserHomepage> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    SearchLayout(),
    ProfileLayout(),
    ChatLayout(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Utente>(context);
    void _showFiltersPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: FormFilterPeopleAdj(),
            );
          });
    }

    return StreamProvider<PersonalProfileAdj>.value(
        value: DatabaseService(user.uid).persProfileDataAdj,
        initialData: PersonalProfileAdj(
            uidA: user.uid,
            nameA: '',
            surnameA: '',
            description: "",
            gender: "",
            employment: "",
            day: 0,
            month: 0,
            year: 0,
            imageURL1: '',
            imageURL2: '',
            imageURL3: '',
            imageURL4: ''),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text('Personal page'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.settings, color: Colors.white),
                onPressed: () async {
                  _showFiltersPanel();
                },
              ),
              IconButton(
                icon: Icon(Icons.notifications, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
          body: _widgetOptions.elementAt(_selectedIndex),
          bottomNavigationBar: BottomNavigationBar(
            iconSize: MediaQuery.sizeOf(context).height * 0.03,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: 'Chat',
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ));
  }
}

class SearchLayout extends StatefulWidget {
  const SearchLayout({super.key});

  @override
  State<SearchLayout> createState() => _SearchLayoutState();
}

class _SearchLayoutState extends State<SearchLayout> {
  FiltersHouseAdj? filtri;
  List<String>? alreadySeenProfiles;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Utente>(context);
    final personalProfile = Provider.of<PersonalProfileAdj>(context);
    return StreamProvider<List<HouseProfileAdj>>.value(
        value: DatabaseServiceHouseProfile(user.uid).getAllHousesAdj,
        initialData: [],
        child: Scaffold(
          body: AllHousesList(
            myProfile: personalProfile,
          ),
        ));
  }
}

class ProfileLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final personalData = Provider.of<PersonalProfileAdj>(context);

    //return ShowPersonalProfile();

    return Column(mainAxisSize: MainAxisSize.max, children: [
      Expanded(
          child: SingleChildScrollView(
              child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DetailedPersonalProfile(
            personalProfile: personalData,
          ),
          ElevatedButton(
            child: Text('Modifica'),
            onPressed: () {},
          )
        ],
      )))
    ]);
  }
}

class ChatLayout extends StatefulWidget {
  const ChatLayout({super.key});

  @override
  State<ChatLayout> createState() => _ChatLayoutState();
}

class _ChatLayoutState extends State<ChatLayout> {
  List<String>? matches;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Utente>(context);
    final retrievedMatch = MatchService(uid: user.uid).getMatchedProfile;

    retrievedMatch.listen((content) {
      matches = content;
      if (mounted) {
        setState(() {});
      }
    });
    //print('199 user homepage');
    print(matches);
    return _buildUserList(user, matches);
  }
}

Widget _buildUserList(Utente user, List<String>? matches) {
  //print('223 homepage');
  //print(matches);
  return StreamBuilder<QuerySnapshot>(
    stream: MatchService().getChatsPers(matches),
    builder: (context, snapshot) {
      if (snapshot.hasError) {
        return Text('error');
      }
      /*if (snapshot.connectionState == ConnectionState.waiting) {
        return Loading();
      }*/

      if (snapshot.hasData) {
        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) => _buildUserListItem(context, doc, user))
              .toList(),
        );
      } else {
        return Center(
          child: Text("Non hai ancora match"),
        );
      }
    },
  );
}

Widget _buildUserListItem(
    BuildContext context, DocumentSnapshot document, Utente user) {
  Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

  return ListTile(
    title: Text(data['type'] + " " + data['city']),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatPage(
            senderUserID: user.uid,
            receiverUserEmail: data['type'] + " " + data['city'],
            receiverUserID: document.reference.id,
          ),
        ),
      );
    },
  );
}
/*
class ChatLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Utente>(context);
    return _buildUserList(user);
  }

  Widget _buildUserList(Utente user) {
    List<String>? matches;

    final retrievedMatch = MatchService(uid: user.uid).getMatchedProfile;

    retrievedMatch.listen((content) {
      matches = content;
    });

    return StreamBuilder<QuerySnapshot>(
      stream: MatchService().getChatsPers(matches),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loading();
        }

        if (snapshot.hasData) {
          return ListView(
            children: snapshot.data!.docs
                .map<Widget>((doc) => _buildUserListItem(context, doc, user))
                .toList(),
          );
        } else {
          return Center(
            child: Text("Non hai ancora match"),
          );
        }
      },
    );
  }

  Widget _buildUserListItem(
      BuildContext context, DocumentSnapshot document, Utente user) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    return ListTile(
      title: Text(data['type'] + " " + data['city']),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(
              senderUserID: user.uid,
              receiverUserEmail: data['type'] + " " + data['city'],
              receiverUserID: document.reference.id,
            ),
          ),
        );
      },
    );
  }
}
*/