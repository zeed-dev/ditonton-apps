import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/tv_page.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/presentation/pages/watchlist_tv_page.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/circle-g.png'),
            ),
            accountName: Text('Ditonton'),
            accountEmail: Text('ditonton@dicoding.com'),
          ),
          ListTile(
            leading: Icon(Icons.movie),
            title: Text('Movies'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.save_alt),
            title: Text('Watchlist Movies'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
            },
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, TvPage.ROUTE_NAME);
            },
            leading: Icon(Icons.tv_outlined),
            title: Text('Tv'),
          ),
          ListTile(
            leading: Icon(Icons.save_outlined),
            title: Text('Watchlist Tv'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, WatchlistTvPage.ROUTE_NAME);
            },
          ),
          Divider(thickness: 2),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
            },
            leading: Icon(Icons.info_outline),
            title: Text('About'),
          ),
        ],
      ),
    );
  }
}
