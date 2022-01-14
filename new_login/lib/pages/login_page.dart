import 'package:flutter/material.dart';
import 'package:new_login/models/list.dart';
import 'signin_page.dart';

final emailNameController = TextEditingController();
final passWordController = TextEditingController();
final nameController = TextEditingController();
final signinEmailWordController = TextEditingController();

double w = 0.0;
double h = 0.0;
final Color primaryColor = Color(0xFF36306D);

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final PageController _pageController = PageController(initialPage: 0);
  String tap = 'login';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    w = size.width;
    h = size.height;
    return Scaffold(
        // appBar: AppBar(
        //     title: Text(widget.title),
        // ),
        backgroundColor: primaryColor,
        body: SafeArea(
          child: Column(
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        tap = 'login';
                      });
                      // _pageController.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
                    },
                    child: Container(
                      width: size.width * 0.5,
                      height: size.height * 0.1,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.only(bottomRight: Radius.circular(20)),
                        color: tap == 'login'
                            ? const Color(0xFF1C173D)
                            : const Color.fromRGBO(54, 48, 109, 87.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('Login',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 22)),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        tap = 'signup';
                      });
                      // _pageController.previousPage(duration: const Duration(milliseconds: 4000), curve: Curves.easeInCirc);
                    },
                    child: Container(
                      width: size.width * 0.5,
                      height: size.height * 0.1,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(20)),
                        color: tap == 'signup'
                            ? const Color(0xFF1C173D)
                            : const Color.fromRGBO(54, 48, 109, 87.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Signup',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 22),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                flex: 6,
                child: PageView.builder(
                  controller: _pageController,
                  // children: [
                  //   Container(
                  //     width: 50,
                  //     color: Colors.amberAccent,),
                  //   Expanded(
                  //     flex: 9,
                  //     child: Column(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Container(
                  //           width: 50,
                  //           color: Colors.pink,)
                  //       ],
                  //     ),
                  //   )

                  // ],
                  itemCount: 1,
                  itemBuilder: (context, index) =>
                      tap == 'login' ? _login() : signup(),
                ),
              )
            ],
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

// Widget _login( ){

//   return
// }

class _login extends StatefulWidget {
  const _login({Key? key}) : super(key: key);

  @override
  __loginState createState() => __loginState();
}

class __loginState extends State<_login> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              height: h * 0.1,
            ),
            TextField(
              controller: emailNameController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 25.0),
                  hintText: "Email",
                  hintStyle: const TextStyle(color: Colors.white),
                  // enabledBorder: const OutlineInputBorder(
                  //   borderRadius: BorderRadius.all(Radius.circular(12)),
                  //   borderSide: BorderSide(
                  //       width: 3, color: Color(0xff34D4D4)),
                  // ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    // borderSide:  BorderSide(color: Colors.teal, width: 5),
                  ),
                  filled: true,
                  fillColor: Color(0xFF1C173D),
                  prefixIcon: Icon(
                    Icons.mail,
                    color: Colors.white,
                  )),
            ),
            SizedBox(
              height: h * 0.05,
            ),
            TextField(
              controller: passWordController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 25.0),
                  hintText: "password",
                  hintStyle: const TextStyle(color: Colors.white),
                  // enabledBorder: const OutlineInputBorder(
                  //   borderRadius: BorderRadius.all(Radius.circular(12)),
                  //   borderSide: BorderSide(
                  //       width: 3, color: Colors.black),
                  // ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    //  borderSide:  BorderSide(color: Colors.pink, width: 5),
                  ),
                  filled: true,
                  fillColor: const Color(0xFF1C173D),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.white,
                  )),
            ),
            SizedBox(
              height: h * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: null,
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: h * 0.1,
            ),
            //   ElevatedButton(onPressed: null, child: Text('Login'),
            //   style: ElevatedButton.styleFrom(
            //      primary: Colors.blue,//background color
            //  )
            //  ),
            textButton('login'),
            SizedBox(
              height: h * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // const SizedBox(width: 10,),
                const Divider(
                  color: Colors.white,
                ),
                SizedBox(
                  width: w * 0.05,
                ),
                const Text(
                  'Or',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  width: w * 0.05,
                ),
                const Divider(
                  color: Colors.white,
                  height: 20,
                  thickness: 2,
                  indent: 10,
                  endIndent: 10,
                ),
              ],
            ),
            SizedBox(
              height: h * 0.03,
            ),
            // CircleAvatar(
            //   // backgroundColor: primaryColor,
            //   backgroundColor: Colors.pink,
            //   radius: w*0.2,
            //   child: CircleAvatar(backgroundImage: AssetImage( 'assets/images/facebook.jpg',),
            //   radius: w*0.15,
            //   backgroundColor: Colors.pink,
            //   foregroundColor: Colors.red,),
            // )
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: h * 0.15,
                  width: w * 0.15,
                  clipBehavior: Clip.antiAlias,
                  child: Image.asset(
                    'assets/images/facebook.jpg',
                    fit: BoxFit.cover,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                ),
                Container(
                  height: h * 0.15,
                  width: w * 0.15,
                  clipBehavior: Clip.antiAlias,
                  child: Image.asset(
                    'assets/images/google1.jpg',
                    fit: BoxFit.contain,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: h * 0.005,
            ),
            Row(
              children: [
                SizedBox(
                  width: w * 0.2,
                ),
                const Text(
                  'Dont have account? ',
                  style: TextStyle(color: Colors.white),
                ),
                const Text(' '),
                const Text('SignUp',
                    style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}



textButton(title) => Material(
      borderRadius: BorderRadius.circular(23),
      color: primaryColor,
      elevation: 5,
      child: Container(
        alignment: Alignment.center,
        height: h * 0.07,
        width: w * 0.3,
        decoration: BoxDecoration(
            gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color.fromRGBO(26, 41, 128, 100),
                  Color.fromRGBO(42, 178, 252, 100),
                ]),
            borderRadius: BorderRadius.circular(23)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );

//Multi-Select Code

