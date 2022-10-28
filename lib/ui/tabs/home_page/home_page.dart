import 'package:book_with_cubit/cubits/book/books_cubit.dart';
import 'package:book_with_cubit/cubits/helper/helper_cubit.dart';
import 'package:book_with_cubit/data/model/book/book_model.dart';
import 'package:book_with_cubit/ui/tabs/home_page/sub_screens/patch_screen.dart';
import 'package:book_with_cubit/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:formz/formz.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    BlocProvider.of<BooksCubit>(context).getAllBooks();
    BlocProvider.of<HelperCubit>(context).getLanguages();
    BlocProvider.of<HelperCubit>(context).getGenres();
    super.initState();
  }

  int languageId = 0;
  int genreId = 0;

  final TextEditingController controllerTitle = TextEditingController();
  final TextEditingController controllerPublishYear = TextEditingController();
  final TextEditingController controllerNumberOfPages = TextEditingController();
  final TextEditingController controllerPrice = TextEditingController();

  /*
  {
  "publisherId": 1,
  "genre": 3,
  "language": 0
}
   */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home page"),
      ),
      body: BlocBuilder<BooksCubit, BooksState>(
        builder: (BuildContext context, state) {
          if (state.formzStatus == FormzStatus.submissionInProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.formzStatus == FormzStatus.submissionFailure) {
            return const Center(
              child: Text("Error"),
            );
          } else {
            return ListView(
              children: List.generate(
                state.books.length,
                (index) => Slidable(
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        flex: 2,
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        icon: Icons.archive,
                        label: 'update',
                        onPressed: (BuildContext context) {
                          Navigator.pushNamed(context, patchPage,
                              arguments: state.books[index]);
                        },
                      ),
                      SlidableAction(
                        flex: 1,
                        onPressed: (BuildContext context) {
                          context
                              .read<BooksCubit>()
                              .deleteBookById(state.books[index].id);
                        },
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(state.books[index].title),
                    subtitle: Text(state.books[index].price.toString()),
                  ),
                ),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var items = context
              .read<HelperCubit>()
              .languageList
              .map((element) => element.name)
              .toList();
          var itemsGenre = context
              .read<HelperCubit>()
              .genresList
              .map((element) => element.name)
              .toList();
          showMaterialModalBottomSheet(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              context: context,
              builder: (context) => SizedBox(
                    height: MediaQuery.of(context).size.height - 200,
                    width: MediaQuery.of(context).size.width,
                    child: StatefulBuilder(
                      builder: (context, setState) {
                        return Scaffold(
                          resizeToAvoidBottomInset: false,
                          body: Container(
                            margin: const EdgeInsets.all(16),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  TextField(
                                    decoration: const InputDecoration(
                                      hintText: "name",
                                    ),
                                    controller: controllerTitle,
                                  ),
                                  const SizedBox(height: 10),
                                  TextField(
                                    decoration: const InputDecoration(
                                      hintText: "publishedYear",
                                    ),
                                    keyboardType: TextInputType.number,
                                    controller: controllerPublishYear,
                                  ),
                                  const SizedBox(height: 10),
                                  TextField(
                                    decoration: const InputDecoration(
                                      hintText: "numberOfPages",
                                    ),
                                    keyboardType: TextInputType.number,
                                    controller: controllerNumberOfPages,
                                  ),
                                  const SizedBox(height: 10),
                                  TextField(
                                    decoration: const InputDecoration(
                                      hintText: "Price",
                                    ),
                                    keyboardType: TextInputType.number,
                                    controller: controllerPrice,
                                  ),
                                  const SizedBox(height: 10),
                                  ExpansionTile(
                                    title: const Text("language select"),
                                    children: List.generate(
                                        items.length,
                                        (index) => TextButton(
                                            onPressed: () {
                                              languageId = index;
                                            },
                                            child: Text(items[index]))),
                                  ),
                                  const SizedBox(height: 10),
                                  ExpansionTile(
                                    title: const Text("select genre"),
                                    children: List.generate(
                                        itemsGenre.length,
                                            (index) => TextButton(
                                            onPressed: () {
                                              genreId = index;
                                            },
                                            child: Text(itemsGenre[index]))),
                                  ),
                                  ElevatedButton(onPressed: () {
                                    context.read<BooksCubit>().addBook(
                                        BookModel(
                                            id: -1,
                                            title: controllerTitle.text,
                                            genre: genreId,
                                            isbn: "",
                                            language: languageId,
                                            numberOfPages: int.parse(controllerNumberOfPages.text),
                                            price: int.parse(controllerNumberOfPages.text),
                                            publisherId: 43,
                                            publishYear: int.parse(controllerNumberOfPages.text)
                                        ));
                                    
                                    Navigator.pop(context);
                                  }, child: const Text("done"))
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ));
        },
        child: const Icon(Icons.add_circle_outline_sharp),
      ),
    );
  }

  @override
  void dispose() {
    controllerTitle.dispose();
    controllerPublishYear.dispose();
    controllerNumberOfPages.dispose();
    controllerPrice.dispose();
    super.dispose();
  }
}
/*
 */
