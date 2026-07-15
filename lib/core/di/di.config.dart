// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/data/data_sources/remote/auth_remote_data_source.dart'
    as _i432;
import '../../features/auth/data/data_sources/remote/auth_remote_data_source_impl.dart'
    as _i299;
import '../../features/auth/data/repositories/auth_repository_impl.dart'
    as _i153;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i787;
import '../../features/auth/domain/usecases/signup_use_case.dart' as _i229;
import '../../features/auth/presentation/cubit/auth_cubit.dart' as _i117;
import '../network/api_services/api_services.dart' as _i240;
import '../network/auth_interceptor.dart' as _i908;
import '../network/network_module.dart' as _i200;
import '../storage/secure_token_storage.dart' as _i535;
import '../storage/token_storage.dart' as _i973;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final networkModule = _$NetworkModule();
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => networkModule.secureStorage,
    );
    gh.lazySingleton<_i973.TokenStorage>(
      () => _i535.SecureTokenStorage(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i908.AuthInterceptor>(
      () => _i908.AuthInterceptor(gh<_i973.TokenStorage>()),
    );
    gh.lazySingleton<_i361.Dio>(
      () => networkModule.provideDio(gh<_i908.AuthInterceptor>()),
    );
    gh.lazySingleton<_i240.ApiServices>(
      () => networkModule.provideApiServices(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i432.AuthRemoteDataSource>(
      () => _i299.AuthRemoteDataSourceImpl(gh<_i240.ApiServices>()),
    );
    gh.lazySingleton<_i787.AuthRepository>(
      () => _i153.AuthRepositoryImpl(gh<_i432.AuthRemoteDataSource>()),
    );
    gh.lazySingleton<_i229.SignupUseCase>(
      () => _i229.SignupUseCase(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i117.AuthCubit>(
      () => _i117.AuthCubit(gh<_i229.SignupUseCase>()),
    );
    return this;
  }
}

class _$NetworkModule extends _i200.NetworkModule {}
