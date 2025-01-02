import 'package:flutter/material.dart';
import 'package:password_manager/core/extensions/context_extension.dart';
import 'package:password_manager/core/http/apis/user_api.dart';
import 'package:password_manager/models/user/user_model.dart';
import 'package:password_manager/pages/home/widgets/menu_icon_painter.dart';
import 'package:password_manager/services/secure_storage.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserModel? _user;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Skeletonizer(
      enabled: _user == null,
      child: Scaffold(
          drawer: _drawer(),
          body: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
            child: _content(),
          )),
    ));
  }

  @override
  void initState() {
    super.initState();
    _loadUserInfos();
  }

  Builder _content() {
    return Builder(builder: (context) {
      return ListView(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: CustomPaint(
                  painter: MenuIconPainter(
                      color: context.theme.colorScheme.onSurface),
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
              SizedBox(width: 0),
              Text(context.l.greeting(_user!.firstName)),
              Spacer(),
              IconButton(
                icon: Icon(Icons.notifications_none_outlined),
                onPressed: () {},
              )
            ],
          )
        ],
      );
    });
  }

  Widget _drawer() {
    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Drawer Header'),
          ),
          ListTile(
            title: const Text('Item 1'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Item 2'),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Future<void> _loadUserInfos() async {
    final response = await UserApi.getInfos();
    if (response.status) {
      final user = UserModel.fromMap(response.data!);
      await SecureStorage.saveUserInfos(user);
      setState(() {
        _user = user;
      });
    }
  }
}
