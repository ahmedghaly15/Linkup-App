import 'package:social_app/core/usecases/regular_usecase.dart';
import 'package:social_app/features/linkup/domain/entities/change_index_params.dart';
import 'package:social_app/features/linkup/domain/repositories/linkup_repo.dart';

class ChangeBottomNavIndexUseCase
    implements RegularUseCases<void, ChangeIndexParams> {
  final LinkupRepo linkupRepo;

  const ChangeBottomNavIndexUseCase({required this.linkupRepo});

  @override
  void call(ChangeIndexParams params) {
    linkupRepo.changeBottomNavIndex(changeIndexParams: params);
  }
}
