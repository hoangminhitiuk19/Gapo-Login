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
    //------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        settings()
        self.hideKeyboardWhenTappedAround()
    }
    //------------------------------------------
    @IBAction func didTapLoginButton() {
        login(email: UserDefaults.standard.string(forKey: "email")!,
              password: UserDefaults.standard.string(forKey: "generatedPassword") ?? "")
    }
    //------------------------------------------
    func requestCheckEmail() {
        let parameters: [String:Any] = [
            "email": UserDefaults.standard.string(forKey: "email")!
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
            if response.value?.code == 200 {
                semaphore.wait()
                codeToGenerate = response.value?.data.salt ?? "0"
                UserDefaults.standard.set(password.passwordSHA256(salt: codeToGenerate) ?? "",
                                          forKey: "generatedPassword")
                UserDefaults.standard.synchronize()
            } else {
                print("Fail to request check Email")
            }
            semaphore.signal()
        }
    }
    //------------------------------------------
    func login(email: String, password: String) {
        let parameters: [String:Any] = [
            "device_id": UIDevice.current.model,
            "device_model": "Simulator iPhone 13 Pro Max",
            "email": UserDefaults.standard.string(forKey: "email")!,
            "password": UserDefaults.standard.string(forKey: "generatedPassword")!,
            "client_id": clientID,
            "trusted_device": true
        ]
        let headers: HTTPHeaders = [
                    "Content-Type":"application/json",
                    "Accept": "application/json"
                ]
        requestCheckEmail()
        let request = AF.request("\(baseURL)/login",
                                 method: .post,
                                 parameters: parameters,
                                 encoding: JSONEncoding.default,
                                 headers: headers)
        request.responseDecodable(of: LoginResult.self) { [self] response in
            if response.value?.code == 200 {
                semaphore.wait()
                UserDefaults.standard.set(response.value?.data?.accessToken ?? "",
                                          forKey: "accessToken")
                UserDefaults.standard.set(response.value?.data?.userID ?? 0,
                                          forKey: "userID")
                loggedIn(state: true,
                         time: Date.currentTimeStamp)
                loginSuccessfully()
            } else {
                print("Fail to login")
            }
            semaphore.signal()
        }
    }
    //------------------------------------------
    func loginSuccessfully() {
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.showHomeScreen()
    }
    //------------------------------------------
    func loggedIn(state: Bool,
                  time: Int) {
        UserDefaults.standard.set(state,
                                  forKey: "isUserLoggedIn")
        UserDefaults.standard.set(time,
                                  forKey: "logInTime")
        UserDefaults.standard.synchronize()
    }
    //------------------------------------------
    func logOut() {
        UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
        UserDefaults.standard.synchronize()
    }
    //------------------------------------------
    // Go to next TextField
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        if let nextResponder = textField.superview?.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    //Password only accepts several inputs
    func textField(_ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String) -> Bool {
        if textField == passwordTextField{
            let components = string.components(separatedBy: allowedCharacters)
            let filtered = components.joined(separator: "")
            if string == filtered {
                return true
            } else {
                return false
            }
        }else{
            return true
        }
    }
    // Clear password
    func textFieldDidBeginEditing(_ textField: UITextField) {
        passwordTextField.clearsOnBeginEditing = true
    }
    //------------------------------------------
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == emailTextField {
            UserDefaults.standard.set(emailTextField.text ?? "",
                                      forKey: "email")
            UserDefaults.standard.synchronize()
        } else {
            password = passwordTextField.text ?? ""
            UserDefaults.standard.synchronize()
        }
    }
}

