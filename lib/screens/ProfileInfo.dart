import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sfw_microorganisms/services/authentication_service.dart';

class ProfileInfo extends StatefulWidget {
  @override
  _ProfileInfo createState() => _ProfileInfo();
}

class _ProfileInfo extends State<ProfileInfo> {
  void showMessage(String text) {
    final snackBar = SnackBar(
      content: Text(text),);

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
          child: Container(
        color: Color(0xFFFFF7F4),
        child: Stack(
          fit: StackFit.expand,
          alignment: AlignmentDirectional.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20.0,bottom: 10),
                  child: CircleAvatar(
                    child: Icon(
                      Icons.group,
                      size: 40,
                    ),
                    radius: 50,
                  ),
                ),
                Text('Username',style: TextStyle(fontSize: 28,fontWeight: FontWeight.w600),),
                Padding(
                  padding:  EdgeInsets.only(top:8.0),
                  child: Text('Country, City',style: TextStyle(fontSize: 22),),

                ),
                Row( mainAxisAlignment: MainAxisAlignment.center,children: [

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.0),
                    child: Text('10',style: TextStyle(fontSize: 24)),
                  ),
               Padding(
                 padding: const EdgeInsets.only(top: 8.0),
                 child: Image.asset('assets/icons/worm.png',width: MediaQuery.of(context).size.width/6,),
               ),

                ],),
                Padding(
                  padding: EdgeInsets.symmetric(vertical:15,horizontal: MediaQuery.of(context).size.width*0.2),
                  child: LinearProgressIndicator(),
                ),
                Text('200/500 XP',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600)),
                Spacer(),
                Row(crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,children: [
                  IconButton(onPressed: (){

                    
                  }, 
                      
                      icon: Icon(Icons.facebook)),
                    IconButton(onPressed: (){
                      
                      
                      
                    }, 
                        
                        icon: Icon(Icons.message_outlined)),
                    IconButton(onPressed: (){
                      
                      
                      
                    }, 
                        
                        icon: Icon(Icons.email_outlined)),
                  ],)
              ],
            ),

            Positioned(
              child: IconButton(
                  onPressed: () async {
                    print('Navigate to settings');

                    logout(context);
                  },
                  icon: Icon(Icons.settings,size: 35,)),
              top: 10,
              right: 10,
            )
          ],
        ),
      )),
    );
  }
}
//TODO: internal routing to Web Browser with a link to Paypal.me
