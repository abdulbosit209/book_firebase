import 'package:book_with_cubit/cubits/book/books_cubit.dart';
import 'package:book_with_cubit/cubits/helper/helper_cubit.dart';
import 'package:book_with_cubit/cubits/publisher/publishers_cubit.dart';
import 'package:book_with_cubit/data/locals/storage.dart';
import 'package:book_with_cubit/data/repositories/books_repository.dart';
import 'package:book_with_cubit/data/repositories/helper_repository.dart';
import 'package:book_with_cubit/data/repositories/publishers_repository.dart';
import 'package:book_with_cubit/data/services/api_client.dart';
import 'package:book_with_cubit/data/services/api_provider.dart';
import 'package:book_with_cubit/ui/router.dart';
import 'package:book_with_cubit/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageRepository.getInstance();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(App());
}
  // runApp(const MyApp());
class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  final ApiProvider apiProvider = ApiProvider(
    apiClient: ApiClient(),
  );

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<BooksRepository>(
            create: (_) => BooksRepository(apiProvider: apiProvider),
          ),
          RepositoryProvider<PublisherRepository>(
            create: (_) => PublisherRepository(apiProvider: apiProvider),
          )
        ],
        child: MultiBlocProvider(providers: [
          BlocProvider(
            create: (BuildContext context) => BooksCubit(
              booksRepository: context.read<BooksRepository>(),
            ),
          ),
          BlocProvider(
            create: (BuildContext context) => HelperCubit(
              helperRepository: HelperRepository(apiProvider: apiProvider),
            ),
          ),
          BlocProvider(
            create: (BuildContext context) => PublishersCubit(
              publisherRepository: context.read<PublisherRepository>(),
            ),
          )

        ], child: MyApp()));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
        onGenerateRoute: MyRouter.generateRoute,
      initialRoute: homePage,
    );
  }
}
