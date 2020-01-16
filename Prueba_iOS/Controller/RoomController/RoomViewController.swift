//
//  RoomViewController.swift
//  Prueba_iOS
//
//  Created by Daniel Pérez Parreño on 27/12/2019.
//  Copyright © 2019 Daniel Pérez Parreño. All rights reserved.
//

import UIKit
import Kingfisher

class RoomViewController: UIViewController {
    
    @IBOutlet weak var roomCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let utils = Utils()
    
    var roomConfigurator: RoomConfigurator!
    var websocketSessionManager = WebsocketSessionManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        roomConfigurator = RoomConfigurator(websocketApiService: websocketSessionManager)
        loadRooms()
    }
    
    func loadRooms(){
        activityIndicator.startAnimating()
        roomConfigurator.getRooms(completionHandler: {result in
            self.activityIndicator.stopAnimating()
            if result {
                self.roomCollectionView.delegate = self
                self.roomCollectionView.dataSource = self
            } else {
                self.utils.showSimpleAlertAccept(viewController: self, alertTitle: NSLocalizedString("Error_to_load", comment: ""), alertMessage: "", acceptButtonText: NSLocalizedString("Accept", comment: ""))
            }
        })
    }

}


extension RoomViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return roomConfigurator.rooms.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width - 20, height: 125)
    }
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RoomCell", for: indexPath) as! RoomCell
        
        let room = roomConfigurator.rooms[indexPath.row]
        
        cell.imageRoom.kf.setImage(with: URL(string: room.image))
        cell.titleRoom.text = room.title
        cell.typeRoom.text = NSLocalizedString(room.room_type, comment: "")
        cell.numUsers.text =  NSLocalizedString("Users", comment: "")+": \(room.num_users)"
        cell.numNewMessages.text = NSLocalizedString("New_messages", comment: "")+": \(room.new_messages)"
        
        cell.layer.cornerRadius = 15
        cell.layer.backgroundColor = UIColor.white.cgColor
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        cell.layer.shadowRadius = 5.0
        cell.layer.shadowOpacity = 0.3
        cell.layer.masksToBounds = false
        
        return cell
    }
    
}
