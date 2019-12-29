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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let utils = Utils()
    
    var userConfigurator: UserConfigurator!
    var websocketSessionManager = WebsocketSessionManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userConfigurator = UserConfigurator(websocketApiService: websocketSessionManager)
        loadUser()
    }

    func loadUser(){
        activityIndicator.startAnimating()
        userConfigurator.getUser(completionHandler: {result in
            self.activityIndicator.stopAnimating()
            if result {
                self.userNameLabel.text = self.userConfigurator.user.userName
                self.emailLabel.text = self.userConfigurator.user.email
                self.avatarImage.kf.setImage(with: URL(string: self.userConfigurator.user.avatar))
            } else {
                self.utils.showSimpleAlertAccept(viewController: self, alertTitle: NSLocalizedString("Error_to_load", comment: ""), alertMessage: "", acceptButtonText: NSLocalizedString("Accept", comment: ""))
            }
        })
    }

}
