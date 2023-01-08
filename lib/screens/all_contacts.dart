import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider.dart';
import '../widgets/colors.dart';
import '../widgets/my_text.dart';
import 'model/contact_card.dart';

class AllContacts extends StatefulWidget {
  const AllContacts({
    Key? key,
  }) : super(key: key);

  @override
  State<AllContacts> createState() => _AllContactsState();
}

class _AllContactsState extends State<AllContacts> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) {
      var data = Provider.of<ProviderClass>(context, listen: false);
      // data.sharedPreferences();
      // data.get();
      data.getContact();
    });
  }

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<ProviderClass>(
      context,
    );
    return Consumer<ProviderClass>(builder: (ctx, value, child) {
      return SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: FutureBuilder(
            future: ProviderClass().getContact(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Center(
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(
                        valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.blue),
                      ),
                    ),
                  ),
                );
              } else
                //(snapshot.connectionState == ConnectionState.done)
              {
                return Column(
              children: [
                data.contactList.isNotEmpty ?
                RefreshIndicator(
                        onRefresh: () async {
                          await data.getContact();
                        },
                        child: ListView.builder(
                          shrinkWrap: true,
                          // reverse: true,
                          itemCount: data.contactList.length,
                          itemBuilder: (context, index) {
                            final apidata = data.contactList[index];
                            print(apidata);
                            return ContactCard(
                              sId: apidata['_id'],
                              type: apidata['type'],
                              name: apidata['name'],
                              email: apidata['email'],
                              phone: apidata['phone'],
                              user: apidata['user'],
                            );
                          },
                        ),
                      )
                : Center(
                  child: MyText(
                    'You have no contacts',
                    color: white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            );
              }
            }
          ));
    });
  }
}
