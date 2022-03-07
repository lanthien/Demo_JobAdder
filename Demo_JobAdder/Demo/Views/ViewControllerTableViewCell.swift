//
//  ViewControllerTableViewCell.swift
//  Demo
//
//  Created by Lan Thien on 07/03/2022.
//

import UIKit

class ViewControllerTableViewCell: UITableViewCell {
    @IBOutlet private weak var lblName: UILabel!
    @IBOutlet private weak var lblAccessibility: UILabel!
    @IBOutlet private weak var lblParticipants: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setModel(activity: ActivityModel) {
        self.lblName.text = activity.activity
        self.lblParticipants.text = "Participants: \(activity.participants)"
        self.lblAccessibility.text = "Accessibility: \(activity.accessibility)"
    }
}
