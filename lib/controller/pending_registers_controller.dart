import 'package:tcc_ceclimar/models/register_response.dart';
import 'package:tcc_ceclimar/utils/register_seeds.dart';

class PendingRegistersController {
  
  List<RegisterResponse> getRegisters(){ //todo remover mocks
      return RegisterSeeds().registerSeeds();
  }
}