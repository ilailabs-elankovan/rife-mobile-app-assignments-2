import 'package:flutter/material.dart';
import 'package:rife_mobile_app/onboarding_screens.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'faq_list_view.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {

  bool _isFirstTimeUser = true; // todo; need to update this;

  @override
  void initState(){
    // isFirstTimeUser();
  }

  // todo; Update this in Util; modify method;
  isFirstTimeUser() async {
    final SharedPreferences userData = await SharedPreferences.getInstance();
    final isFirstTimeUser = userData.getBool('isFirstTimeUser');
    if(isFirstTimeUser==true){
      setState(() {
        _isFirstTimeUser = true;
      });
    } else {
      setState(() {
        _isFirstTimeUser = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          // color: Colors.blue.shade50,
            child: Column(
              children: [
                // //  DEBUG; PRINT;
                // Text("isFirstTimeUser:${_isFirstTimeUser}"),
                // TextButton(onPressed: ()async{
                //   final SharedPreferences userData = await SharedPreferences.getInstance();
                //   await userData.setBool('isFirstTimeUser', true);
                //   print("***successfully-set***");
                //   var _isFirstTimeUser1 = await userData.getBool('isFirstTimeUser');
                //   print(_isFirstTimeUser1);
                // },
                //
                // child: Text("save-first-time-user"),),
                // TextButton(onPressed: () async{
                //   final SharedPreferences userData = await SharedPreferences.getInstance();
                //   await userData.setBool('isFirstTimeUser', false);
                //   print("***successfully-set***");
                //   var _isFirstTimeUser2 = await userData.getBool('isFirstTimeUser');
                //   print(_isFirstTimeUser2);
                //
                // }, child: Text("log-out"),),
                if(_isFirstTimeUser)Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: MyOnboardingScreenTwo(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("FAQs", style: Theme.of(context).textTheme.titleSmall,),
                            SizedBox(
                              width: 0.0,
                            ),
                          ],
                        ),
                      ),
                      FaqListView(),
                    ],
                  ),
                ), // todo: Update codes from Dinesh;
              ],
            )),
      ),
    );
  }


}
