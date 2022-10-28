import 'package:bloc/bloc.dart';
import 'package:book_with_cubit/data/model/helper/helper_model.dart';
import 'package:book_with_cubit/data/model/publisher/publishers.dart';
import 'package:book_with_cubit/data/repositories/publishers_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'publishers_state.dart';

class PublishersCubit extends Cubit<PublishersState> {
  PublishersCubit({required this.publisherRepository}) : super(PublishersState(
      formzStatus: FormzStatus.pure,
      errorText: "",
      publishers: [],
  ),);

  final PublisherRepository publisherRepository;

  void getAllPublishers() async {
    emit(state.copyWith(formzStatus: FormzStatus.submissionInProgress));
    try{
      var publishers = await publisherRepository.getPublishers();
      emit(state.copyWith(formzStatus: FormzStatus.submissionSuccess, publishers: publishers));
    }catch(e){
      emit(
        state.copyWith(
          formzStatus: FormzStatus.submissionFailure,
          errorText: "getAllPublishersError",
        ),
      );
    }
  }

  void deletePublisherById({required int id}) async {
    emit(state.copyWith(formzStatus: FormzStatus.submissionInProgress));
    try{
      var publishers = await publisherRepository.deletePublisherById(id: id);
      if(publishers){
        getAllPublishers();
      }
    }catch(e){
      emit(
        state.copyWith(
          formzStatus: FormzStatus.submissionFailure,
          errorText: "deletePublishersError",
        ),
      );
    }
  }

  void addPublisher({required String name}) async {
    emit(state.copyWith(formzStatus: FormzStatus.submissionInProgress));
    try{
      var publishers = await publisherRepository.addPublisher(name: name);
      if(publishers.id > 0){
        getAllPublishers();
      }
    }catch(e){
      emit(
        state.copyWith(
          formzStatus: FormzStatus.submissionFailure,
          errorText: "addPublishersError",
        ),
      );
    }
  }

  void putPublishersById({required String name, required int id}) async {
    emit(state.copyWith(formzStatus: FormzStatus.submissionInProgress));
    try{
      var publishers = await publisherRepository.putPublishersById(id: id, name: name);
      if(publishers.id > 0){
        getAllPublishers();
      }
    }catch(e){
      emit(
        state.copyWith(
          formzStatus: FormzStatus.submissionFailure,
          errorText: "putPublishersError",
        ),
      );
    }
  }
}