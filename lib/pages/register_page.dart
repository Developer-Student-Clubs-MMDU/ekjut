import 'package:ekjut/pages/login_page.dart';
import 'package:ekjut/pages/signup_page.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage>
    with TickerProviderStateMixin {
  final int _current = 0;

  // int _index = 0;

  static const List<Tab> _tabs = <Tab>[
    Tab(child: Text('Login')),
    Tab(child: Text('SignUp')),
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    late final TabController _controller =
        TabController(length: 2, vsync: this);
    int _index = 0;

    callback(index) {
      setState(() {
        _index = index;
        _controller.index = _index;
        print("///////////////$_index");
      });
    }
    // _controller.addListener(() {
    //   setState(() {
    //     // print('dcssssssssssssssssssssss $_current');
    //     // // print(controller.page);
    //     // // _current = _controller.index;
    //     // print(_controller.index);
    //     // print('xxxxxxxxxxxx $_current');
    //   });
    // });
    // print(_height);

    return SafeArea(
      child: Scaffold(
        body: Container(
            width: _width,
            height: _height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF36306D).withOpacity(1),
                    const Color(0xFF1C173D)
                  ]),
            ),
            child: Column(
              children: [
                TabBar(
                    indicator: const BoxDecoration(
                        color:
                            // _index == 0 ?
                            Color(0xFF1C173D)
                        //  : Colors.white,
                        // borderRadius: BorderRadius.only(
                        //     bottomLeft: _current == 0
                        //         ? const Radius.circular(8.0)
                        //         : const Radius.circular(0.0),
                        //     bottomRight: _current == 1
                        //         ? const Radius.circular(8.0)
                        //         : const Radius.circular(0.0)),
                        ),
                    labelColor: Colors.white,
                    indicatorColor: Colors.transparent,
                    controller: _controller,
                    tabs: _tabs),
                Expanded(
                  child: TabBarView(controller: _controller, children: [
                    // LoginScreen(),
                    LoginScreen(_index, callback),
                    const SignupScreen(),
                  ]),
                ),
              ],
            )),
      ),
    );
  }
}
