import 'package:book_with_cubit/cubits/book/books_cubit.dart';
import 'package:book_with_cubit/data/model/book/book_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PatchScreen extends StatefulWidget {
  const PatchScreen({Key? key, required this.bookModel}) : super(key: key);

  final BookModel bookModel;

  @override
  State<PatchScreen> createState() => _PatchScreenState();
}

class _PatchScreenState extends State<PatchScreen> {

  @override
  void initState() {
    controllerTitle.text = widget.bookModel.title;
    controllerPublishYear.text = widget.bookModel.publishYear.toString();
    controllerNumberOfPages.text = widget.bookModel.numberOfPages.toString();
    controllerPrice.text = widget.bookModel.price.toString();
    super.initState();
  }


  final TextEditingController controllerTitle = TextEditingController();
  final TextEditingController controllerPublishYear = TextEditingController();
  final TextEditingController controllerNumberOfPages = TextEditingController();
  final TextEditingController controllerPrice = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BooksCubit, BooksState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("patch Screen"),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
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
                ElevatedButton(onPressed: () {
                  context.read<BooksCubit>().patchBook(
                      title: controllerTitle.text,
                      publishYear: int.parse(controllerPublishYear.text),
                      numberOfPages: int.parse(controllerNumberOfPages.text),
                      price: int.parse(controllerPrice.text),
                      id: widget.bookModel.id);
                  Navigator.pop(context);
                }, child: const Text("done"))
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    controllerNumberOfPages.dispose();
    controllerTitle.dispose();
    controllerPublishYear.dispose();
    controllerPrice.dispose();
    super.dispose();
  }
}
