// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'app_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$AppStateTearOff {
  const _$AppStateTearOff();

// ignore: unused_element
  _AppState call({String title, int pageIndex, List<Todo> todoList}) {
    return _AppState(
      title: title,
      pageIndex: pageIndex,
      todoList: todoList,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $AppState = _$AppStateTearOff();

/// @nodoc
mixin _$AppState {
  String get title;
  int get pageIndex;
  List<Todo> get todoList;

  $AppStateCopyWith<AppState> get copyWith;
}

/// @nodoc
abstract class $AppStateCopyWith<$Res> {
  factory $AppStateCopyWith(AppState value, $Res Function(AppState) then) =
      _$AppStateCopyWithImpl<$Res>;
  $Res call({String title, int pageIndex, List<Todo> todoList});
}

/// @nodoc
class _$AppStateCopyWithImpl<$Res> implements $AppStateCopyWith<$Res> {
  _$AppStateCopyWithImpl(this._value, this._then);

  final AppState _value;
  // ignore: unused_field
  final $Res Function(AppState) _then;

  @override
  $Res call({
    Object title = freezed,
    Object pageIndex = freezed,
    Object todoList = freezed,
  }) {
    return _then(_value.copyWith(
      title: title == freezed ? _value.title : title as String,
      pageIndex: pageIndex == freezed ? _value.pageIndex : pageIndex as int,
      todoList: todoList == freezed ? _value.todoList : todoList as List<Todo>,
    ));
  }
}

/// @nodoc
abstract class _$AppStateCopyWith<$Res> implements $AppStateCopyWith<$Res> {
  factory _$AppStateCopyWith(_AppState value, $Res Function(_AppState) then) =
      __$AppStateCopyWithImpl<$Res>;
  @override
  $Res call({String title, int pageIndex, List<Todo> todoList});
}

/// @nodoc
class __$AppStateCopyWithImpl<$Res> extends _$AppStateCopyWithImpl<$Res>
    implements _$AppStateCopyWith<$Res> {
  __$AppStateCopyWithImpl(_AppState _value, $Res Function(_AppState) _then)
      : super(_value, (v) => _then(v as _AppState));

  @override
  _AppState get _value => super._value as _AppState;

  @override
  $Res call({
    Object title = freezed,
    Object pageIndex = freezed,
    Object todoList = freezed,
  }) {
    return _then(_AppState(
      title: title == freezed ? _value.title : title as String,
      pageIndex: pageIndex == freezed ? _value.pageIndex : pageIndex as int,
      todoList: todoList == freezed ? _value.todoList : todoList as List<Todo>,
    ));
  }
}

/// @nodoc
class _$_AppState implements _AppState {
  const _$_AppState({this.title, this.pageIndex, this.todoList});

  @override
  final String title;
  @override
  final int pageIndex;
  @override
  final List<Todo> todoList;

  @override
  String toString() {
    return 'AppState(title: $title, pageIndex: $pageIndex, todoList: $todoList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AppState &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.pageIndex, pageIndex) ||
                const DeepCollectionEquality()
                    .equals(other.pageIndex, pageIndex)) &&
            (identical(other.todoList, todoList) ||
                const DeepCollectionEquality()
                    .equals(other.todoList, todoList)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(pageIndex) ^
      const DeepCollectionEquality().hash(todoList);

  @override
  _$AppStateCopyWith<_AppState> get copyWith =>
      __$AppStateCopyWithImpl<_AppState>(this, _$identity);
}

abstract class _AppState implements AppState {
  const factory _AppState({String title, int pageIndex, List<Todo> todoList}) =
      _$_AppState;

  @override
  String get title;
  @override
  int get pageIndex;
  @override
  List<Todo> get todoList;
  @override
  _$AppStateCopyWith<_AppState> get copyWith;
}
