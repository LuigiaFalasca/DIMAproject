import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prva/models/personalProfile.dart';
import 'package:prva/models/user.dart';
import 'package:prva/screens/personal_profile/form_personal_profile_adj.dart';
import 'package:prva/screens/personal_profile/user_homepage.dart';
import 'package:prva/services/database.dart';
import 'package:prva/screens/shared/loading.dart';

class WrapperCreationProfile extends StatelessWidget {
  const WrapperCreationProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Utente>(context);

    return Scaffold(
        body: StreamBuilder<PersonalProfileAdj>(
            stream: DatabaseService(user.uid).persProfileDataAdj,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Loading();
              }
              if (!snapshot.hasData) {
                return const FormPersonalProfileAdj();
              } else {
                return const UserHomepage();
              }
            }));
  }
}
