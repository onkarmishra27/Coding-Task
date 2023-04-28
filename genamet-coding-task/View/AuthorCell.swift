//
//  AuthorCell.swift
//  genamet-coding-task
//
//  Created by Active Mac Lap 01 on 26/04/23.
//

import UIKit
import Kingfisher
import SDWebImage

class AuthorCell: UITableViewCell {
    
    @IBOutlet private weak var spinner: UIActivityIndicatorView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var thumbnailImageView: UIImageView!
    @IBOutlet private weak var checkMark: UIButton!
    
    @IBOutlet private weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet private weak var heightConstraint: NSLayoutConstraint!
    
    var didTapOnCheckMark: ((AuthorRow,Bool) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func onCheckMarkTap(_ sender: UIButton) {
        if !sender.isSelected {
            sender.isSelected = !sender.isSelected
        }
        guard let viewModel = viewModel else { return }
        didTapOnCheckMark?(viewModel.row,sender.isSelected)
        
    }
    var viewModel: AuthorCellModel? {
        didSet {
            initializeSubviews()
        }
    }
    
    private func initializeSubviews() {
        
        defaultAppearance()
        
        guard let viewModel = viewModel else { return }
        
        self.handleUIAppearance()
        
        if let imageUrlString = viewModel.row.downloadURL, let url = URL(string: imageUrlString) {
            
            thumbnailImageView.sd_setImage(with: url, placeholderImage: Constants.placeholderImage, options: [.refreshCached], completed: { [weak self] (image, error, cache, url) in
                
                if error == nil {
                    DispatchQueue.main.async {
                        self?.thumbnailImageView.image = image
                        self?.handleUIAppearance(true)
                    }
                }
            })
        }
        
        titleLabel.text = viewModel.row.author ?? Constants.emptyStr
        checkMark.isSelected = viewModel.isSelected
        
        layoutIfNeeded()
    }
    
    private func defaultAppearance() {
        widthConstraint.constant = self.frame.size.width - Constants.widthPadding
        heightConstraint.constant = self.frame.size.width - Constants.heightPadding
        
        thumbnailImageView.layer.cornerRadius = Constants.radius
        thumbnailImageView.clipsToBounds = true
    }
        
    private func handleUIAppearance(_ isHidden: Bool = false) {
        
        spinner.isHidden = isHidden
        
        if isHidden {
            spinner.stopAnimating()
        } else {
            spinner.startAnimating()
        }
        checkMark.isHidden = !spinner.isHidden
    }
}


private extension AuthorCell {
    enum Constants {
        static let placeholderImage = UIImage(named: "placeholder")
        static let emptyStr = ""
        static let defaultDescription = "No description available"
        static let widthPadding: CGFloat = 32
        static let heightPadding: CGFloat = 64
        static let radius: CGFloat = 8
    }
}
