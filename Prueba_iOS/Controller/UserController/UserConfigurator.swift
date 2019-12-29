//
//  UserConfigurator.swift
//  Prueba_iOS
//
//  Created by Daniel Pérez Parreño on 27/12/2019.
//  Copyright © 2019 Daniel Pérez Parreño. All rights reserved.
//

import Foundation

class UserConfigurator {
    
    var user: User!
    
    var websocketApiService : WebsocketApiService
    
    init(websocketApiService: WebsocketApiService) {
        self.websocketApiService = websocketApiService
    }
    
    
    func getUser(completionHandler: @escaping (Bool) -> Void){
        var isUser = false
        let parameters: [String: Any] = ["cmd": "USER" as Any]
        
        websocketApiService.sendMessageToWebsocket(parameters: parameters, completionHandler: {result in
            if let jsonResult = result["successful"] {
                self.user = User(id: jsonResult["content"]["id"].stringValue,
                                 userName: jsonResult["content"]["username"].stringValue,
                                 email: jsonResult["content"]["email"].stringValue,
                                 avatar: jsonResult["content"]["avatar"].stringValue)
                isUser = true
            }
            completionHandler(isUser)
        })
    }

    
}

