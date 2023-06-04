import 'package:esgi_tp_flutter/ui/pages/post_adding.dart';
import 'package:esgi_tp_flutter/ui/pages/post_details.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';
import 'data/source/api_posts_data_source.dart';
import 'ui/pages/home_page.dart';
import 'model/post.dart';
import 'data/repository/posts_repository.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => PostsRepository(
          postsDataSource: APIDataSource()
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        routes: {
          '/': (context) => const HomePage(),
        },
        onGenerateRoute: (settings) {
          Widget content = const SizedBox.shrink();

          switch (settings.name) {
            case PostDetails.routeName:
              final arguments = settings.arguments;
              if (arguments is Post) {
                content = PostDetails(post: arguments);
              }
              break;

            case PostAdding.routeName:
              content = PostAdding();
              break;
          }

          return MaterialPageRoute(
            builder: (context) {
              return content;
            },
          );
        },
      ),
    );
  }
}

