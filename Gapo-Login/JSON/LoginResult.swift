//
//  LoginResult.swift
//  Gapo-Login
//
//  Created by Dung on 9/14/22.
//

import Foundation

//{"code":200,"message":"Đã xử lý thành công!","data":{"user_id":87668204,"access_token":"eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImp0aSI6Ijg3NjY4MjA0LmlQaG9uZS4xNjYzMTI0MDExIn0.eyJpc3MiOiJnYXBvLnZuIiwiYXVkIjoiaW9zLmdhcG8udm4iLCJqdGkiOiI4NzY2ODIwNC5pUGhvbmUuMTY2MzEyNDAxMSIsImlhdCI6MTY2MzEyNDAxMCwibmJmIjoxNjYzMTI0MDEwLCJ1aWQiOjg3NjY4MjA0LCJ3c2lkcyI6IjUyMzg2NjEyNTI2NTIyMCIsImV4cCI6MTY2NTcxNjAxMH0.TpyzihKaoewSfDMvb0A_nKJ2tstGr2Bp6pMgtRYXW-0ARmYkvu0gAsV7vVhwxywTJobt1hoHEn-5phb6f8eE8f7kLz4Nl6xcI-Usy-uFUdk1qXxw9L4C9eI_H36s4nXm3YqVfcGq7iuWYuGqfAadTOUPM63tBa-IVmY0oFEjKxY","access_token_expires_at":1665716011,"refresh_token":"87668204.iPhone.vkxqwsh8q29s2l0qdm53.6n6rwo86qmx7u8aahgrq","trusted_device":true,"password_status":0}}
struct LoginResult: Decodable {
    let code: Int
    let message: String
    let data: LoginData?
}
