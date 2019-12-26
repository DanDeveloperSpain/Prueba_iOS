//
//  Room.swift
//  Prueba_iOS
//
//  Created by Daniel Pérez Parreño on 26/12/2019.
//  Copyright © 2019 Daniel Pérez Parreño. All rights reserved.
//

import Foundation

class Room {
    var id: Int
    var title: String
    var email: String
    var image: String
    var user: [User]
    
    init(id: Int, title: String, email: String, image: String, user: [User]){
        self.id = id
        self.title = title
        self.email = email
        self.image = image
        self.user = user
    }

}
