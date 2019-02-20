//
//  NotificationViewCell.swift
//  Bodabi
//
//  Created by jaehyeon lee on 27/01/2019.
//  Copyright © 2019 LeeHyeJin. All rights reserved.
//

import UIKit

class NotificationViewCell: UITableViewCell {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var notificationLabel: UILabel!
    @IBOutlet weak var notificationDateLabel: UILabel!
    
    // MARK: - Property

    var notification: Notification? {
        didSet {
            guard let notification = notification else {
                iconImageView.image = UIImage()
                eventDateLabel.text = ""
                notificationLabel.text = ""
                notificationDateLabel.text = ""
                return
            }
            
            backgroundColor = notification.isRead ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.9764705896, green: 0.9394879168, blue: 0.8803283655, alpha: 1)
            imageContainerView.makeRound(with: .heightRound)
            // TODO: - Image Setup for each holiday
            iconImageView.image = UIImage(named: "ic_fullStar")
            eventDateLabel.text = notification.event?.date?.toString(of: .year)
            notificationLabel.text = notification.sentence
            
            let notificationText: String
            let today: Date = Date()
            let yesterday: Date = today.addingTimeInterval(60 * 60 * 24 * -1)
            guard let date = notification.date else { return }
            
            switch Calendar.current.dateComponents([.year, .month, .day], from: date) {
            case Calendar.current.dateComponents([.year, .month, .day], from: today):
                notificationText = "오늘"
            case Calendar.current.dateComponents([.year, .month, .day], from: yesterday):
                notificationText = "어제"
            default:
                notificationText = notification.date?.toString(of: .none) ?? ""
            }
            notificationDateLabel.text = notificationText
        }
    }
    
    // MARK: - Life Cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.notification = nil
    }
}
