//
//  Constants.swift
//  rits-ios-sdk
//
//  Created by Diagboya Iyare on 05/10/2020.
//  Copyright © 2020 Systemspecs Nig. Ltd. All rights reserved.
//

import Foundation

public enum Constants: String {

    case algorithm = "AES"
    
    case cipher = "AES/CBC/PKCS5PADDING"
    
    case ACTIVE_BANKS = "/fi/banks"
    
    case ACCOUNT_ENQUIRY = "/merc/fi/account/lookup"
    
    case SINGLE_PAYMENT = "/merc/payment/singlePayment.json"
    
    case SINGLE_PAYMENT_STATUS = "/merc/payment/status"
    
    case BULK_PAYMENT = "/merc/bulk/payment/send"
    case BULK_PAYMENT_STATUS = "/merc/bulk/payment/status"

    case DEMO = "https://remitademo.net/remita/exapp/api/v1/send/api/rpgsvc/rpg/api/v2"
}
