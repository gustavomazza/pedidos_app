import 'package:flutter/material.dart';
import 'package:pedidos_app/app/ui/android/principal/Principal_page.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  // static String tag = 'principal-page';

  final title;

  const Navbar({Key key, this.title}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    // final content = SingleChildScrollView(
    // return new AppBar(
    //   backgroundColor: Color(0xFFf45d27),
    //   centerTitle: true,
    //   elevation: 0,
    //   title: Text(this.title),
    // );
    return new AppBar(
      // leading: Icon(Icons.menu),
      title: Text(
        this.title,
        style: TextStyle(fontSize: 18),
      ),
      centerTitle: true,
      elevation: 0,
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.02),
          child: IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => PrincipalPage()));
            },
          ),
        ),

        // Icon(Icons.more_vert),
      ],
      backgroundColor: Color(0xFFf45d27),
    );
  }
}
