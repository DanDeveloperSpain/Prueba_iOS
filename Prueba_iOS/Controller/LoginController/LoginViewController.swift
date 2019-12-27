//
//  LoginViewController.swift
//  Prueba_iOS
//
//  Created by Daniel Pérez Parreño on 26/12/2019.
//  Copyright © 2019 Daniel Pérez Parreño. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var loginConfigurator: LoginConfigurator!
    var websocketSessionManager = WebsocketSessionManager.shared
    
    let utils = Utils()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextField.delegate = self
        emailTextField.textContentType = .emailAddress
        emailTextField.tag = 0
        emailTextField.returnKeyType = UIReturnKeyType.next
        
        passwordTextField.delegate = self
        passwordTextField.textContentType = .password
        passwordTextField.tag = 1
        passwordTextField.returnKeyType = UIReturnKeyType.go
        
        loginConfigurator = LoginConfigurator(websocketSessionManager: websocketSessionManager)
    }
    

    @IBAction func loginButtonPressed(_ sender: UIButton) {
        sendDataLogin()
//        if isValidData(email: emailTextField.text!, password: passwordTextField.text!){
//            sendDataLogin()
//        }
    }
    
    func sendDataLogin(){
        activityIndicator.startAnimating()
        loginButton.isEnabled = false
        loginConfigurator.sendAutenticate(email: emailTextField.text!, password: passwordTextField.text!, completionHandler: {result in
            
            self.activityIndicator.stopAnimating()
            self.loginButton.isEnabled = false
            if result {
                self.performSegue(withIdentifier: "enterAppSegue", sender: self)
            } else {
                self.utils.showSimpleAlertAccept(viewController: self, alertTitle: NSLocalizedString("Failed_to_login", comment: ""), alertMessage: "", acceptButtonText: NSLocalizedString("Accept", comment: ""))
            }
        })
    }
    
    
    func isValidData(email: String, password: String) -> Bool {
        let validateEmail = loginConfigurator.isValidEmail(email: email)
        var isValidateData = false
        
        var alertTitle = String()
        var alertMessage = String()
        
        if email == "" || password == "" {
            
            alertTitle = NSLocalizedString("Missing_data_to_be_filled", comment: "")
            alertMessage = NSLocalizedString("Enter_the_email_and_password", comment: "")
            
        } else if validateEmail == false{
            
            alertTitle = NSLocalizedString("Invalid_email", comment: "")
            alertMessage = NSLocalizedString("Please_check_the_email", comment: "")
            
        }  else {
            isValidateData = true
        }
        
        if !isValidateData {
            self.utils.showSimpleAlertAccept(viewController: self, alertTitle: alertTitle, alertMessage: alertMessage, acceptButtonText: NSLocalizedString("Accept", comment: ""))
        }
        
        return isValidateData
    }

}
