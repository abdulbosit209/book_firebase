import 'package:bloc/bloc.dart';
import 'package:book_with_cubit/data/model/book/book_model.dart';
import 'package:book_with_cubit/data/repositories/books_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'books_state.dart';

class BooksCubit extends Cubit<BooksState> {
  BooksCubit({
    required this.booksRepository,
  }) : super(
          BooksState(
            books: [],
            formzStatus: FormzStatus.pure,
            errorText: "",
          ),
        );

  final BooksRepository booksRepository;

  void getAllBooks() async {
    emit(state.copyWith(formzStatus: FormzStatus.submissionInProgress));
    try {
      var books = await booksRepository.getAllBooks();
      emit(
        state.copyWith(
          formzStatus: FormzStatus.submissionSuccess,
          books: books,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          formzStatus: FormzStatus.submissionFailure,
          errorText: "getAllBooksError",
        ),
      );
    }
  }

  void deleteBookById(int id) async {
    emit(state.copyWith(formzStatus: FormzStatus.submissionInProgress));
    try {
      var isRemoved = await booksRepository.deleteBookById(id: id);
      if (isRemoved) {
        getAllBooks();
      }
    } catch (error) {
      emit(
        state.copyWith(
          formzStatus: FormzStatus.submissionFailure,
          errorText: "deleteBookError",
        ),
      );
    }
  }

  void patchBook(
      {required String title,
      required int publishYear,
      required int numberOfPages,
      required int price,
      required int id}) async {
    emit(state.copyWith(formzStatus: FormzStatus.submissionInProgress));
    try {
      var isRemoved = await booksRepository.updatePatch(
          title: title,
          publishYear: publishYear,
          numberOfPages: numberOfPages,
          price: price,
          id: id);
      if (isRemoved.id > 0) {
        getAllBooks();
      }
    } catch (error) {
      emit(
        state.copyWith(
          formzStatus: FormzStatus.submissionFailure,
          errorText: "patchBookError",
        ),
      );
    }
  }

  void addBook(BookModel bookModel) async {
    emit(state.copyWith(formzStatus: FormzStatus.submissionInProgress));
    try {
      var fullBook = await booksRepository.addBook(bookModel: bookModel);
      if (fullBook.id > 0) {
        getAllBooks();
      }
    } catch (error) {
      emit(
        state.copyWith(
          formzStatus: FormzStatus.submissionFailure,
          errorText: "addBookError",
        ),
      );
    }
  }
}
