// import 'package:equatable/equatable.dart';

abstract class FormSubmissionState {
  const FormSubmissionState();
}

class InitialFormStatus extends FormSubmissionState {
  const InitialFormStatus();
}

class FormSubmitting extends FormSubmissionState {}

class SubmissionSuccess extends FormSubmissionState {}

class SubmissionFailed extends FormSubmissionState {
  final Exception exception;

  SubmissionFailed(this.exception);
}
class SubmissionSuccessWithData extends FormSubmissionState {
  List<Object> response = []; // Add a field to store the response data

  SubmissionSuccessWithData(this.response);

  @override
  List<Object> get props => [response];
}