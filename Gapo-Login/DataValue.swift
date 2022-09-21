//
//  DataValue.swift
//  Gapo-Login
//
//  Created by Dung on 9/14/22.
//

import Foundation

let baseURL = "https://api.gapowork.vn/auth/v3.0"
let notiURL = "https://api.gapowork.vn/notification/v1.0"


let allowedCharacters = CharacterSet(charactersIn:"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvxyz").inverted
let semaphore = DispatchSemaphore(value: 2)

public var email = ""
public var password = ""
public var codeToGenerate = ""
public var userIDValue: Int = 0
public var accessTokenValue: String = ""
public var generatedPassword: String = ""
public var workspaceIDValue = "523866125265220"
public var clientID = "6n6rwo86qmx7u8aahgrq"

//"eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImp0aSI6Ijg3NjY4MjA0LmlQaG9uZS4xNjYzMzAwOTE2In0.eyJpc3MiOiJnYXBvLnZuIiwiYXVkIjoiaW9zLmdhcG8udm4iLCJqdGkiOiI4NzY2ODIwNC5pUGhvbmUuMTY2MzMwMDkxNiIsImlhdCI6MTY2MzMwMDkxNSwibmJmIjoxNjYzMzAwOTE1LCJ1aWQiOjg3NjY4MjA0LCJ3c2lkcyI6IjUyMzg2NjEyNTI2NTIyMCIsImV4cCI6MTY2NTg5MjkxNX0.Muh0aEnXeTmdl3gqTBL42XlgTQ95fgVPEOPGB7zetWrdFb7BwdEfImhUW8SRwyODcBYuO8DDz-QYTkLQzPyAw4EjQM6Uury5Rx2s6G1Z-SqUOlH9bXnfdGHxkuF1dCO6rrH4jnBxjXF03pfj8y_3ir2Kzb3ibN7vy6YL57IdTbA"
