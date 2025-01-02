import 'package:flutter/material.dart';
import 'package:password_manager/core/constants/app_images.dart';
import 'package:password_manager/core/extensions/context_extension.dart';
import 'package:password_manager/core/http/apis/user_api.dart';
import 'package:password_manager/core/utils/greeting_utils.dart';
import 'package:password_manager/models/user/user_model.dart';
import 'package:password_manager/pages/home/widgets/password_category_card.dart';
import 'package:password_manager/services/secure_storage.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _CardItem {
  final Function() onClick;
  final String title;
  final Color color;
  final Widget icon;

  const _CardItem(
      {required this.onClick,
      required this.title,
      required this.color,
      required this.icon});
}

class _HomePageState extends State<HomePage> {
  UserModel? _user;
  final _searchController = TextEditingController();

  List<_CardItem> get _cardItems => <_CardItem>[
        _CardItem(
            onClick: () {},
            title: context.l.social,
            color: Color(0xff6b72ff),
            icon: Container(
              decoration: BoxDecoration(
                  color: Color(0xffeaf3fc),
                  borderRadius: BorderRadius.circular(100)),
              child: Icon(Icons.social_distance),
            )),
        _CardItem(
            onClick: () {},
            title: context.l.apps,
            color: Color(0xfffdcd2f),
            icon: Container(
              decoration: BoxDecoration(
                  color: Color(0xffeaf3fc),
                  borderRadius: BorderRadius.circular(100)),
              child: Icon(Icons.social_distance),
            )),
        _CardItem(
            onClick: () {},
            title: context.l.cards,
            color: Color(0xff7cd3b1),
            icon: Container(
              decoration: BoxDecoration(
                  color: Color(0xffeaf3fc),
                  borderRadius: BorderRadius.circular(100)),
              child: Icon(Icons.social_distance),
            )),
      ];

  @override
  Widget build(BuildContext context) {
    final greetingMessage = GreetingUtils.getGreeting() == Greeting.morning
        ? context.l.good_morning
        : context.l.good_evening;

    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                GestureDetector(
                  child: CircleAvatar(
                    radius: 18,
                    backgroundImage: NetworkImage(AppImages.avatar),
                  ),
                  onTap: () {},
                ),
                SizedBox(width: 10),
                if (_user != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(context.l.greeting(_user!.firstName),
                          style: context.theme.textTheme.titleSmall),
                      Text(
                        greetingMessage,
                        style: context.theme.textTheme.titleSmall!.copyWith(
                            color: context.theme.colorScheme.onSecondary),
                      )
                    ],
                  ),
              ]),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 18.0),
                  child: IconButton(
                    icon: Icon(Icons.notifications_none_outlined),
                    onPressed: () {},
                  ),
                )
              ],
            ),
            drawer: _drawer(),
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 18.0),
              child: _content(),
            )));
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
          const SizedBox(
            height: 14,
          ),
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: context.l.search_password,
              prefixIcon: Image.asset(
                width: 20,
                'assets/icons/search.png',
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Text(
            context.l.home_page_title1,
            style: context.theme.textTheme.headlineSmall!
                .copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 24,
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _cardItems
                  .map((item) => PasswordCategoryCard(
                        onClick: item.onClick,
                        title: item.title,
                        color: item.color,
                        icon: item.icon,
                      ))
                  .toList())
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
