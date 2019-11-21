//
//  Constants.swift
//  PatientTestApp
//
//  Created by Madhu Ailp on 19/11/19.
//  Copyright © 2019 Madhu Ailp. All rights reserved.
//

import Foundation



/// Network Error
let kErrCode                    = "errorCode"
let kErrCodeServer              = "ERR04"
let kErrMessage                 = "errorMessage"
let kErrMsgServer               = "Server error. Please try again later."
let kErrMsgNoData               = "No Data"
let kErrParseData               = "Couldn't parse data"
let kErrDictServer              = [kErrCode:kErrCodeServer, kErrMessage: kErrMsgServer]


/// HTTP Headers and Values

let kContentType                = "Content-Type"
let kContentTypeVal             = "application/json"
