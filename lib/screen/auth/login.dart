import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:work_os/constans/const.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passEditingController = TextEditingController();
  bool obscure = true;
  var formValidKey = GlobalKey<FormState>();
//this ==> when user go head from this screen this screen will hidden from the memory
  @override
  void dispose() {
    _animationController.dispose();
    emailEditingController.dispose();
    passEditingController.dispose();
    super.dispose();
  }

  //this run when the app run
  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 20));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.linear)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((animationStatus) {
            if (animationStatus == AnimationStatus.completed) {
              _animationController.reset();
              _animationController.forward();
            }
          });
    _animationController.forward();
    super.initState();
  }
  submittedFormKeyLogin (){
    final isValid = formValidKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if(isValid){
      print('is Valid');
    }else{
      print('is not valid');
    }
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: imageLogin,
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => const Icon(Icons.error),
            alignment: FractionalOffset(_animation.value, 0),
            width: double.infinity,
            height: double.infinity,
            placeholder: (context, url) => Image.asset(
              'assets/images/on_error.jpeg',
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 50),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: size.height * .2,
              ),
              //this for login ui
              Container(
                height: size.height * 0.2 / 3,
                width: size.width * 0.3,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 5,
                          offset: const Offset(0, -1)),
                      BoxShadow(
                          color: Colors.white.withOpacity(0.5),
                          blurRadius: 5,
                          offset: const Offset(-1, -1)),
                    ]),
                child: const Center(
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontFamily: 'Merienda',
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.1 / 6,
              ),
              //this for build text in one line like a row
              RichText(
                  text: TextSpan(children: [
                const TextSpan(
                    text: 'Don\'t have an account ?',
                    style: TextStyle(
                        fontSize: 19,
                        //backgroundColor: Colors.black.withOpacity(0.3),
                        fontFamily: 'Merienda')),
                const TextSpan(text: '   '),
                TextSpan(
                    recognizer: TapGestureRecognizer()..onTap = () {},
                    text: 'Register Now!',
                    style: const TextStyle(
                        fontSize: 18,
                        decoration: TextDecoration.underline,
                        //backgroundColor: Colors.white.withOpacity(0.7),
                        fontFamily: 'Merienda',
                        fontWeight: FontWeight.bold,
                        color: Colors.blue))
              ])),
              SizedBox(
                height: size.height * 0.1 / 2,
              ),
                  Form(
                    key: formValidKey,
                    child: Column(
                      children: [
                        buildEmailFormField(),
                         SizedBox(height: size.height * 0.1/5,),
                        buildPasswordTextFormField(),
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * 0.05,),
                  MaterialButton(
                    color: Colors.white.withOpacity(0.7),
                    elevation: 10.0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),
                    side: BorderSide.none
                    ),
                    onPressed: submittedFormKeyLogin,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child:  Text(
                          'Login',
                          style: TextStyle(
                            fontFamily: 'Merienda',
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      SizedBox(width: size.width * 0.04,),
                      const Icon(Icons.logout),
                    ],
                  ),
                  )

            ]),
          )
        ],
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Enter correct Email';
                    } else {
                      return null;
                    }
                  },
                  controller: emailEditingController,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontFamily: 'Merienda',
                  ),
                  decoration: const InputDecoration(

                    hintText: 'Email',
                    hintStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Merienda'),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        )),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                  ),
                );
  }

  TextFormField buildPasswordTextFormField() {
    return TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || value.length> 7) {
                      return 'Enter correct Password';
                    } else {
                      return null;
                    }
                  },
                  obscureText: obscure,
                  controller: passEditingController,
                  keyboardType: TextInputType.visiblePassword,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontFamily: 'Merienda',
                  ),
                  decoration:  InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: (){

                        setState(() {
                          obscure = ! obscure;
                        });
                      },
                      child: Icon(obscure ?  Icons.visibility : Icons.visibility_off,color: Colors.white,),
                    ),
                    hintText: 'Password',
                    hintStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Merienda'),
                    enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        )),
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    errorBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                  ),
                );
  }
}
