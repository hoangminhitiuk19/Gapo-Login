//
//  MyViewController.swift
//  Gapo-Login
//
//  Created by Dung on 8/18/22.
//

import UIKit
import Alamofire
import CommonCrypto

class MyViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var alreadyHadAcount: UIButton!
    @IBOutlet weak var continueWithCode: UIButton!
    @IBOutlet weak var loginLabel: UILabel!
    //--------------------------------------------------
    let phoneImage = UIImageView()
    let lockImage = UIImageView()
    let baseURL = "https://api.gapowork.vn/auth/v3.0"
    let testURL = "https://api.gapowork.vn/auth/v3.0/log"
    public var passwordToLogin: String = "Minh02082001"
    public var passwordSHA256ToLogin: String = ""
    var test = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        settings()
    }

    func setLeftIcon(field: UITextField,
                     image: UIImageView,
                     icon: String) {
        image.image = UIImage(named: icon)
        let View = UIView()
        View.addSubview(image)
        View.frame = CGRect(x: 0,
                            y: 0,
                            width: UIImage(named: icon)!.size.width,
                            height: UIImage(named: icon)!.size.height)
        image.frame = CGRect(x: 5,
                             y: 0,
                             width: UIImage(named: icon)!.size.width,
                             height: UIImage(named: icon)!.size.height)
        field.leftView = View
        field.leftViewMode = .always
    }
    
    func setBorder(field: UIButton) {
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor(rgb: 0xDEDFE2).cgColor
    }
    
    func settings() {
        let myString = "Đã có tài khoản? Đăng nhập"
        let loginText = NSMutableAttributedString(string: "Đăng nhập")
        let attributes: [NSAttributedString.Key : Any] = [
            .font : UIFont.appNormalFont,
        ]
//        let boldAttributes: [NSAttributedString.Key : Any] = [
//            .font : UIFont.appBoldFont,
//        ]

        loginText.addAttribute(kCTForegroundColorAttributeName as NSAttributedString.Key,
                               value: setColorAtributes(color: 0x26282C),
                               range: NSRange(location: 0,
                                              length: 9))
        loginLabel.attributedText = loginText
        let attributedTitle = NSMutableAttributedString(string: myString,
                                                        attributes: attributes)
        attributedTitle.setAttributes(setColorAtributes(color: 0x30A960),
                                      range: NSRange(location:17,
                                                     length:9))
        attributedTitle.setAttributes(setColorAtributes(color: 0x26282C),
                                      range: NSRange(location: 0,
                                                     length: 17))
        
        alreadyHadAcount.setAttributedTitle(attributedTitle,
                                            for: .normal)
        setLeftIcon(field: emailTextField,
                    image: phoneImage,
                    icon: "phone-icon")
        setLeftIcon(field: passwordTextField,
                    image: lockImage,
                    icon: "lock-icon")
        setBorder(field: alreadyHadAcount)
        setBorder(field: continueWithCode)
    }
    
    func setColorAtributes(color: Int) -> [NSAttributedString.Key : Any] {
        let colorAttributes: [NSAttributedString.Key : Any] = [
            .foregroundColor : UIColor(rgb: color),
            .font : UIFont.appNormalFont
        ]
        return colorAttributes
    }
    
    @IBAction func didTapLoginButton() {
//        guard
//            let email = emailTextField.text,
//            let password = passwordTextField.text
//            else { return }
        let email = "hoangminh@gapo.com.vn"
        
        login(email: email,
              password: passwordSHA256ToLogin)
    }
    func requestCheckEmail(email: String,
                           password: String) {
        let parameters: [String:Any] = [
                    "email": email
                ]
        let headers: HTTPHeaders = [
                    "Content-Type":"application/json",
                    "Accept": "application/json"
                ]
        let request = AF.request("\(baseURL)/check-email",
                                 method: .post,
                                 parameters: parameters,
                                 encoding: JSONEncoding.default,
                                 headers: headers)
        request.responseDecodable(of: Result.self) { [self] response in
            let salt = response.value?.data.salt
            passwordSHA256ToLogin = password.passwordSHA256(salt: salt) ?? ""
        }
        print(passwordSHA256ToLogin)
    }
    func login(email: String, password: String) {
        let parameters: [String:Any] = [
            "device_id": UIDevice.current.model,
            "device_model": "Simulator iPhone 13 Pro Max",
            "email": email,
            "password": password,
            "client_id": "6n6rwo86qmx7u8aahgrq",
            "trusted_device": true
        ]
        let headers: HTTPHeaders = [
                    "Content-Type":"application/json",
                    "Accept": "application/json"
                ]
        requestCheckEmail(email: email,
                          password: passwordToLogin)
        AF.request("\(baseURL)/login",
                   method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.default,
                   headers: headers).response { response in
            debugPrint(response)
        }
        print(password)
    }
}
extension UIColor {
    convenience init(red: Int,
                     green: Int,
                     blue: Int) {
        assert(red >= 0 && red <= 255,
               "Invalid red component")
        assert(green >= 0 && green <= 255,
               "Invalid green component")
        assert(blue >= 0 && blue <= 255,
               "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0,
                  green: CGFloat(green) / 255.0,
                  blue: CGFloat(blue) / 255.0,
                  alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

extension UIFont {
    static var appFontSize: CGFloat { return 16}
    
    static var appNormalFont: UIFont {
        return UIFont(name: "SF Pro Text-Regular",
                      size: appFontSize)
                ?? UIFont.systemFont(ofSize: appFontSize)
    }
    
    static var appBoldFont: UIFont {
        return UIFont(name: "SF Pro Text-Bold",
                      size: appFontSize)
                ?? UIFont.boldSystemFont(ofSize: appFontSize)
    }
}

extension String {
    var sha256: String {
        let data = Data(self.utf8)
        let hash = data.withUnsafeBytes { (bytes: UnsafeRawBufferPointer) -> [UInt8] in
            var hash = [UInt8](repeating: 0,
                               count: Int(CC_SHA256_DIGEST_LENGTH))
            CC_SHA256(bytes.baseAddress,
                      CC_LONG(data.count), &hash)
            return hash
        }
        return hash.map { String(format: "%02x", $0) }.joined()
    }
    
    //công thức: sha256(sha256(plaintext + salt) + salt)
    public func passwordSHA256(salt: String?) -> String? {
        guard let salt = salt, !salt.isEmpty else {
            return self
        }
        let plaintext = self
        return ((plaintext + salt).sha256 + salt).sha256.lowercased()
    }
}
