import 'package:flutter/material.dart';
import 'package:new_login/models/list.dart';
final emailNameController =TextEditingController();
final passWordController = TextEditingController();
final nameController = TextEditingController();
final signinEmailWordController = TextEditingController();


double w=0.0;
double h = 0.0;
final Color _primaryColor = Color(0xFF36306D);

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
 
  final PageController _pageController = PageController(initialPage: 0);
String tap = 'login';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
   w =size.width;
   h = size.height;
    return Scaffold(
      // appBar: AppBar(
      //     title: Text(widget.title),
      // ),
      backgroundColor: _primaryColor,
      body:  SafeArea(
        child: Column(
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.,
              children: [
                GestureDetector(
                  onTap: (){ setState(() {
                    tap = 'login';
                  });
                    // _pageController.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
                    },
                  child: Container(
                    width: size.width*0.5,
                    height: size.height*0.1,
                    decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomRight: Radius.circular(20)),
                     color:tap =='login'?const Color(0xFF1C173D)
                    : const Color.fromRGBO(54, 48, 109, 87.0),
                    ),
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('Login',textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white,fontSize: 22)),
                      ],
                    ),
                   
                  ),
                ),
                GestureDetector(
                  onTap: (){setState(() {
                    tap = 'signup';
                  });
                  // _pageController.previousPage(duration: const Duration(milliseconds: 4000), curve: Curves.easeInCirc);
                    },
                  child: Container(
                    width: size.width*0.5,
                    height: size.height*0.1,
                    decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20)),
                     color:tap =='signup'?const Color(0xFF1C173D)
                    : const Color.fromRGBO(54, 48, 109, 87.0),
                    ),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center,
                      children:const  [
                         Text('Signup',textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white,fontSize: 22),),
                      ],
                    ),
                   
                    
                  ),
                )
      
              ],
            ),
            Expanded(
              flex: 6,
              child: PageView.builder (
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
                itemBuilder: (context, index)=> tap =='login'?_login():signup(),
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
  const _login({ Key? key }) : super(key: key);

  @override
  __loginState createState() => __loginState();
}

class __loginState extends State<_login> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.only(left:10,right: 10),
      child: Column(
       // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children:   <Widget> [
        SizedBox(height: h*0.1,),
        TextField(
          controller: emailNameController,
    style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 25.0),
                          hintText: "Email",
                          hintStyle:const  TextStyle(color: Colors.white),
                          // enabledBorder: const OutlineInputBorder(
                          //   borderRadius: BorderRadius.all(Radius.circular(12)),
                          //   borderSide: BorderSide(
                          //       width: 3, color: Color(0xff34D4D4)),
                          // ),
                          border:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            // borderSide:  BorderSide(color: Colors.teal, width: 5),
  
                          ),
                          filled: true,
                         fillColor: Color(0xFF1C173D),   
                         prefixIcon: Icon( Icons.mail,color: Colors.white,)
  
  ),
  ),
  SizedBox(height: h*0.05,),
  TextField(
    controller: passWordController,
  style: const  TextStyle(color: Colors.white),
        decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 25.0),
                          hintText: "password",
                          hintStyle:const  TextStyle(color: Colors.white),
                         // enabledBorder: const OutlineInputBorder(
                          //   borderRadius: BorderRadius.all(Radius.circular(12)),
                          //   borderSide: BorderSide(
                          //       width: 3, color: Colors.black),
                          // ),
                          border:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          //  borderSide:  BorderSide(color: Colors.pink, width: 5),
                          ),
                         filled: true,
                         fillColor: const Color(0xFF1C173D),   
                         prefixIcon: Icon(Icons.lock,color: Colors.white,)
             ),
             
          ),
          SizedBox(height: h*0.03,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: null,
                child: const Text('Forgot Password?',style: TextStyle(color: Colors.white,fontSize: 13),),),
            ],
          ),
          SizedBox(height: h*0.1,),
        //   ElevatedButton(onPressed: null, child: Text('Login'),
        //   style: ElevatedButton.styleFrom(
        //      primary: Colors.blue,//background color
        //  )
        //  ),
        textBt('login'),
          SizedBox(height: h*0.05,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
           // const SizedBox(width: 10,),
            const Divider(color: Colors.white,),
            SizedBox(width: w*0.05,),
            const Text('Or',style: TextStyle(color: Colors.white),),
           SizedBox(width: w*0.05,),
            const Divider(
            color: Colors.white,
            height: 20,
            thickness: 2,
            indent: 10,
            endIndent: 10,
          ),
          ],),
          SizedBox(height: h*0.03,),
          // CircleAvatar(
          //   // backgroundColor: _primaryColor,
          //   backgroundColor: Colors.pink,            
          //   radius: w*0.2,
          //   child: CircleAvatar(backgroundImage: AssetImage( 'assets/images/facebook.jpg',),
          //   radius: w*0.15,
          //   backgroundColor: Colors.pink,
          //   foregroundColor: Colors.red,),
          // )
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(height: h*0.15,
              width: w*0.15,
              clipBehavior: Clip.antiAlias,
              child: Image.asset('assets/images/facebook.jpg',fit: BoxFit.cover,),
              decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.blue,),
              
              ),
              Container(height: h*0.15,
              width: w*0.15,
              clipBehavior: Clip.antiAlias,
              child: Image.asset('assets/images/google1.jpg',fit: BoxFit.contain,),
              decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.blue,),
              
              ),
            ],
          ),
          SizedBox(height: h*0.005,),
          Row(children:  [
            SizedBox(width: w*0.2,),
            const Text('Dont have account? ',style: TextStyle(color: Colors.white),),
            const Text(' '),
            const Text('SignUp',style: TextStyle(color: Colors.white,decoration: TextDecoration.underline,)),

          ],)
       ],
    ),
  ),
  );
  }
}






class signup extends StatefulWidget {
  const signup({ Key? key }) : super(key: key);

  @override
  _signupState createState() => _signupState();
}

class _signupState extends State<signup> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Padding(
    padding: const EdgeInsets.only(left: 10,right: 10),
    child: Column(
       children: [
         SizedBox(height: h*0.1,),
           TextField(
             controller: nameController,
    style: const  TextStyle(color: Colors.white),
          decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 25.0),
                            hintText: "Name",
                            hintStyle:const  TextStyle(color: Colors.white),
                           // enabledBorder: const OutlineInputBorder(
                            //   borderRadius: BorderRadius.all(Radius.circular(12)),
                            //   borderSide: BorderSide(
                            //       width: 3, color: Colors.black),
                            // ),
                            border:  OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            //  borderSide:  BorderSide(color: Colors.pink, width: 5),
                            ),
                           filled: true,
                           fillColor: const Color(0xFF1C173D),   
                           prefixIcon: const Icon(Icons.person,
                           color: Colors.white,)
               ),
               
            ),
SizedBox(height: h*0.06,),
             TextField(
               controller: signinEmailWordController,
    style: const  TextStyle(color: Colors.white),
          decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 25.0),
                            hintText: "Mail",
                            hintStyle:const  TextStyle(color: Colors.white),
                           // enabledBorder: const OutlineInputBorder(
                            //   borderRadius: BorderRadius.all(Radius.circular(12)),
                            //   borderSide: BorderSide(
                            //       width: 3, color: Colors.black),
                            // ),
                            border:  OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            //  borderSide:  BorderSide(color: Colors.pink, width: 5),
                            ),
                           filled: true,
                           fillColor: const Color(0xFF1C173D),   
                           prefixIcon: const Icon(Icons.mail_outline,
                           color: Colors.white,)
               ),           
            ),
SizedBox(height: h*0.06,),
             TextField(
    style: const  TextStyle(color: Colors.white),
          decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 25.0),
                            hintText: "Location",
                            hintStyle:const  TextStyle(color: Colors.white),
                           // enabledBorder: const OutlineInputBorder(
                            //   borderRadius: BorderRadius.all(Radius.circular(12)),
                            //   borderSide: BorderSide(
                            //       width: 3, color: Colors.black),
                            // ),
                            border:  OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            //  borderSide:  BorderSide(color: Colors.pink, width: 5),
                            ),
                           filled: true,
                           fillColor: const Color(0xFF1C173D),   
                           prefixIcon: const Icon(Icons.gps_fixed,
                           color: Colors.white,)
               ),
               
            ),
SizedBox(height: h*0.06,),
    //          TextField(
    // style: const  TextStyle(color: Colors.white),
    //       decoration: InputDecoration(
    //                   contentPadding: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 25.0),
    //                         hintText: "Services",
    //                         hintStyle:const  TextStyle(color: Colors.white),
    //                        // enabledBorder: const OutlineInputBorder(
    //                         //   borderRadius: BorderRadius.all(Radius.circular(12)),
    //                         //   borderSide: BorderSide(
    //                         //       width: 3, color: Colors.black),
    //                         // ),
    //                         border:  OutlineInputBorder(
    //                           borderRadius: BorderRadius.circular(8.0),
    //                         //  borderSide:  BorderSide(color: Colors.pink, width: 5),
    //                         ),
    //                        filled: true,
    //                        fillColor: const Color(0xFF1C173D),   
    //                        suffixIcon: const Icon(Icons.keyboard_arrow_down,color: Colors.white,)
    //            ),
    //            ),


    Container(
      height: h*0.1,
      width: w*0.8,
      
      decoration: BoxDecoration(
        color: const  Color(0xFF1C173D),
        borderRadius: BorderRadius.circular(8.0)

      ),
      child: InkWell(
        onTap: multiSelect ,
        child: Row(   mainAxisAlignment: MainAxisAlignment.spaceAround, children: [Text('Services', style: TextStyle(color: Colors.white,fontSize: 18),),const Icon(Icons.keyboard_arrow_down,color: Colors.white,)],)),),
               SizedBox(height: h*0.06,),
              // if(selectedServicesItem!=null)Wrap(
              // children: selectedServicesItem
              //     .map((e) => Chip(
              //           label: Text(e),
              //         ))
              //     .toList()),

              if(selectedServicesItem!=null)
         Material(
           elevation: 2.0,
           color: Colors.black12,
           child: ListView.builder( 
             shrinkWrap: true,
             itemCount: selectedServicesItem.length,
             itemBuilder: 
           (context, int  index){
            return ListTile(title: Text(selectedServicesItem[index]),
            trailing: InkWell(
              onTap:(){ removeServices(index);},
              child: Icon(Icons.close,color: Colors.white,)),
            textColor: Colors.white,
            );
              
           }),
         ),
          SizedBox(height: h*0.06,),        
          
               textBt('Sing Up')
       ],
    ),
  )
  );



  }

  void multiSelect() async{
    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(items: servicesItem);
      },
    );

    // Update UI
    if (results != null) {
      setState(() {
        selectedServicesItem = results;
      });
    }
  }
  void removeServices( int index){
    setState(() {
      selectedServicesItem.remove(selectedServicesItem[index]);
    });
  }

}






textBt(title)=>Material(
  borderRadius: BorderRadius.circular(23),
  color: _primaryColor,
  elevation: 5,
  child:   TextButton(
  
        onPressed: () {},
  
        style: TextButton.styleFrom(
  
            // side: BorderSide(width: 1, color: _primaryColor),
  
            minimumSize: Size(145, 40),
  
            shape:
  
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  
            primary: Colors.white,
  
            // backgroundColor: Color(0xFF1A2980) ,
  
            backgroundColor: Color.fromRGBO(26, 41, 128, 100),
  
            ),
  
        child: Container(
    alignment: Alignment.center,
          height: h*0.08,
        width: w*0.3,
          child: Padding(
  
            padding: const EdgeInsets.all(8.0),
  
            child: Text(
  
              title,style:const TextStyle(fontSize: 18),
  
            ),
  
          ),
  
        ),
  
      ),
);


//Multi-Select Code

class MultiSelect extends StatefulWidget {
  final List<String> items;
  const MultiSelect({Key? key, required this.items}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  // this variable holds the selected items
  final List<String> _selectedItems = selectedServicesItem;

// This function is triggered when a checkbox is checked or unchecked
  void _itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedItems.add(itemValue);
      } else {
        _selectedItems.remove(itemValue);
      }
    });
  }

  // this function is called when the Cancel button is pressed
  void _cancel() {
    Navigator.pop(context);
  }

// this function is called when the Submit button is tapped
  void _submit() {
    Navigator.pop(context, _selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Topics'),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items
              .map((item) => CheckboxListTile(
                    value: _selectedItems.contains(item),
                    title: Text(item),
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (isChecked) => _itemChange(item, isChecked!),
                  ))
              .toList(),
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: _cancel,
        ),
        ElevatedButton(
          child: const Text('Submit'),
          onPressed: _submit,
        ),
      ],
    );
  }
}









