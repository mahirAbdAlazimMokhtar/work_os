import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:work_os/constans/const.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

//this ==> when user go head from this screen this screen will hidden from the memory
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  //this run when the app run
  @override
  void initState() {
   _animationController = AnimationController(vsync: this,duration: const Duration(seconds: 20));
   _animation = CurvedAnimation(parent: _animationController, curve: Curves.easeInBack)..addListener(() {setState(() {
   });})..addStatusListener((animationStatus) {
     if(animationStatus == AnimationStatus.completed){
       _animationController.reset();
       _animationController.forward();
     }
   });
   _animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: imageLogin,fit: BoxFit.cover,
            errorWidget: (context, url, error) =>const Icon(Icons.error) ,
            alignment: FractionalOffset(_animation.value,0),
            width: double.infinity,
            height: double.infinity,
            placeholder: (context, url) => Image.asset('assets/images/on_error.jpeg',fit: BoxFit.fill,),


          )
        ],
      ),
    );
  }
}
