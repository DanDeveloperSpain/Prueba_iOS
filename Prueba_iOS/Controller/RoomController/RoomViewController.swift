//
//  RoomViewController.swift
//  Prueba_iOS
//
//  Created by Daniel Pérez Parreño on 27/12/2019.
//  Copyright © 2019 Daniel Pérez Parreño. All rights reserved.
//

import UIKit

class RoomViewController: UIViewController {
    
    var roomConfigurator: RoomConfigurator!
    var websocketSessionManager = WebsocketSessionManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
        roomConfigurator = RoomConfigurator(websocketSessionManager: websocketSessionManager)
        
        loadRooms()

    }
    
    func loadRooms(){
        
        roomConfigurator.getRooms(completionHandler: {result in
            if result {
                print(self.roomConfigurator.rooms.count)
            } else {
                
            }
            
        })
        
    }

 

}
