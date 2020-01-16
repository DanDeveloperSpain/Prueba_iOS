//
//  WebsocketSessionManager.swift
//  Prueba_iOS
//
//  Created by Daniel Pérez Parreño on 27/12/2019.
//  Copyright © 2019 Daniel Pérez Parreño. All rights reserved.
//

import Foundation
import Starscream
import SwiftyJSON

protocol WebsocketApiService {
    
    func sendMessageToWebsocket(parameters: [String: Any], completionHandler: @escaping ([String: JSON]) -> Void)
    
}


final class WebsocketSessionManager : WebsocketApiService {
    private let WEBSOCKET_URL = Bundle.main.infoDictionary!["WebSocket_URL"] as! String
    private var socket: WebSocket!
    var token : String!
    
    private init(){
        websocketConnect()
    }
    
    static let shared = WebsocketSessionManager()
    
    
    private func websocketConnect() {
        socket = WebSocket(url: URL(string: WEBSOCKET_URL)!)
        socket.connect()
    }
    
    
    private func websocketSendAndReciveMessage(parameters: [String: Any], completionHandler: @escaping ([String: JSON]) -> Void){
        
        var result = [String: JSON]()
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions.prettyPrinted);
            if let string = String(data: jsonData, encoding: String.Encoding.utf8){
                socket.write(string: string)
                socket.onText = { (text: String) in
                    if let data = text.data(using: .utf8){
                        result["successful"] = JSON(data)
                    } else {
                        result["failure"] = JSON(["error" : "Couldn't create data to string"])
                    }
                    completionHandler(result)
                }
            } else {
                result["failure"] = JSON(["error" : "Couldn't create json string"])
                completionHandler(result)
            }
        } catch let error {
            result["failure"] = JSON(["error" : error])
            completionHandler(result)
        }
        
    }
    
    
    func sendMessageToWebsocket(parameters: [String: Any], completionHandler: @escaping ([String: JSON]) -> Void){
        if socket.isConnected {
            websocketSendAndReciveMessage(parameters: parameters, completionHandler: {result in completionHandler(result)})
        } else {
            socket.onConnect = {
                self.websocketSendAndReciveMessage(parameters: parameters, completionHandler: {result in completionHandler(result)})
            }
        }
    }
    
}

class DummyWebsocketSessionManager : WebsocketApiService {
    func sendMessageToWebsocket(parameters: [String : Any], completionHandler: @escaping ([String : JSON]) -> Void) {
        var result = [String: JSON]()
        
        result["successful"] = JSON(
            [
                "event" : "$2a$10$TxUWrGvhMY9Q89fl6m9EHOr1.wG1ndC4/USER",
                "content" : [
                    "id": "26",
                    "username": "user2",
                    "avatar": "https://api.cryptysecure-dev.com/media/logo-crypty-round.png.600x600_q85_upscale.png",
                    "email": "user2@test.test",
                    "notifications_enabled": true,
                    "emergency_mode_enabled": false,
                    "delete_history_after": "0",
                    "autolock_after": "0",
                    "is_blocked": false,
                    "is_validated_account": false,
                    "pin_enabled": false,
                    "pin": nil,
                    "counter_rooms": 0,
                    "counter_calls": 0,
                    "counter_contacts": 0
                ]
            ])
        
        completionHandler(result)
    }
    
}
