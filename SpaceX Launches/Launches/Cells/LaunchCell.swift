//
//  LaunchCell.swift
//  SpaceX Launches
//
//  Created by Baglan Daribayev on 3/7/21.
//

import UIKit
import SDWebImage

class LaunchCell: UITableViewCell {
    @IBOutlet weak var launchLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descrLabel: UILabel!
    @IBOutlet weak var upcomingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgView.sd_imageIndicator = SDWebImageActivityIndicator.gray
    }
    
    func update(with item: LaunchViewAdapter) {
        titleLabel.text = item.name
        descrLabel.text = item.descr
        dateLabel.text = item.date
        upcomingLabel.isHidden = !item.isUpcoming
        launchLabel.text = item.launchNumber
        imgView.sd_setImage(with: URL(string: item.imgUrl ?? "")) { [weak self] (image, error, _, _) in
            if error != nil {
                self?.imgView?.image = UIImage(named: "spacex_placeholder")
            } else {
                self?.imgView?.image = image
            }
        }
    }
    
}
