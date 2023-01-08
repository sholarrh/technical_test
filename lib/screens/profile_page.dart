import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_test/provider.dart';
import 'package:technical_test/screens/all_contacts.dart';
import 'package:technical_test/widgets/my_text.dart';

import '../widgets/add_contact_sheet.dart';
import '../widgets/colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) {
      var data = Provider.of<ProviderClass>(context, listen: false);
      data.sharedPreferences();
      data.get();
      data.getContact();
    });
  }

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<ProviderClass>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              backgroundColor: Colors.grey,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  )),
              enableDrag: false,
              isDismissible: true,
              context: context,
              builder: (context) => AddContactSheet());
        },
        tooltip: 'Add Contact',
        child: const Icon(Icons.add),
      ),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: white,
        title: MyText(
          'Profile Page',
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: mainBlue,
        ),
        centerTitle: true,
      ),
      backgroundColor: backGround,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    MyText(
                      'Welcome ',
                      color: white,
                      fontSize: 26,
                      fontWeight: FontWeight.w500,
                    ),
                    MyText(
                      data.userName2 ?? 'User',
                      color: white,
                      fontSize: 26,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                MyText(
                   'Contacts',
                  color: white,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 5,),
                AllContacts(),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
