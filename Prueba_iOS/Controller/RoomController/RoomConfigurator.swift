//
//  RoomConfigurator.swift
//  Prueba_iOS
//
//  Created by Daniel Pérez Parreño on 27/12/2019.
//  Copyright © 2019 Daniel Pérez Parreño. All rights reserved.
//

import Foundation
import SwiftyJSON

class RoomConfigurator {
    
    var rooms: [Room]!
    
    var websocketSessionManager : WebsocketApiService
    
    init(websocketSessionManager: WebsocketApiService) {
        self.websocketSessionManager = websocketSessionManager
    }
    
    
    func getRooms(completionHandler: @escaping (Bool) -> Void){
        var isUser = false
        
        let parameters: [String: Any] = [
            "cmd": "ROOMS" as Any
        ]
        
        websocketSessionManager.socketSendMessage(parameters: parameters, completionHandler: {result in
            if let jsonResult = result["successful"] {
                self.rooms = [Room]()
                let jsonRooms = JSON(jsonResult["content"].arrayValue)
                
                for data in jsonRooms {
                    let room = Room(id: data.1["id"].stringValue,
                                    image: data.1["image"].stringValue,
                                    title: data.1["title"].stringValue,
                                    room_type: data.1["room_type"].stringValue,
                                    num_users: data.1["num_users"].intValue,
                                    new_messages: data.1["new_messages"].intValue)
                    self.rooms.append(room)
                }
                isUser = true
            }
            completionHandler(isUser)
        })
        
    }
    
}
