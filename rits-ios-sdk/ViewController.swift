//
//  ViewController.swift
//  rits-ios-sdk
//
//  Created by Diagboya Iyare on 05/10/2020.
//  Copyright © 2020 Systemspecs Nig. Ltd. All rights reserved.
//

import UIKit
import IDZSwiftCommonCrypto

class ViewController: UIViewController {

    var credentials = Credentials()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        credentials.merchantId = "DEMOMDA1234"
        credentials.apiKey = "REVNT01EQTEyMzR8REVNT01EQQ=="
        credentials.apiToken = "bmR1ZFFFWEx5R2c2NmhnMEk5a25WenJaZWZwbHFFYldKOGY0bHlGZnBZQ1N5WEpXU2Y1dGt3PT0="
        credentials.secretKey = "nbzjfdiehurgsxct"
        credentials.secretKeyIv = "sngtmqpfurxdbkwj"
        
    }

    @IBAction func activeBanks(_ sender: Any)
    {
        print("Active Banks")
        
        let url: String = Constants.DEMO.rawValue + Constants.ACTIVE_BANKS.rawValue
        
        // get the current date and time
        let currentDateTime = Date()
        let userCalendar = Calendar.current
        let requestedComponents: Set<Calendar.Component> = [
            .year,
            .month,
            .day,
            .hour,
            .minute,
            .second
        ]
        let dateTimeComponents = userCalendar.dateComponents(requestedComponents, from: currentDateTime)
       let year = dateTimeComponents.year
       let month = dateTimeComponents.month
       let day = dateTimeComponents.day
       let hour = dateTimeComponents.hour
       let minute = dateTimeComponents.minute
       let second = dateTimeComponents.second
        
       let timeStamp = String(describing: "\(year!)-\(month!)-\(day!)T\(hour!):\(minute!):\(second!)+000000")
       // print("timeStamp: \(timeStamp)")
       // print("")
        credentials.requestId = UUID().uuidString.replacingOccurrences(of: "-", with: "")
        
        print("Credentials: \(credentials)")
        print("")
       
     let apiHash = credentials.apiKey + credentials.requestId + credentials.apiToken
       // print("APIHASH1: \(apiHash)")
       // print("")

       let sha512 : Digest = Digest(algorithm: .sha512)
       let digests2 =  (sha512.update(string: apiHash)?.final())!
       let newApiHash = Utilities().hexString(fromArray: digests2.self, uppercase: false)
       // print("APIHASH2: \(newApiHash)")
       // print("")
       
        let headers = ["API_KEY" : credentials.apiKey, "REQUEST_ID" : credentials.requestId , "REQUEST_TS" : timeStamp, "API_DETAILS_HASH" : newApiHash]
        
        NetworkUtil().post(urlPath: url, requestObject: GetActiveBankResponse(), requestHeaders: headers, responseType: GetActiveBankResponse.self){response in
            
            print("RESPONSE: \(String(describing: response))")
            
        }
    }
    
    @IBAction func accountEnquiry(_ sender: Any) {
      print("Account Enquiry")
      
        let url: String = Constants.DEMO.rawValue + Constants.ACCOUNT_ENQUIRY.rawValue
        credentials.requestId = UUID().uuidString.replacingOccurrences(of: "-", with: "")
        print("Credentials: \(credentials)")
        print("")
        
        
        var accountEnquiryRequest = AccountEnquiryRequest()
        accountEnquiryRequest.accountNo = "4589999044"
        accountEnquiryRequest.bankCode = "044"

        let key = credentials.secretKey
        let iv = credentials.secretKeyIv
        
        let aes128 = EncryptionUtil(key: key, iv: iv)
        
        let encryptedAccountno = aes128?.encrypt(string: accountEnquiryRequest.accountNo)?.base64EncodedString()

        let encryptedBankcode = aes128?.encrypt(string: accountEnquiryRequest.bankCode)?.base64EncodedString()
        
        print("encryptedAccountno: \(String(describing: encryptedAccountno))")
        print("encryptedBankcode: \(String(describing: encryptedBankcode))")
        
        accountEnquiryRequest.accountNo = encryptedAccountno!
        accountEnquiryRequest.bankCode = encryptedBankcode!
        
        print("AccountEnquiry: \(accountEnquiryRequest)")
       
        
        //HEADERS
        // get the current date and time
        let currentDateTime = Date()
        let userCalendar = Calendar.current
        let requestedComponents: Set<Calendar.Component> = [
            .year,
            .month,
            .day,
            .hour,
            .minute,
            .second
        ]
        let dateTimeComponents = userCalendar.dateComponents(requestedComponents, from: currentDateTime)
        let year = dateTimeComponents.year
        let month = dateTimeComponents.month
        let day = dateTimeComponents.day
        let hour = dateTimeComponents.hour
        let minute = dateTimeComponents.minute
        let second = dateTimeComponents.second
        
        let timeStamp = String(describing: "\(year!)-\(month!)-\(day!)T\(hour!):\(minute!):\(second!)+000000")
        
        let apiHash = credentials.apiKey + credentials.requestId + credentials.apiToken
        let sha512 : Digest = Digest(algorithm: .sha512)
        let digests2 =  (sha512.update(string: apiHash)?.final())!
        let newApiHash = Utilities().hexString(fromArray: digests2.self, uppercase: false)
        
        let headers = ["API_KEY" : credentials.apiKey, "REQUEST_ID" : credentials.requestId, "MERCHANT_ID" : credentials.merchantId, "REQUEST_TS" : timeStamp, "API_DETAILS_HASH" : newApiHash]
        
        //NETWORK CALL
        NetworkUtil().post(urlPath: url, requestObject: accountEnquiryRequest, requestHeaders: headers, responseType: AccountEnquiryResponse.self){response in
            
            print("RESPONSE: \(String(describing: response))")
            
        }
        
    }
    
    @IBAction func singlePayment(_ sender: Any) {
        print("Single Payment")
        
        let url: String = Constants.DEMO.rawValue + Constants.SINGLE_PAYMENT.rawValue
        credentials.requestId = UUID().uuidString.replacingOccurrences(of: "-", with: "")
        print("Credentials: \(credentials)")
        print("")
        
        
        var singlePaymentRequest = SinglePaymentRequest()
        singlePaymentRequest.creditAccount = "4589999044"
        singlePaymentRequest.toBank = "044"
        singlePaymentRequest.fromBank = "058"
        singlePaymentRequest.debitAccount = "8909090989"
        singlePaymentRequest.narration = "Regular Payment"
        singlePaymentRequest.amount = "500"
        singlePaymentRequest.beneficiaryEmail = "qa@test.com"
        singlePaymentRequest.transRef =  credentials.requestId
        
        let key = credentials.secretKey
        let iv = credentials.secretKeyIv
        
        let aes128 = EncryptionUtil(key: key, iv: iv)

        let encryptedFrombank = aes128?.encrypt(string: singlePaymentRequest.fromBank)?.base64EncodedString()
        let encryptedDebitAccount = aes128?.encrypt(string: singlePaymentRequest.debitAccount)?.base64EncodedString()
        
        let encryptedTobank = aes128?.encrypt(string: singlePaymentRequest.toBank)?.base64EncodedString()
        let encryptedCreditAccount = aes128?.encrypt(string: singlePaymentRequest.creditAccount)?.base64EncodedString()

        let encryptedNarration = aes128?.encrypt(string: singlePaymentRequest.narration)?.base64EncodedString()
        let encryptedAmount = aes128?.encrypt(string: singlePaymentRequest.amount)?.base64EncodedString()
        
        let encryptedBenemail = aes128?.encrypt(string: singlePaymentRequest.beneficiaryEmail)?.base64EncodedString()
        let encryptedTransref = aes128?.encrypt(string: singlePaymentRequest.transRef)?.base64EncodedString()
       
        singlePaymentRequest.fromBank = encryptedFrombank!
        singlePaymentRequest.debitAccount = encryptedDebitAccount!
        
        singlePaymentRequest.toBank = encryptedTobank!
        singlePaymentRequest.creditAccount = encryptedCreditAccount!
        
        singlePaymentRequest.narration = encryptedNarration!
        singlePaymentRequest.amount = encryptedAmount!
        
        singlePaymentRequest.beneficiaryEmail = encryptedBenemail!
        singlePaymentRequest.transRef = encryptedTransref!
        
        //HEADERS
        // get the current date and time
        let currentDateTime = Date()
        let userCalendar = Calendar.current
        let requestedComponents: Set<Calendar.Component> = [
            .year,
            .month,
            .day,
            .hour,
            .minute,
            .second
        ]
        let dateTimeComponents = userCalendar.dateComponents(requestedComponents, from: currentDateTime)
        let year = dateTimeComponents.year
        let month = dateTimeComponents.month
        let day = dateTimeComponents.day
        let hour = dateTimeComponents.hour
        let minute = dateTimeComponents.minute
        let second = dateTimeComponents.second
        
        let timeStamp = String(describing: "\(year!)-\(month!)-\(day!)T\(hour!):\(minute!):\(second!)+000000")
        
        let apiHash = credentials.apiKey + credentials.requestId + credentials.apiToken
        let sha512 : Digest = Digest(algorithm: .sha512)
        let digests2 =  (sha512.update(string: apiHash)?.final())!
        let newApiHash = Utilities().hexString(fromArray: digests2.self, uppercase: false)
        
        let headers = ["API_KEY" : credentials.apiKey, "REQUEST_ID" : credentials.requestId, "MERCHANT_ID" : credentials.merchantId, "REQUEST_TS" : timeStamp, "API_DETAILS_HASH" : newApiHash]
        
        //NETWORK CALL
        NetworkUtil().post(urlPath: url, requestObject: singlePaymentRequest, requestHeaders: headers, responseType: SinglePaymentRequestResponse.self){response in
            
            print("RESPONSE: \(String(describing: response))")
            
        }
        
    }
    
    
    @IBAction func singlePaymentStatus(_ sender: Any) {
        print("Single Payment Status")
        
        let url: String = Constants.DEMO.rawValue + Constants.SINGLE_PAYMENT_STATUS.rawValue
        credentials.requestId = UUID().uuidString.replacingOccurrences(of: "-", with: "")
        print("Credentials: \(credentials)")
        print("")
        
        
        var singlePaymentStatusRequest = SinglePaymentStatusRequest()
        singlePaymentStatusRequest.transRef = "1601476689901"
        
        let key = credentials.secretKey
        let iv = credentials.secretKeyIv
        
        let aes128 = EncryptionUtil(key: key, iv: iv)
        
        let encryptedTransref = aes128?.encrypt(string: singlePaymentStatusRequest.transRef)?.base64EncodedString()
        singlePaymentStatusRequest.transRef = encryptedTransref!
        
        //HEADERS
        // get the current date and time
        let currentDateTime = Date()
        let userCalendar = Calendar.current
        let requestedComponents: Set<Calendar.Component> = [
            .year,
            .month,
            .day,
            .hour,
            .minute,
            .second
        ]
        let dateTimeComponents = userCalendar.dateComponents(requestedComponents, from: currentDateTime)
        let year = dateTimeComponents.year
        let month = dateTimeComponents.month
        let day = dateTimeComponents.day
        let hour = dateTimeComponents.hour
        let minute = dateTimeComponents.minute
        let second = dateTimeComponents.second
        
        let timeStamp = String(describing: "\(year!)-\(month!)-\(day!)T\(hour!):\(minute!):\(second!)+000000")
        
        let apiHash = credentials.apiKey + credentials.requestId + credentials.apiToken
        let sha512 : Digest = Digest(algorithm: .sha512)
        let digests2 =  (sha512.update(string: apiHash)?.final())!
        let newApiHash = Utilities().hexString(fromArray: digests2.self, uppercase: false)
        
        let headers = ["API_KEY" : credentials.apiKey, "REQUEST_ID" : credentials.requestId, "MERCHANT_ID" : credentials.merchantId, "REQUEST_TS" : timeStamp, "API_DETAILS_HASH" : newApiHash]
        
        //NETWORK CALL
        NetworkUtil().post(urlPath: url, requestObject: singlePaymentStatusRequest, requestHeaders: headers, responseType: SinglePaymentStatusResponse.self){response in
            
            print("RESPONSE: \(String(describing: response))")
            
        }
        
    }
    
    
    @IBAction func bulkPayment(_ sender: Any) {
        print("Bulk Payment")
        let url: String = Constants.DEMO.rawValue + Constants.BULK_PAYMENT.rawValue
        credentials.requestId = UUID().uuidString.replacingOccurrences(of: "-", with: "")
        print("Credentials: \(credentials)")
        print("")
        
        
        var bulkPaymentRequest = BulkPaymentRequest()
        
        var bulkPaymentInfo = BulkPaymentInfo()
        bulkPaymentInfo.totalAmount = "20000"
        bulkPaymentInfo.batchRef = credentials.requestId
        bulkPaymentInfo.debitAccount = "8909090989"
        bulkPaymentInfo.bankCode = "058"
        bulkPaymentInfo.narration = "RegularPayment"
        
        
        var paymentDetailsList = Array<PaymentDetails>()
        
        var paymentDetails = PaymentDetails()
        paymentDetails.amount = "8000"
        paymentDetails.benficiaryEmail = "qa@test.com"
        paymentDetails.transRef = credentials.requestId
        paymentDetails.benficiaryBankCode = "058"
        paymentDetails.benficiaryAccountNumber = "0582915208011"
        paymentDetails.narration = "Regular Payment"
        paymentDetailsList.append(paymentDetails)
        
        var paymentDetails1 = PaymentDetails()
        paymentDetails1.amount = "8000"
        paymentDetails1.benficiaryEmail = "qa@test.com"
        paymentDetails1.transRef = credentials.requestId
        paymentDetails1.benficiaryBankCode = "058"
        paymentDetails1.benficiaryAccountNumber = "0582915208012"
        paymentDetails1.narration = "Regular Payment"
        paymentDetailsList.append(paymentDetails1)

        var paymentDetails2 = PaymentDetails()
        paymentDetails2.amount = "4000"
        paymentDetails2.benficiaryEmail = "qa@test.com"
        paymentDetails2.transRef = credentials.requestId
        paymentDetails2.benficiaryBankCode = "058"
        paymentDetails2.benficiaryAccountNumber = "0582915208013"
        paymentDetails2.narration = "Regular Payment"
        paymentDetailsList.append(paymentDetails2)
        
        let key = credentials.secretKey
        let iv = credentials.secretKeyIv
        
        let aes128 = EncryptionUtil(key: key, iv: iv)
        
      bulkPaymentInfo.totalAmount = aes128?.encrypt(string: bulkPaymentInfo.totalAmount!)?.base64EncodedString()
        
      bulkPaymentInfo.batchRef = aes128?.encrypt(string: bulkPaymentInfo.batchRef!)?.base64EncodedString()
        
      bulkPaymentInfo.debitAccount = aes128?.encrypt(string: bulkPaymentInfo.debitAccount!)?.base64EncodedString()
        
      bulkPaymentInfo.bankCode = aes128?.encrypt(string: bulkPaymentInfo.bankCode!)?.base64EncodedString()
        
      bulkPaymentInfo.narration  = aes128?.encrypt(string: bulkPaymentInfo.narration!)?.base64EncodedString()
        
        var encryptedPaymentDetailList = Array<PaymentDetails>()
        var encryptedPaymentDetails: PaymentDetails?
       
        for paymentDetail in paymentDetailsList
        {
            encryptedPaymentDetails = PaymentDetails()

            encryptedPaymentDetails?.amount = aes128?.encrypt(string: paymentDetail.amount!)?.base64EncodedString()
            
            encryptedPaymentDetails?.benficiaryEmail = aes128?.encrypt(string: paymentDetail.benficiaryEmail!)?.base64EncodedString()
           
            encryptedPaymentDetails?.transRef = aes128?.encrypt(string: paymentDetail.transRef!)?.base64EncodedString()
            
            encryptedPaymentDetails?.benficiaryBankCode = aes128?.encrypt(string: paymentDetail.benficiaryBankCode!)?.base64EncodedString()
            
            encryptedPaymentDetails?.benficiaryAccountNumber = aes128?.encrypt(string: paymentDetail.benficiaryAccountNumber!)?.base64EncodedString()
            
            encryptedPaymentDetails?.narration = aes128?.encrypt(string: paymentDetail.narration!)?.base64EncodedString()
            
            encryptedPaymentDetailList.append(encryptedPaymentDetails!)
        }
        
        //HEADERS
        // get the current date and time
        let currentDateTime = Date()
        let userCalendar = Calendar.current
        let requestedComponents: Set<Calendar.Component> = [
            .year,
            .month,
            .day,
            .hour,
            .minute,
            .second
        ]
        let dateTimeComponents = userCalendar.dateComponents(requestedComponents, from: currentDateTime)
        let year = dateTimeComponents.year
        let month = dateTimeComponents.month
        let day = dateTimeComponents.day
        let hour = dateTimeComponents.hour
        let minute = dateTimeComponents.minute
        let second = dateTimeComponents.second
        
        let timeStamp = String(describing: "\(year!)-\(month!)-\(day!)T\(hour!):\(minute!):\(second!)+000000")
        
        let apiHash = credentials.apiKey + credentials.requestId + credentials.apiToken
        let sha512 : Digest = Digest(algorithm: .sha512)
        let digests2 =  (sha512.update(string: apiHash)?.final())!
        let newApiHash = Utilities().hexString(fromArray: digests2.self, uppercase: false)
        
        let headers = ["API_KEY" : credentials.apiKey, "REQUEST_ID" : credentials.requestId, "MERCHANT_ID" : credentials.merchantId, "REQUEST_TS" : timeStamp, "API_DETAILS_HASH" : newApiHash]
        
        bulkPaymentRequest.bulkPaymentInfo = bulkPaymentInfo
        bulkPaymentRequest.paymentDetails = encryptedPaymentDetailList
        
        //NETWORK CALL
        NetworkUtil().post(urlPath: url, requestObject: bulkPaymentRequest, requestHeaders: headers, responseType: BulkPaymentResponse.self){response in
            
            print("RESPONSE: \(String(describing: response))")
            
        }
    }
    
    
    @IBAction func bulkPaymentStatus(_ sender: Any)
    {
     print("Bulk Payment Status")
        
        let url: String = Constants.DEMO.rawValue + Constants.BULK_PAYMENT_STATUS.rawValue
        credentials.requestId = UUID().uuidString.replacingOccurrences(of: "-", with: "")
        print("Credentials: \(credentials)")
        print("")
        
        
        var bulkPaymentStatusRequest = BulkPaymentStatusRequest()
        bulkPaymentStatusRequest.transRef = "285755"
        bulkPaymentStatusRequest.batchRef = "PSM300000461330007612541"

        let key = credentials.secretKey
        let iv = credentials.secretKeyIv
        
        let aes128 = EncryptionUtil(key: key, iv: iv)
        
        let encryptedTransref = aes128?.encrypt(string: bulkPaymentStatusRequest.transRef)?.base64EncodedString()
        bulkPaymentStatusRequest.transRef = encryptedTransref!
        
        let encryptedBatchref = aes128?.encrypt(string: bulkPaymentStatusRequest.batchRef)?.base64EncodedString()
        bulkPaymentStatusRequest.batchRef = encryptedBatchref!
        
        //HEADERS
        // get the current date and time
        let currentDateTime = Date()
        let userCalendar = Calendar.current
        let requestedComponents: Set<Calendar.Component> = [
            .year,
            .month,
            .day,
            .hour,
            .minute,
            .second
        ]
        let dateTimeComponents = userCalendar.dateComponents(requestedComponents, from: currentDateTime)
        let year = dateTimeComponents.year
        let month = dateTimeComponents.month
        let day = dateTimeComponents.day
        let hour = dateTimeComponents.hour
        let minute = dateTimeComponents.minute
        let second = dateTimeComponents.second
        
        let timeStamp = String(describing: "\(year!)-\(month!)-\(day!)T\(hour!):\(minute!):\(second!)+000000")
        
        let apiHash = credentials.apiKey + credentials.requestId + credentials.apiToken
        let sha512 : Digest = Digest(algorithm: .sha512)
        let digests2 =  (sha512.update(string: apiHash)?.final())!
        let newApiHash = Utilities().hexString(fromArray: digests2.self, uppercase: false)
        
        let headers = ["API_KEY" : credentials.apiKey, "REQUEST_ID" : credentials.requestId, "MERCHANT_ID" : credentials.merchantId, "REQUEST_TS" : timeStamp, "API_DETAILS_HASH" : newApiHash]
        
        //NETWORK CALL
        NetworkUtil().post(urlPath: url, requestObject: bulkPaymentStatusRequest, requestHeaders: headers, responseType: BulkPaymentStatusResponse.self){response in
            
            print("RESPONSE: \(String(describing: response))")
            
        }
    }
    
}

