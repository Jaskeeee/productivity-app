import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';

class ProfileAvatar extends StatefulWidget {
  final String? photoUrl;
  const ProfileAvatar({
    super.key,
    required this.photoUrl
  });

  @override
  State<ProfileAvatar> createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  @override
  Widget build(BuildContext context) {
    if(widget.photoUrl!=null){
      return Center(
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: DottedDecoration(
            shape: Shape.circle,
            borderRadius: BorderRadius.circular(100)
          ),
          child: ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(100),
            child: SizedBox(
              height: 100,
              width: 100,
              child: Image.network(
                widget.photoUrl!,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
        ),
      );
    }else{
      return Center(
        child: Icon(
          Icons.account_circle_outlined,
          size: 100,
        ),
      );
    }
  }
}