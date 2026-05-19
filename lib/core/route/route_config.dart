part of 'route_import_path.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.homeScreen:
        return MaterialPageRoute(builder: (context) =>  HomeScreen());
      

      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            backgroundColor: ColorManager.whiteColor,
            body: Center(child: Text('No Screen Found!')),
          ),
        );
    }
  }
}