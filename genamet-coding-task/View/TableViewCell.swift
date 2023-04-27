//
//  TableViewCell.swift
//  genamet-coding-task
//
//  Created by Active Mac Lap 01 on 26/04/23.
//

import UIKit

class TableViewCell: UITableViewCell {
    

    public func configure(with title:String, with description:String, imageName:String  ){
        
        titleLabel.text = title
        descriptionLabel.text = description
        myImageView.image = UIImage(named: "LaunchScreenImage")
      
        
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var myImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

