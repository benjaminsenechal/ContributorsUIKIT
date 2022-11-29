//
//  ContributorTableViewCell.swift
//  MaltContributors
//
//  Created by Benjamin Sénéchal on 28/10/2022.
//

import UIKit
import MaltDesignSystem
import Kingfisher

class ContributorTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "ContributorTableViewCell"
    private var designSystem: DesignSystem?
    private var viewModel:UserViewModel?
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var fullnameLabel: UILabel!
    @IBOutlet weak var contributionLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var separator: UIView!
    @IBOutlet weak var actionButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func setStyle() {
        self.backgroundColor = .clear
        
        separator.backgroundColor = designSystem?.colorToken.border
        
        containerView.layer.cornerRadius = 20.0
        containerView.layer.borderWidth = 2.0
        containerView.layer.borderColor = designSystem?.colorToken.border.cgColor
        
        roundedView.layer.cornerRadius = 30.0
        roundedView.layer.borderWidth = 2.0
        roundedView.layer.borderColor = designSystem?.colorToken.border.cgColor
        
        fullnameLabel.font = designSystem?.fontToken.description
        fullnameLabel.textColor = designSystem?.colorToken.description
        
        locationLabel.font = designSystem?.fontToken.description
        locationLabel.textColor = designSystem?.colorToken.description
        
        contributionLabel.font = designSystem?.fontToken.description
        contributionLabel.textColor = designSystem?.colorToken.description
        
        followersLabel.font = designSystem?.fontToken.description
        followersLabel.textColor = designSystem?.colorToken.description
        
        usernameLabel.font = designSystem?.fontToken.midTitle
        usernameLabel.textColor = designSystem?.colorToken.title

        actionButton.setStyle(buttonStyle: .secondary)
        actionButton.setTitle(String(localized: "contributors_list_button_title") , for: .normal)
    }
    
    func updateUI() {
        guard let viewModel = viewModel else { return }
        profileImageView.kf.setImage(with: URL(string: viewModel.avatarUrl)!)
        
        fullnameLabel.text = viewModel.name
        locationLabel.text = viewModel.location 
        contributionLabel.text = viewModel.contributions.description
        followersLabel.text = viewModel.followers.description
        usernameLabel.text = viewModel.username
    }
    
    func set(viewModel: UserViewModel, designSystem:DesignSystem) {
        self.viewModel = viewModel
        self.designSystem = designSystem
        self.setStyle()
        self.updateUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
