//
//  RequestResponse.swift
//  rits-ios-sdk
//
//  Created by Diagboya Iyare on 05/10/2020.
//  Copyright © 2020 Systemspecs Nig. Ltd. All rights reserved.
//

import Foundation

//GETACTIVE BANKS
struct GetActiveBankResponse:Codable {
    var status  : String?
    var data : GetActiveBank?
    init(){
    }
}

struct GetActiveBank:Codable {
    var responseId : String?
    var responseCode : String?
    var responseDescription : String?
    var banks : Array<Banks>?
  
    init(){
    }
}

public struct Banks: Codable {
    var bankAccronym : String?
    var bankCode : String?
    var bankName : String?
    var type  : String?
    init(){}
}
    
   
//ACCOUNT ENQUIRY
struct AccountEnquiryRequest:Codable {
    var accountNo = ""
    var bankCode = ""
    init(){}
 }

struct AccountEnquiryResponse:Codable {
        var status  : String?
        var data : AccountEnquiry?
        init(){}
}
 
struct AccountEnquiry:Codable {
    var accountName : String?
    var accountNo : String?
    var bankCode : String?
    var email : String?
    var phoneNumber : String?
    var responseCode : String?
    var responseDescription : String?
    init()
    {}
}
    
//SINGLE PAYMENT
struct SinglePaymentRequest:Codable {
    var fromBank = ""
    var debitAccount = ""
    var toBank = ""
    var creditAccount = ""
    var narration = ""
    var amount = ""
    var beneficiaryEmail = ""
    var transRef = ""

    init(){}
}

struct SinglePaymentRequestResponse:Codable {
    var status  : String?
    var data : SinglePayment?
    init(){}
}

struct SinglePayment:Codable {
    var authorizationId : String?
    var transRef : String?
    var transDate : String?
    var paymentDate : String?
    var responseId : String?
    var responseCode : String?
    var responseDescription : String?
    var rrr : String?
//    var data : String?
    init()
    {}
}

//SINGLE PAYMENT STATUS
struct SinglePaymentStatusRequest:Codable {
    var transRef = ""
    
    init(){}
}

struct SinglePaymentStatusResponse:Codable {
    var status  : String?
    var data : SinglePaymentStatus?
    init(){}
}

struct SinglePaymentStatus:Codable {
    var authorizationId : String?
    var creditAccount : String?
    var currencyCode : String?
    var debitAccount : String?
    var feeAmount : String?
    var narration : String?
    var paymentDate : String?
    var paymentState : String?
    var paymentStatus : String?
    var paymentStatusCode : String?
    var responseCode : String?
    var responseDescription : String?
    var settlementDate : String?
    var toBank : String?
    var transRef : String?
    init()
    {}
}


//BULK PAYMENT STATUS
struct BulkPaymentStatusRequest:Codable {
    var transRef = ""
    var batchRef = ""
    
    init(){}
}

struct BulkPaymentStatusResponse:Codable {
    var status  : String?
    var data : BulkPaymentStatus?
    init(){}
}

struct BulkPaymentStatus:Codable {
    var batchRef : String?
    var bulkRef : String?
    var bulkPaymentStatusInfo : BulkPaymentStatusInfo?
    var paymentDetails : Array<BulkPaymentDetails>?
    
    init()
    {}
}

struct BulkPaymentStatusInfo:Codable {
    var currencyCode : String?
    var debitAccountToken : String?
    var feeAmount : Float?
    var paymentState : String?
    var responseCode : String?
    var responseMessage : String?
    var statusCode : String?
    var statusMessage : String?
    var totalAmount : Float?
    init(){}
}

struct BulkPaymentDetails:Codable {
    var amount : String?
    var authorizationId : String?
    var paymentDate : String?
    var paymentReference : String?
    var paymentState : String?
    var responseCode : String?
    var responseMessage : String?
    var statusCode : String?
    var statusMessage : String?
    var transDate : String?
    var transRef : String?
    init(){}
}

// BULK PAYMENT
struct BulkPaymentRequest:Codable {
    var bulkPaymentInfo : BulkPaymentInfo?
    var paymentDetails : Array<PaymentDetails>?
    
    init()
    {}
}

struct BulkPaymentInfo:Codable {
    var bankCode : String?
    var batchRef : String?
    var debitAccount : String?
    var narration : String?
    var totalAmount : String?
    var remitaFunded : String?
    var generateRrrOnly : String?
    init(){}
}

struct PaymentDetails:Codable {
    var amount : String?
    var benficiaryAccountNumber : String?
    var benficiaryBankCode : String?
    var benficiaryEmail : String?
    var narration : String?
    var transRef : String?
    init(){}
}

struct BulkPaymentResponse:Codable {
    var data : BulkPayment?
    var status : String?
    init(){}
}


struct BulkPayment:Codable {
    var authorizationId : String?
    var paymentDate : String?
    var responseCode : String?
    var responseDescription : String?
    var responseId : String?
    var rrr : String?
    var transRef : String?
    init(){}
}
