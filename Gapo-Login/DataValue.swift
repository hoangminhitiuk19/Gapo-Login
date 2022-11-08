//
//  DataValue.swift
//  Gapo-Login
//
//  Created by Dung on 9/14/22.
//

import Foundation

let baseURL = "https://api.gapowork.vn/auth/v3.0"
let notiURL = "https://api.gapowork.vn/notification/v1.0"
//----------------------------------------
let allowedCharacters = CharacterSet(charactersIn:"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvxyz").inverted
let semaphore = DispatchSemaphore(value: 2)
//----------------------------------------
public var email = ""
public var password = ""
public var codeToGenerate = ""
public var userIDValue: Int = 0
public var accessTokenValue: String = ""
public var generatedPassword: String = ""
public var workspaceIDValue = "523866125265220"
public var clientID = "6n6rwo86qmx7u8aahgrq"

