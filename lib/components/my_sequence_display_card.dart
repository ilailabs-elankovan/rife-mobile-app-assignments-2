import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../pages/player_home.dart';
import '../utils/constants.dart';
import 'my_svg_icon.dart';

class MySequenceDisplayCard extends StatefulWidget {
  Widget leadingIcon;
  String seqTitle;
  String seqText;
  String warningText;
  List freqList;
  MySequenceDisplayCard({
    Key? key,
    required this.leadingIcon,
    required this.seqTitle,
    required this.seqText,
    required this.warningText,
    required this.freqList
  }) : super(key: key);

  @override
  State<MySequenceDisplayCard> createState() => _MySequenceDisplayCardState();
}


class _MySequenceDisplayCardState extends State<MySequenceDisplayCard> {

  bool _isMarkedFavourite = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MaterialButton(
        padding: EdgeInsets.zero,
        onPressed: (){
          // print("***navigate to playlist**");
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return PlayerHome(freqList: widget.freqList, seqTitle: widget.seqTitle , seqText: widget.seqText);
          }));
          // print("${widget.freqList}");
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                width: 0.0,
              ),
              image: DecorationImage(
                  image: AssetImage("assets/images/sequence_display_card_bg.png") ,
                  fit: BoxFit.cover
              )
          ),
          // height: 150.0,
          width: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 64.0,
                          child: CircleAvatar(
                            radius: 18.0,
                            backgroundColor: Colors.white,
                            child: widget.leadingIcon,
                          ),
                        ),
                        Text("${widget.seqTitle}", style: Theme.of(context).textTheme.bodyLarge,),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 48.0,
                          child: MaterialButton(
                            shape: CircleBorder(),
                            padding: EdgeInsets.zero,
                            onPressed: (){
                              setState(() {
                                // todo: Enable this when local bucket to store fav is created;
                                // _isMarkedFavourite = !_isMarkedFavourite;
                              });
                            },
                            child: CircleAvatar(
                              radius: 18.0,
                              backgroundColor: !_isMarkedFavourite ? Colors.white : blueIconColor,
                              child: !_isMarkedFavourite ? Icon(Icons.favorite_border, color: blueIconColor,): Icon(Icons.favorite, color: Colors.white,),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 48.0,
                          child: MaterialButton(
                            padding: EdgeInsets.zero,
                            onPressed: (){},
                            child: CircleAvatar(
                              radius: 18.0,
                              backgroundColor: Colors.white,
                              child: Icon(Icons.more_vert, color: blueIconColor,),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("${widget.seqText}", style: Theme.of(context).textTheme.bodyMedium),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
