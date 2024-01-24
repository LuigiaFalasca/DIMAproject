import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prva/models/houseProfile.dart';
import 'package:prva/models/personalProfile.dart';
import 'package:prva/models/preference.dart';
import 'package:prva/screens/swipe_between_images.dart';
import 'package:prva/services/database.dart';
import 'package:prva/services/match/match_service.dart';


class AllHousesList extends StatefulWidget {
  const AllHousesList({super.key});

  @override
  State<AllHousesList> createState() => _AllHousesListState();
}

class _AllHousesListState extends State<AllHousesList> {
  List<String>? alreadySeenHouses;
  List<PreferenceForMatch>? preferencesOther;

  @override
  Widget build(BuildContext context) {
    final myProfile = Provider.of<PersonalProfile>(context);

    final retrievedAlreadySeenHouses =
        DatabaseService(myProfile.uid).getAlreadySeenProfile;
    retrievedAlreadySeenHouses.listen((content) {
      alreadySeenHouses = content;
      //print(alreadySeenProfiles?.length);
      //print(alreadySeenProfiles?.length);
      if (this.mounted) {
        setState(() {});
      }
    });
    final houses = Provider.of<List<HouseProfile>>(context);

    if (alreadySeenHouses != null) {
      houses.removeWhere(
          (element) => alreadySeenHouses!.contains(element.idHouse));
      //print('allHousesList 36 - rimuovo');
      if (this.mounted) {
        setState(() {});
      }
    }
    if (houses.isEmpty) {
      return Center(
        child: Text('non ci sono case da visualizzare',
         style: TextStyle(color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Plus Jakarta Sans',
                                ),
        ),
      );
    } else {
      final myUser = Provider.of<PersonalProfile>(context);
      /* capire se continua a fare tutte queste read quando sistemiamo la grafica finale */
      final retrievedPreferences =
          MatchService(uid: houses[0].idHouse).getPreferencesForMatch;
      retrievedPreferences.listen((content) {
        //print("preso il contenuto riga 41 allHouselist");
        preferencesOther = content;
      });
      return /*ListView.builder(
        //itemCount: houses.length,
        itemCount: 1,
        itemBuilder: (context, index) {
          return */
        Column(children: <Widget>[
        SwipeWidget(houseProfile: houses[0]),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.favorite_outline),//size: MediaQuery.sizeOf(context).height * 0.05),
                color: Colors.black,
                onPressed: () async {
                  /* Put like */
                  //print("like");
                  await MatchService()
                      .putPrefence(myUser.uid, houses[0].idHouse, "like");
                  //print("dopo aver messo la preferenza");

                  await MatchService().checkMatch(
                      myUser.uid, houses[0].idHouse, preferencesOther);
                }),
             SizedBox(width: MediaQuery.sizeOf(context).width * 0.2),
            IconButton(
                icon: Icon(Icons.close_outlined), //size: MediaQuery.sizeOf(context).height * 0.05),
                color: Colors.black,
                onPressed: () async {
                  await MatchService()
                      .putPrefence(myUser.uid, houses[0].idHouse, "dislike");
                }),
            const SizedBox(width: 8),
          ],
        ),
      ]);
    }
  }
}

class AllHousesTiles extends StatelessWidget {
  final HouseProfile house;
  AllHousesTiles({required this.house});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
            margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  radius: 25.0,
                  backgroundColor: Colors.red[house.price],
                ),
                title: Text(house.type),
                subtitle: Text('Si trova a ${house.city}'),
              ),
            ])));
  }
}
