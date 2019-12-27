//
//  Login.swift
//  Prueba_iOS
//
//  Created by Daniel Pérez Parreño on 27/12/2019.
//  Copyright © 2019 Daniel Pérez Parreño. All rights reserved.
//

import Foundation

class LoginConfigurator {
    
    var websocketSessionManager : WebsocketApiService
    
    init(websocketSessionManager: WebsocketApiService) {
        self.websocketSessionManager = websocketSessionManager
    }
    
    
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    
    
    func sendAutenticate(email: String, password: String, completionHandler: @escaping (Bool) -> Void){
        var isAutenticate = false
        
        let parameters: [String: Any] = [
            "cmd": "LOGIN" as Any,
            "email" : "user2@test.test" as Any,
            "password" : "Test2020-" as Any
            //"email" : email as Any,
            //"password" : password as Any
        ]

        
        websocketSessionManager.socketSendMessage(parameters: parameters, completionHandler: {result in
            if let jsonResult = result["successful"] {
                if jsonResult["content"]["status"] == "logged" {
                    let token = jsonResult["content"]["token"].stringValue
                    //GUARDAR TOKEN
                    print(token)
                    isAutenticate = true
                }
            }
            completionHandler(isAutenticate)
        })
        
    }
    
    
    
}
