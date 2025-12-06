import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App_01',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFEDE7F6),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Sensor App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool is_dnd_enabled = false;
  bool is_Focusmode = false;

  final controller_duration = TextEditingController();
  int focus_duration = 90;

  void count() {
    if (focus_duration > 0) {
      Future.delayed(Duration(seconds: 1), () {
        focus_duration--;
        count();
        setState(() {});
      });
    }
    if (focus_duration == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Focus Session Completed, Great Job!"),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void enable_dnd() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Do Not Disturb Mode Enabled"),
        backgroundColor: Colors.green,
      ),
    );
    is_dnd_enabled = true;
    setState(() {});
  }

  void disable_dnd() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Do Not Disturb Mode Disabled"),
        backgroundColor: Colors.red,
      ),
    );

    is_dnd_enabled = false;
    setState(() {});
  }

  void enable_focusmode() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Focus Mode Enabled"),
        backgroundColor: Colors.blue,
      ),
    );
    is_Focusmode = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.school,
                  size: 50,
                  color: Theme.of(context).colorScheme.primary,
                ),
                SizedBox(width: 10),
                Text(
                  'Welcome to Focus & Study App',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Icon(
                  Icons.timer,
                  size: 50,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Stay focused and boost your productivity with our app designed to help you manage your study sessions effectively.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Divider(
              thickness: 2,
              color: Colors.green,
              indent: 40,
              endIndent: 40,
              height: 40,
            ),
            SizedBox(height: 40),

            Container(
              padding: EdgeInsets.all(18),
              margin: EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Spacer(),
                      Text(
                        "Do Not Disturb Mode",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 200),
                      Switch(
                        value: is_dnd_enabled,
                        onChanged: (bool value) {
                          is_dnd_enabled = value;
                          if (is_dnd_enabled) {
                            enable_dnd();
                          } else {
                            disable_dnd();
                          }
                          setState(() {});
                        },
                      ),
                      SizedBox(width: 10),
                      if (is_dnd_enabled)
                        Icon(Icons.do_not_disturb_on, color: Colors.red),
                      if (!is_dnd_enabled)
                        Icon(Icons.do_not_disturb_off, color: Colors.green),
                      Spacer(),
                    ],
                  ),

                  Divider(thickness: 1, color: Colors.grey[300]),

                  Row(
                    children: [
                      Spacer(),
                      Icon(
                        Icons.center_focus_strong,
                        color: is_Focusmode ? Colors.blue : Colors.green,
                      ),
                      SizedBox(width: 20),
                      Text(
                        "Focus Mode",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 230),
                      Checkbox(
                        value: is_Focusmode,
                        onChanged: (bool? value) {
                          if (value == true) {
                            enable_focusmode();
                          } else {
                            is_Focusmode = false;
                            setState(() {});
                          }
                        },
                      ),
                      Spacer(),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),

            Container(
              padding: EdgeInsets.all(18),
              margin: EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Set Focus Duration (seconds):  ${focus_duration}s.",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: TextField(
                      controller: controller_duration,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: "Enter seconds",
                        border: UnderlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  OutlinedButton(
                    onPressed: () {
                      if (controller_duration.text.isNotEmpty) {
                        focus_duration = int.parse(controller_duration.text);
                        controller_duration.clear();
                        setState(() {});
                        count();
                      }
                    },
                    child: Text("Start Focus Session"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
