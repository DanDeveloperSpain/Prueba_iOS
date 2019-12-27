//
//  Utils.swift
//  Prueba_iOS
//
//  Created by Daniel Pérez Parreño on 26/12/2019.
//  Copyright © 2019 Daniel Pérez Parreño. All rights reserved.
//

import UIKit

class Utils {
    
    func showSimpleAlertAccept(viewController: UIViewController ,alertTitle: String, alertMessage: String, acceptButtonText: String){
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: acceptButtonText, style: UIAlertAction.Style.cancel, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    
}
