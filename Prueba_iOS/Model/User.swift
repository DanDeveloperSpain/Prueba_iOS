//
//  User.swift
//  Prueba_iOS
//
//  Created by Daniel Pérez Parreño on 26/12/2019.
//  Copyright © 2019 Daniel Pérez Parreño. All rights reserved.
//

import Foundation

class User{
    var id: String
    var userName: String
    var email: String
    var avatar: String
    
    
    init(id: String, userName: String, email: String, avatar: String) {
        self.id = id
        self.userName = userName
        self.email = email
        self.avatar = avatar
    }
    
}
