//
//  Room.swift
//  Prueba_iOS
//
//  Created by Daniel Pérez Parreño on 26/12/2019.
//  Copyright © 2019 Daniel Pérez Parreño. All rights reserved.
//

import Foundation

class Room {
    var id: String
    var image: String
    var title: String
    var room_type: String
    var num_users: Int
    var new_messages: Int
    
    init(id: String, image: String, title: String, room_type: String, num_users: Int, new_messages: Int){
        self.id = id
        self.image = image
        self.title = title
        self.room_type = room_type
        self.num_users = num_users
        self.new_messages = new_messages
    }

}
