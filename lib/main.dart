import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String num, msg;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SMS Sender"),
      ),
        // ignore: deprecated_member_use
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                onChanged: (val){
                  num = val;
                },
                decoration: InputDecoration(
                  hintText: "Enter Number",
                  border: OutlineInputBorder(
                  )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                onChanged: (val){
                  msg = val;
                },
                decoration: InputDecoration(
                    hintText: "Enter Message",
                    border: OutlineInputBorder(
                    )
                ),
              ),
            ),
            // ignore: deprecated_member_use
            Center(
              child: RaisedButton(
                child: Text("Send"),
                onPressed: () async {
                  final SmsSendStatusListener listener = (SendStatus status) {
                    print(status.toString());
                  };
                  Telephony telephony = Telephony.instance;
                  String n = await telephony.networkOperatorName;
                  SimState a = (await telephony.simState);
                  print(n+" "+a.index.toString());
                  print("Number:"+num.toString());
                  print("Msg:"+msg.toString());
                  await telephony.sendSms(
                      to: num,
                      message: msg,
                      statusListener: listener
                  );
                  print(listener);
                },

              ),
            ),
          ],
        ));
  }
}
