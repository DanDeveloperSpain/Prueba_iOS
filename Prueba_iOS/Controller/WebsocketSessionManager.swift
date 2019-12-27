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
    
    func socketConnect()
    
    func socketSendMessage(parameters: [String: Any], completionHandler: @escaping ([String: JSON]) -> Void)
    
}

final class WebsocketSessionManager : WebsocketApiService {
    var socket: WebSocket!
    
    var token : String
    
    let WEBSOCKET_URL = Bundle.main.infoDictionary!["WebSocket_URL"] as! String
    
    private init(){
        token = String()
        setTokenApi()
        socketConnect()
        print("INICIANDOME")
    }
    
    static let shared = WebsocketSessionManager()
    
    
    private func setTokenApi(){
        if let token = UserDefaults.standard.object(forKey: "SavedToken") as? String {
            self.token =  token
        }
    }
    
    func socketConnect() {
        socket = WebSocket(url: URL(string: WEBSOCKET_URL)!)
        socket.delegate = self
        socket.connect()
    }
    
    func socketSendMessage(parameters: [String: Any], completionHandler: @escaping ([String: JSON]) -> Void){
        
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
    
}

extension WebsocketSessionManager : WebSocketDelegate {
    func websocketDidConnect(socket: WebSocketClient) {
        print("CONECTADOO")
    }

    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print("error ", error)
    }

    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        print("111 ", text)
        //handleMessage(jsonString: text)
    }

    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print("222 ", data)
    }


}
