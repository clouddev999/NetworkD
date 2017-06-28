//
//  NTWNewsTableViewCell.swift
//  Networkd
//
//  Created by Mario Andres Villamizar Palacio on 5/9/17.
//  Copyright © 2017 Refundo LLC. All rights reserved.
//

import UIKit
import Reactions
import TTTAttributedLabel

protocol NTWNewsCellDelegate: class
{
    func expand(postCell: UITableViewCell)
    func showPostOptions(forCell cell: UITableViewCell)
    func didTapLikeButton(atPostCell cell: UITableViewCell)
    func didTapReplyButton(atPostCell cell: UITableViewCell)
}

enum ReationButtonState: Int {
    case normal = 0, selected
}

class NTWNewsTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var likeButton: ReactionButton!
    @IBOutlet weak var replyButton: ReactionButton!
    @IBOutlet weak var userNameButton: UIButton!
    @IBOutlet weak var positionCompanyLabel: UILabel!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postDescriptionLabel: TTTAttributedLabel!
    
    var delegate: NTWNewsCellDelegate?
    var isExpanded: Bool = false

    
    // MARK: - UITableViewCell Lifecycle Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.configureReactionButton(likeButton)
        self.configureReactionButton(replyButton)
        self.setStateForLikeButton(.normal)
        self.setStateForReplyButton(.normal)
    }
    
    func configureReactionButton(_ button: ReactionButton) {
        button.config       = ReactionButtonConfig() {
            $0.iconMarging      = 2
            $0.spacing          = 6
            $0.font             = UIFont.boldSystemFont(ofSize: 15)
            $0.neutralTintColor = UIColor.NTWBlue
            $0.alignment        = .left
        }
    }
    
    func setStateForLikeButton(_ state: ReationButtonState) {
        let imageName: String!
        if state == .normal {
            imageName = "ic_like_normal"
        } else {
            imageName = "ic_like_selected"
        }
        let reaction = Reaction(id: "id", title: "Like",
                                color: UIColor.NTWBlue,
                                icon: UIImage(named: imageName)!)
        self.likeButton.reaction = reaction
    }
    
    func setStateForReplyButton(_ state: ReationButtonState) {
        let imageName: String!
        if state == .normal {
            imageName = "ic_reply_normal"
        } else {
            imageName = "ic_reply_selected"
        }
        let reaction = Reaction(id: "id", title: "Reply",
                                color: UIColor.NTWBlue,
                                icon: UIImage(named: imageName)!)
        self.replyButton.reaction = reaction
    }
    
    func setPostDescription(with text: String) {
        self.postDescriptionLabel.linkAttributes = nil
        self.postDescriptionLabel.attributedTruncationToken = nil
        self.postDescriptionLabel.text = text
        
        let attributedString = NSAttributedString(string: "... See more", attributes:
            [NSFontAttributeName: UIFont.systemFont(ofSize: 15, weight: UIFontWeightLight), NSForegroundColorAttributeName: UIColor.lightGray, NSLinkAttributeName: URL(string: "see_more")!])
        self.postDescriptionLabel.attributedTruncationToken = attributedString
        self.postDescriptionLabel.activeLinkAttributes = [NSForegroundColorAttributeName: UIColor.black, NSUnderlineStyleAttributeName: NSNumber(value: false)]
        self.postDescriptionLabel.numberOfLines = 4
        self.postDescriptionLabel.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.postDescriptionLabel.delegate = self
    }

    
    @IBAction func likeButtonValueChanged(_ sender: Any) {
        if self.likeButton.isSelected {
            self.setStateForLikeButton(.selected)
        } else {
            self.setStateForLikeButton(.normal)
        }
        
        self.delegate?.didTapLikeButton(atPostCell: self)
    }
    
    @IBAction func replyButtonValueChanged(_ sender: Any) {
        /*if self.replyButton.isSelected {
            self.setStateForReplyButton(.selected)
        } else {
            self.setStateForReplyButton(.normal)
        }*/
        
        self.delegate?.didTapReplyButton(atPostCell: self)
    }
    
    @IBAction func optionsButtonAction(_ sender: Any) {
        self.delegate?.showPostOptions(forCell: self)
    }
    
}


extension NTWNewsTableViewCell: TTTAttributedLabelDelegate {
    func attributedLabel(_ label: TTTAttributedLabel!, didSelectLinkWith url: URL!) {
        self.postDescriptionLabel.linkAttributes = nil
        self.postDescriptionLabel.attributedTruncationToken = nil
        self.postDescriptionLabel.text = "It can be easy to start a small business, as there are opportunities to fit almost every budget and skill. It is often harder, however, to run a small business successfully. Running a successful smart business is a good a idea bla bla bla. Running a successful smart business is a good a idea bla bla bla."
        
        self.postDescriptionLabel.numberOfLines = 0
        self.delegate?.expand(postCell: self)
    }
}


