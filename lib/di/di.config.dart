// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;
import 'package:lakukan_product_catalog/data/repositories/product_repository_impl.dart'
    as _i7;
import 'package:lakukan_product_catalog/di/modules.dart' as _i8;
import 'package:lakukan_product_catalog/domain/repositories/product_repository.dart'
    as _i6;
import 'package:lakukan_product_catalog/utils/http_client.dart' as _i5;
import 'package:logger/logger.dart' as _i4;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.singleton<_i3.Client>(() => registerModule.httpClient);
    gh.singleton<_i4.Logger>(() => registerModule.logger);
    gh.factory<_i5.HttpClient>(() => _i5.HttpClient(gh<_i3.Client>()));
    gh.lazySingleton<_i6.ProductRepository>(() => _i7.ProductRepositoryImpl(
          gh<_i5.HttpClient>(),
          gh<_i4.Logger>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i8.RegisterModule {}
