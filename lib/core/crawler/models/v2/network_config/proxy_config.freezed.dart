// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'proxy_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProxyServer {

/// 服务器地址。
 String get host;/// 端口。
 int get port;/// 代理类型。
 ProxyType get type;/// 用户名。
 String? get username;/// 密码。
 String? get password;/// 权重 (用于加权轮换)。
 int get weight;
/// Create a copy of ProxyServer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProxyServerCopyWith<ProxyServer> get copyWith => _$ProxyServerCopyWithImpl<ProxyServer>(this as ProxyServer, _$identity);

  /// Serializes this ProxyServer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProxyServer&&(identical(other.host, host) || other.host == host)&&(identical(other.port, port) || other.port == port)&&(identical(other.type, type) || other.type == type)&&(identical(other.username, username) || other.username == username)&&(identical(other.password, password) || other.password == password)&&(identical(other.weight, weight) || other.weight == weight));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,host,port,type,username,password,weight);

@override
String toString() {
  return 'ProxyServer(host: $host, port: $port, type: $type, username: $username, password: $password, weight: $weight)';
}


}

/// @nodoc
abstract mixin class $ProxyServerCopyWith<$Res>  {
  factory $ProxyServerCopyWith(ProxyServer value, $Res Function(ProxyServer) _then) = _$ProxyServerCopyWithImpl;
@useResult
$Res call({
 String host, int port, ProxyType type, String? username, String? password, int weight
});




}
/// @nodoc
class _$ProxyServerCopyWithImpl<$Res>
    implements $ProxyServerCopyWith<$Res> {
  _$ProxyServerCopyWithImpl(this._self, this._then);

  final ProxyServer _self;
  final $Res Function(ProxyServer) _then;

/// Create a copy of ProxyServer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? host = null,Object? port = null,Object? type = null,Object? username = freezed,Object? password = freezed,Object? weight = null,}) {
  return _then(_self.copyWith(
host: null == host ? _self.host : host // ignore: cast_nullable_to_non_nullable
as String,port: null == port ? _self.port : port // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ProxyType,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,password: freezed == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String?,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ProxyServer].
extension ProxyServerPatterns on ProxyServer {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProxyServer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProxyServer() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProxyServer value)  $default,){
final _that = this;
switch (_that) {
case _ProxyServer():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProxyServer value)?  $default,){
final _that = this;
switch (_that) {
case _ProxyServer() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String host,  int port,  ProxyType type,  String? username,  String? password,  int weight)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProxyServer() when $default != null:
return $default(_that.host,_that.port,_that.type,_that.username,_that.password,_that.weight);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String host,  int port,  ProxyType type,  String? username,  String? password,  int weight)  $default,) {final _that = this;
switch (_that) {
case _ProxyServer():
return $default(_that.host,_that.port,_that.type,_that.username,_that.password,_that.weight);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String host,  int port,  ProxyType type,  String? username,  String? password,  int weight)?  $default,) {final _that = this;
switch (_that) {
case _ProxyServer() when $default != null:
return $default(_that.host,_that.port,_that.type,_that.username,_that.password,_that.weight);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProxyServer implements ProxyServer {
  const _ProxyServer({required this.host, required this.port, required this.type, this.username, this.password, this.weight = 1});
  factory _ProxyServer.fromJson(Map<String, dynamic> json) => _$ProxyServerFromJson(json);

/// 服务器地址。
@override final  String host;
/// 端口。
@override final  int port;
/// 代理类型。
@override final  ProxyType type;
/// 用户名。
@override final  String? username;
/// 密码。
@override final  String? password;
/// 权重 (用于加权轮换)。
@override@JsonKey() final  int weight;

/// Create a copy of ProxyServer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProxyServerCopyWith<_ProxyServer> get copyWith => __$ProxyServerCopyWithImpl<_ProxyServer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProxyServerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProxyServer&&(identical(other.host, host) || other.host == host)&&(identical(other.port, port) || other.port == port)&&(identical(other.type, type) || other.type == type)&&(identical(other.username, username) || other.username == username)&&(identical(other.password, password) || other.password == password)&&(identical(other.weight, weight) || other.weight == weight));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,host,port,type,username,password,weight);

@override
String toString() {
  return 'ProxyServer(host: $host, port: $port, type: $type, username: $username, password: $password, weight: $weight)';
}


}

/// @nodoc
abstract mixin class _$ProxyServerCopyWith<$Res> implements $ProxyServerCopyWith<$Res> {
  factory _$ProxyServerCopyWith(_ProxyServer value, $Res Function(_ProxyServer) _then) = __$ProxyServerCopyWithImpl;
@override @useResult
$Res call({
 String host, int port, ProxyType type, String? username, String? password, int weight
});




}
/// @nodoc
class __$ProxyServerCopyWithImpl<$Res>
    implements _$ProxyServerCopyWith<$Res> {
  __$ProxyServerCopyWithImpl(this._self, this._then);

  final _ProxyServer _self;
  final $Res Function(_ProxyServer) _then;

/// Create a copy of ProxyServer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? host = null,Object? port = null,Object? type = null,Object? username = freezed,Object? password = freezed,Object? weight = null,}) {
  return _then(_ProxyServer(
host: null == host ? _self.host : host // ignore: cast_nullable_to_non_nullable
as String,port: null == port ? _self.port : port // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ProxyType,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,password: freezed == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String?,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ProxyConfig {

/// 代理服务器列表。
 List<ProxyServer> get servers;/// 轮换策略。
 ProxyRotation get rotation;/// 失败时是否切换代理。
 bool get failover;/// 验证 URL。
 String? get testUrl;
/// Create a copy of ProxyConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProxyConfigCopyWith<ProxyConfig> get copyWith => _$ProxyConfigCopyWithImpl<ProxyConfig>(this as ProxyConfig, _$identity);

  /// Serializes this ProxyConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProxyConfig&&const DeepCollectionEquality().equals(other.servers, servers)&&(identical(other.rotation, rotation) || other.rotation == rotation)&&(identical(other.failover, failover) || other.failover == failover)&&(identical(other.testUrl, testUrl) || other.testUrl == testUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(servers),rotation,failover,testUrl);

@override
String toString() {
  return 'ProxyConfig(servers: $servers, rotation: $rotation, failover: $failover, testUrl: $testUrl)';
}


}

/// @nodoc
abstract mixin class $ProxyConfigCopyWith<$Res>  {
  factory $ProxyConfigCopyWith(ProxyConfig value, $Res Function(ProxyConfig) _then) = _$ProxyConfigCopyWithImpl;
@useResult
$Res call({
 List<ProxyServer> servers, ProxyRotation rotation, bool failover, String? testUrl
});




}
/// @nodoc
class _$ProxyConfigCopyWithImpl<$Res>
    implements $ProxyConfigCopyWith<$Res> {
  _$ProxyConfigCopyWithImpl(this._self, this._then);

  final ProxyConfig _self;
  final $Res Function(ProxyConfig) _then;

/// Create a copy of ProxyConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? servers = null,Object? rotation = null,Object? failover = null,Object? testUrl = freezed,}) {
  return _then(_self.copyWith(
servers: null == servers ? _self.servers : servers // ignore: cast_nullable_to_non_nullable
as List<ProxyServer>,rotation: null == rotation ? _self.rotation : rotation // ignore: cast_nullable_to_non_nullable
as ProxyRotation,failover: null == failover ? _self.failover : failover // ignore: cast_nullable_to_non_nullable
as bool,testUrl: freezed == testUrl ? _self.testUrl : testUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProxyConfig].
extension ProxyConfigPatterns on ProxyConfig {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProxyConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProxyConfig() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProxyConfig value)  $default,){
final _that = this;
switch (_that) {
case _ProxyConfig():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProxyConfig value)?  $default,){
final _that = this;
switch (_that) {
case _ProxyConfig() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ProxyServer> servers,  ProxyRotation rotation,  bool failover,  String? testUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProxyConfig() when $default != null:
return $default(_that.servers,_that.rotation,_that.failover,_that.testUrl);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ProxyServer> servers,  ProxyRotation rotation,  bool failover,  String? testUrl)  $default,) {final _that = this;
switch (_that) {
case _ProxyConfig():
return $default(_that.servers,_that.rotation,_that.failover,_that.testUrl);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ProxyServer> servers,  ProxyRotation rotation,  bool failover,  String? testUrl)?  $default,) {final _that = this;
switch (_that) {
case _ProxyConfig() when $default != null:
return $default(_that.servers,_that.rotation,_that.failover,_that.testUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProxyConfig implements ProxyConfig {
  const _ProxyConfig({required final  List<ProxyServer> servers, this.rotation = ProxyRotation.roundRobin, this.failover = true, this.testUrl}): _servers = servers;
  factory _ProxyConfig.fromJson(Map<String, dynamic> json) => _$ProxyConfigFromJson(json);

/// 代理服务器列表。
 final  List<ProxyServer> _servers;
/// 代理服务器列表。
@override List<ProxyServer> get servers {
  if (_servers is EqualUnmodifiableListView) return _servers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_servers);
}

/// 轮换策略。
@override@JsonKey() final  ProxyRotation rotation;
/// 失败时是否切换代理。
@override@JsonKey() final  bool failover;
/// 验证 URL。
@override final  String? testUrl;

/// Create a copy of ProxyConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProxyConfigCopyWith<_ProxyConfig> get copyWith => __$ProxyConfigCopyWithImpl<_ProxyConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProxyConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProxyConfig&&const DeepCollectionEquality().equals(other._servers, _servers)&&(identical(other.rotation, rotation) || other.rotation == rotation)&&(identical(other.failover, failover) || other.failover == failover)&&(identical(other.testUrl, testUrl) || other.testUrl == testUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_servers),rotation,failover,testUrl);

@override
String toString() {
  return 'ProxyConfig(servers: $servers, rotation: $rotation, failover: $failover, testUrl: $testUrl)';
}


}

/// @nodoc
abstract mixin class _$ProxyConfigCopyWith<$Res> implements $ProxyConfigCopyWith<$Res> {
  factory _$ProxyConfigCopyWith(_ProxyConfig value, $Res Function(_ProxyConfig) _then) = __$ProxyConfigCopyWithImpl;
@override @useResult
$Res call({
 List<ProxyServer> servers, ProxyRotation rotation, bool failover, String? testUrl
});




}
/// @nodoc
class __$ProxyConfigCopyWithImpl<$Res>
    implements _$ProxyConfigCopyWith<$Res> {
  __$ProxyConfigCopyWithImpl(this._self, this._then);

  final _ProxyConfig _self;
  final $Res Function(_ProxyConfig) _then;

/// Create a copy of ProxyConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? servers = null,Object? rotation = null,Object? failover = null,Object? testUrl = freezed,}) {
  return _then(_ProxyConfig(
servers: null == servers ? _self._servers : servers // ignore: cast_nullable_to_non_nullable
as List<ProxyServer>,rotation: null == rotation ? _self.rotation : rotation // ignore: cast_nullable_to_non_nullable
as ProxyRotation,failover: null == failover ? _self.failover : failover // ignore: cast_nullable_to_non_nullable
as bool,testUrl: freezed == testUrl ? _self.testUrl : testUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
