import 'package:tut_app/app/extensions.dart';
import 'package:tut_app/data/responses/responses.dart';
import 'package:tut_app/domain/model/model.dart';

// const theEmpty = "";
// const theZero = 0;
//
// extension CustomerResponseMapper on CustomerResponse? {
//   Customer toDomain() {
//     return Customer(
//         this?.id?.orEmpty() ?? theEmpty,
//         this?.name?.orEmpty() ?? theEmpty,
//         this?.numberOfNotification?.orZero() ?? theZero);
//   }
// }
//
// extension ContactsResponseMapper on ContactsResponse? {
//   Contacts toDomain() {
//     return Contacts(this?.email?.orEmpty() ?? theEmpty, this?.phone?.orEmpty() ?? theEmpty , this?.link?.orEmpty() ?? theEmpty);
//   }
// }
// extension AuthenticationResponseMapper on AuthenticationResponse? {
//   Authentication toDomain() {
//     return Authentication(this?.customer?.toDomain(), this?.contacts.toDomain());
//   }
// }

const EMPTY = "";
const ZERO = 0;

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
        this?.id?.orEmpty() ?? EMPTY,
        this?.name?.orEmpty() ?? EMPTY,
        this?.numberOfNotification?.orZero() ?? ZERO);
  }
}

extension ContactsResponseMapper on ContactsResponse? {
  Contacts toDomain() {
    return Contacts(this?.email?.orEmpty() ?? EMPTY,
        this?.phone?.orEmpty() ?? EMPTY, this?.link?.orEmpty() ?? EMPTY);
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(
        this?.customer?.toDomain(), this?.contacts?.toDomain());
  }
}