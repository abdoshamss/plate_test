part of 'general_cubit.dart';

@immutable
abstract class GeneralState {}

class GeneralInitial extends GeneralState {}

class GeneralChangeAppTheme extends GeneralState {}

class MarkAsSoldLoading extends GeneralState {}

class MarkAsSoldSuccess extends GeneralState {}

class MarkAsSoldError extends GeneralState {}

class LangChangedSuccessfully extends GeneralState {}
