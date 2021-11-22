// To parse this JSON data, do
//
//     final userConnectedAccountModel = userConnectedAccountModelFromJson(jsonString);

import 'dart:convert';

UserConnectedAccountModel userConnectedAccountModelFromJson(String str) => UserConnectedAccountModel.fromJson(json.decode(str));

String userConnectedAccountModelToJson(UserConnectedAccountModel data) => json.encode(data.toJson());

class UserConnectedAccountModel {
  UserConnectedAccountModel({
    this.status,
    this.code,
    this.creditCardProcessor,
    this.additionalPaymentOptions,
  });

  bool status;
  int code;
  List<CreditCardProcessor> creditCardProcessor;
  List<AdditionalPaymentOption> additionalPaymentOptions;

  factory UserConnectedAccountModel.fromJson(Map<String, dynamic> json) => UserConnectedAccountModel(
    status: json["status"] == null ? null : json["status"],
    code: json["code"] == null ? null : int.parse(json["code"].toString()),
    creditCardProcessor: json["Credit_Card_Processor"] == null ? null : List<CreditCardProcessor>.from(json["Credit_Card_Processor"].map((x) => CreditCardProcessor.fromJson(x))),
    additionalPaymentOptions: json["Additional_Payment_Options"] == null ? null : List<AdditionalPaymentOption>.from(json["Additional_Payment_Options"].map((x) => AdditionalPaymentOption.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "code": code == null ? null : code,
    "Credit_Card_Processor": creditCardProcessor == null ? null : List<dynamic>.from(creditCardProcessor.map((x) => x.toJson())),
    "Additional_Payment_Options": additionalPaymentOptions == null ? null : List<dynamic>.from(additionalPaymentOptions.map((x) => x.toJson())),
  };
}

class AdditionalPaymentOption {
  AdditionalPaymentOption({
    this.id,
    this.userId,
    this.account,
    this.isActive,
    this.updatedAt,
    this.createdAt,
  });

  String id;
  String userId;
  AdditionalPaymentOptionAccount account;
  bool isActive;
  DateTime updatedAt;
  DateTime createdAt;

  factory AdditionalPaymentOption.fromJson(Map<String, dynamic> json) => AdditionalPaymentOption(
    id: json["_id"] == null ? null : json["_id"].toString(),
    userId: json["user_id"] == null ? null : json["user_id"].toString(),
    account: json["account"] == null ? null : AdditionalPaymentOptionAccount.fromJson(json["account"]),
    isActive: json["isActive"] == null ? null : json["isActive"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "user_id": userId == null ? null : userId,
    "account": account == null ? null : account.toJson(),
    "isActive": isActive == null ? null : isActive,
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
  };
}

class AdditionalPaymentOptionAccount {
  AdditionalPaymentOptionAccount({
    this.type,
    this.processorName,
    this.apiUsername,
    this.apiPassword,
    this.apiSignature,
    this.apiKey,
  });

  String type;
  String processorName;
  String apiUsername;
  String apiPassword;
  String apiSignature;
  String apiKey;

  factory AdditionalPaymentOptionAccount.fromJson(Map<String, dynamic> json) => AdditionalPaymentOptionAccount(
    type: json["type"] == null ? null : json["type"].toString(),
    processorName: json["processor_name"] == null ? null : json["processor_name"].toString(),
    apiUsername: json["api_username"] == null ? null : json["api_username"].toString(),
    apiPassword: json["api_password"] == null ? null : json["api_password"].toString(),
    apiSignature: json["api_signature"] == null ? null : json["api_signature"].toString(),
    apiKey: json["api_key"] == null ? null : json["api_key"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "type": type == null ? null : type,
    "processor_name": processorName == null ? null : processorName,
    "api_username": apiUsername == null ? null : apiUsername,
    "api_password": apiPassword == null ? null : apiPassword,
    "api_signature": apiSignature == null ? null : apiSignature,
    "api_key": apiKey == null ? null : apiKey,
  };
}

class CreditCardProcessor {
  CreditCardProcessor({
    this.id,
    this.userId,
    this.account,
    this.isActive,
    this.updatedAt,
    this.createdAt,
  });

  String id;
  String userId;
  CreditCardProcessorAccount account;
  bool isActive;
  DateTime updatedAt;
  DateTime createdAt;

  factory CreditCardProcessor.fromJson(Map<String, dynamic> json) => CreditCardProcessor(
    id: json["_id"] == null ? null : json["_id"].toString(),
    userId: json["user_id"] == null ? null : json["user_id"].toString(),
    account: json["account"] == null ? null : CreditCardProcessorAccount.fromJson(json["account"]),
    isActive: json["isActive"] == null ? null : json["isActive"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "user_id": userId == null ? null : userId,
    "account": account == null ? null : account.toJson(),
    "isActive": isActive == null ? null : isActive,
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
  };
}

class CreditCardProcessorAccount {
  CreditCardProcessorAccount({
    this.type,
    this.processorName,
    this.apiLoginId,
    this.apiTransactionKey,
    this.apiSignatureKey,
    this.stripeUserId,
    this.emailId,
    this.chargesEnabled,
    this.cardPaymentsStatus,
    this.country,
    this.currency,
    this.apiSecurityKey,
    this.liveMerchantId,
    this.livePublicKey,
    this.livePrivateKey,
    this.sandboxMerchantId,
    this.sandboxPublicKey,
    this.sandboxPrivateKey,
  });

  String type;
  String processorName;
  String apiLoginId;
  String apiTransactionKey;
  String apiSignatureKey;
  String stripeUserId;
  String emailId;
  bool chargesEnabled;
  String cardPaymentsStatus;
  String country;
  String currency;
  String apiSecurityKey;
  String liveMerchantId;
  String livePublicKey;
  String livePrivateKey;
  String sandboxMerchantId;
  String sandboxPublicKey;
  String sandboxPrivateKey;

  factory CreditCardProcessorAccount.fromJson(Map<String, dynamic> json) => CreditCardProcessorAccount(
    type: json["type"] == null ? null : json["type"].toString(),
    processorName: json["processor_name"] == null ? null : json["processor_name"].toString(),
    apiLoginId: json["api_login_id"] == null ? null : json["api_login_id"].toString(),
    apiTransactionKey: json["api_transaction_key"] == null ? null : json["api_transaction_key"].toString(),
    apiSignatureKey: json["api_signature_key"] == null ? null : json["api_signature_key"].toString(),
    stripeUserId: json["stripe_user_id"] == null ? null : json["stripe_user_id"].toString(),
    emailId: json["email_id"] == null ? null : json["email_id"].toString(),
    chargesEnabled: json["charges_enabled"] == null ? null : json["charges_enabled"],
    cardPaymentsStatus: json["card_payments_status"] == null ? null : json["card_payments_status"].toString(),
    country: json["country"] == null ? null : json["country"].toString(),
    currency: json["currency"] == null ? null : json["currency"].toString(),
    apiSecurityKey: json["api_security_key"] == null ? null : json["api_security_key"].toString(),
    liveMerchantId: json["live_merchant_id"] == null ? null : json["live_merchant_id"].toString(),
    livePublicKey: json["live_public_key"] == null ? null : json["live_public_key"].toString(),
    livePrivateKey: json["live_private_key"] == null ? null : json["live_private_key"].toString(),
    sandboxMerchantId: json["sandbox_merchant_id"] == null ? null : json["sandbox_merchant_id"].toString(),
    sandboxPublicKey: json["sandbox_public_key"] == null ? null : json["sandbox_public_key"].toString(),
    sandboxPrivateKey: json["sandbox_private_key"] == null ? null : json["sandbox_private_key"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "type": type == null ? null : type,
    "processor_name": processorName == null ? null : processorName,
    "api_login_id": apiLoginId == null ? null : apiLoginId,
    "api_transaction_key": apiTransactionKey == null ? null : apiTransactionKey,
    "api_signature_key": apiSignatureKey == null ? null : apiSignatureKey,
    "stripe_user_id": stripeUserId == null ? null : stripeUserId,
    "email_id": emailId == null ? null : emailId,
    "charges_enabled": chargesEnabled == null ? null : chargesEnabled,
    "card_payments_status": cardPaymentsStatus == null ? null : cardPaymentsStatus,
    "country": country == null ? null : country,
    "currency": currency == null ? null : currency,
    "api_security_key": apiSecurityKey == null ? null : apiSecurityKey,
    "live_merchant_id": liveMerchantId == null ? null : liveMerchantId,
    "live_public_key": livePublicKey == null ? null : livePublicKey,
    "live_private_key": livePrivateKey == null ? null : livePrivateKey,
    "sandbox_merchant_id": sandboxMerchantId == null ? null : sandboxMerchantId,
    "sandbox_public_key": sandboxPublicKey == null ? null : sandboxPublicKey,
    "sandbox_private_key": sandboxPrivateKey == null ? null : sandboxPrivateKey,
  };
}


// // To parse this JSON data, do
// //
// //     final userConnectedAccountModel = userConnectedAccountModelFromJson(jsonString);
//
// import 'dart:convert';
//
// UserConnectedAccountModel userConnectedAccountModelFromJson(String str) =>
//     UserConnectedAccountModel.fromJson(json.decode(str));
//
// String userConnectedAccountModelToJson(UserConnectedAccountModel data) =>
//     json.encode(data.toJson());
//
// class UserConnectedAccountModel {
//   UserConnectedAccountModel({
//     this.status,
//     this.code,
//     this.response,
//   });
//
//   final bool status;
//   final int code;
//   final List<PaymentOptionsData> response;
//
//   factory UserConnectedAccountModel.fromJson(Map<String, dynamic> json) =>
//       UserConnectedAccountModel(
//         status: json["status"] == null ? null : json["status"],
//         code: json["code"] == null ? null : json["code"],
//         response: json["response"] == null
//             ? null
//             : List<PaymentOptionsData>.from(
//                 json["response"].map((x) => PaymentOptionsData.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "status": status == null ? null : status,
//         "code": code == null ? null : code,
//         "response": response == null
//             ? null
//             : List<dynamic>.from(response.map((x) => x.toJson())),
//       };
// }
//
// class PaymentOptionsData {
//   PaymentOptionsData({
//     this.id,
//     this.userId,
//     this.account,
//     this.isActive,
//     this.updatedAt,
//     this.createdAt,
//   });
//
//   final String id;
//   final String userId;
//   final Account account;
//   final bool isActive;
//   final DateTime updatedAt;
//   final DateTime createdAt;
//
//   factory PaymentOptionsData.fromJson(Map<String, dynamic> json) =>
//       PaymentOptionsData(
//         id: json["_id"] == null ? null : json["_id"],
//         userId: json["user_id"] == null ? null : json["user_id"],
//         account:
//             json["account"] == null ? null : Account.fromJson(json["account"]),
//         isActive: json["isActive"] == null ? null : json["isActive"],
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "_id": id == null ? null : id,
//         "user_id": userId == null ? null : userId,
//         "account": account == null ? null : account.toJson(),
//         "isActive": isActive == null ? null : isActive,
//         "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
//         "created_at": createdAt == null ? null : createdAt.toIso8601String(),
//       };
// }
//
// class Account {
//   Account({
//     this.type,
//     this.stripeUserId,
//     this.emailId,
//     this.chargesEnabled,
//     this.cardPaymentsStatus,
//     this.country,
//     this.currency,
//     this.processorName,
//     this.liveMerchantId,
//     this.livePublicKey,
//     this.livePrivateKey,
//     this.apiUsername,
//     this.apiPassword,
//     this.apiSignature,
//   });
//
//   final String type;
//   final String stripeUserId;
//   final dynamic emailId;
//   final bool chargesEnabled;
//   final String cardPaymentsStatus;
//   final String country;
//   final String currency;
//   final String processorName;
//   final String liveMerchantId;
//   final String livePublicKey;
//   final String livePrivateKey;
//   final String apiUsername;
//   final String apiPassword;
//   final String apiSignature;
//
//   factory Account.fromJson(Map<String, dynamic> json) => Account(
//         type: json["type"] == null ? null : json["type"],
//         stripeUserId:
//             json["stripe_user_id"] == null ? null : json["stripe_user_id"],
//         emailId: json["email_id"],
//         chargesEnabled:
//             json["charges_enabled"] == null ? null : json["charges_enabled"],
//         cardPaymentsStatus: json["card_payments_status"] == null
//             ? null
//             : json["card_payments_status"],
//         country: json["country"] == null ? null : json["country"],
//         currency: json["currency"] == null ? null : json["currency"],
//         processorName:
//             json["processor_name"] == null ? null : json["processor_name"],
//         liveMerchantId:
//             json["live_merchant_id"] == null ? null : json["live_merchant_id"],
//         livePublicKey:
//             json["live_public_key"] == null ? null : json["live_public_key"],
//         livePrivateKey:
//             json["live_private_key"] == null ? null : json["live_private_key"],
//         apiUsername: json["api_username"] == null ? null : json["api_username"],
//         apiPassword: json["api_password"] == null ? null : json["api_password"],
//         apiSignature:
//             json["api_signature"] == null ? null : json["api_signature"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "type": type == null ? null : type,
//         "stripe_user_id": stripeUserId == null ? null : stripeUserId,
//         "email_id": emailId,
//         "charges_enabled": chargesEnabled == null ? null : chargesEnabled,
//         "card_payments_status":
//             cardPaymentsStatus == null ? null : cardPaymentsStatus,
//         "country": country == null ? null : country,
//         "currency": currency == null ? null : currency,
//         "processor_name": processorName == null ? null : processorName,
//         "live_merchant_id": liveMerchantId == null ? null : liveMerchantId,
//         "live_public_key": livePublicKey == null ? null : livePublicKey,
//         "live_private_key": livePrivateKey == null ? null : livePrivateKey,
//         "api_username": apiUsername == null ? null : apiUsername,
//         "api_password": apiPassword == null ? null : apiPassword,
//         "api_signature": apiSignature == null ? null : apiSignature,
//       };
// }
