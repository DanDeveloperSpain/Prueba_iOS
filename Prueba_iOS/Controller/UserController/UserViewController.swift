//
//  UserViewController.swift
//  Prueba_iOS
//
//  Created by Daniel Pérez Parreño on 27/12/2019.
//  Copyright © 2019 Daniel Pérez Parreño. All rights reserved.
//

import UIKit
import Kingfisher

class UserViewController: UIViewController {
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    var userConfigurator: UserConfigurator!
    var websocketSessionManager = WebsocketSessionManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userConfigurator = UserConfigurator(websocketSessionManager: websocketSessionManager)
        
        loadUser()
    }
    

    func loadUser(){
        
        userConfigurator.getUser(completionHandler: {result in
            if result {
                self.userNameLabel.text = self.userConfigurator.user.userName
                self.emailLabel.text = self.userConfigurator.user.email
                self.avatarImage.kf.setImage(with: URL(string: self.userConfigurator.user.avatar))
            } else {
                
            }
            
        })
        
    }

}
