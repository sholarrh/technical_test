import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider.dart';
import '../../widgets/edit_contact_sheet.dart';
import '../../widgets/my_text.dart';

class ContactCard extends StatefulWidget {
  String sId;
  String type;
  String name;
  String email;
  String phone;
  String user;

  ContactCard({
    required this.sId,
    required this.type,
    required this.name,
    required this.email,
    required this.phone,
    required this.user,
  });

  @override
  State<ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<ContactCard> {
  @override
  Widget build(BuildContext context) {
    var data = Provider.of<ProviderClass>(
      context,
    );
    return Card(
        color: Colors.white,
        child: ListTile(
          title: MyText(
            widget.name,
            fontSize: 20,
          ),
          subtitle: MyText(
            widget.phone,
            fontSize: 16,
          ),
          leading: Icon(Icons.contacts),
          trailing: SizedBox(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
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
                          builder: (context) => EditContact(
                                sId: widget.sId,
                                type: widget.type,
                                name: widget.name,
                                email: widget.email,
                                phone: widget.phone,
                                user: widget.user,
                              ));
                    },
                    icon: Icon(Icons.edit)),

                GestureDetector(
                  onTap: () {
                    try {
                     // if (data.deleteResponse.statusCode == 200) {
                        data.delete(widget.sId);
                        data.getContact();
                        setState(() {
                        });
                     // }
                    }catch(e){
                      print(e.toString());
                    }
                  },
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
