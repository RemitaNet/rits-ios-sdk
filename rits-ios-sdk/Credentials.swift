//
//  Credentials.swift
//  rits-ios-sdk
//
//  Created by Diagboya Iyare on 05/10/2020.
//  Copyright © 2020 Systemspecs Nig. Ltd. All rights reserved.
//

import Foundation

struct Credentials:Codable {
    var environment = ""
    var apiKey  = ""
    var apiToken  = ""
    var merchantId  = ""
    var secretKey  = ""
    var secretKeyIv = ""
    var requestId = ""
    init() {
    }
}
