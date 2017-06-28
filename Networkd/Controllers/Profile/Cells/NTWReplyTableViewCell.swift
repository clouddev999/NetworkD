//
//  NTWReplyTableViewCell.swift
//  Networkd
//
//  Created by Mario Andres Villamizar Palacio on 5/10/17.
//  Copyright © 2017 Refundo LLC. All rights reserved.
//

import UIKit
import Reactions
import TTTAttributedLabel

protocol NTWReplyCellDelegate: class
{
    func expand(replyCell: UITableViewCell)
    func showReplyOptions(forCell cell: UITableViewCell)
    func didTapLikeButton(atReplyCell cell: UITableViewCell)
}

class NTWReplyTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var userNameButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var replyLabel: TTTAttributedLabel!
    @IBOutlet weak var likeButton: ReactionButton!

    var delegate: NTWReplyCellDelegate?
    var isExpanded: Bool = false
    
    
    // MARK: - UITableViewCell Lifecycle Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.configureReactionButton(likeButton)
        self.setStateForLikeButton(.normal)
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
    
    func setReply(with text: String) {
        self.replyLabel.linkAttributes = nil
        self.replyLabel.attributedTruncationToken = nil
        self.replyLabel.text = text
        
        let attributedString = NSAttributedString(string: "... See more", attributes:
            [NSFontAttributeName: UIFont.systemFont(ofSize: 15, weight: UIFontWeightLight), NSForegroundColorAttributeName: UIColor.lightGray, NSLinkAttributeName: URL(string: "see_more")!])
        self.replyLabel.attributedTruncationToken = attributedString
        self.replyLabel.activeLinkAttributes = [NSForegroundColorAttributeName: UIColor.black, NSUnderlineStyleAttributeName: NSNumber(value: false)]
        self.replyLabel.numberOfLines = 4
        self.replyLabel.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.replyLabel.delegate = self
    }
    
    
    @IBAction func likeButtonValueChanged(_ sender: Any) {
        if self.likeButton.isSelected {
            self.setStateForLikeButton(.selected)
        } else {
            self.setStateForLikeButton(.normal)
        }
        
        self.delegate?.didTapLikeButton(atReplyCell: self)
    }
    
    @IBAction func optionsButtonAction(_ sender: Any) {
        self.delegate?.showReplyOptions(forCell: self)
    }

}


extension NTWReplyTableViewCell: TTTAttributedLabelDelegate {
    func attributedLabel(_ label: TTTAttributedLabel!, didSelectLinkWith url: URL!) {
        self.replyLabel.linkAttributes = nil
        self.replyLabel.attributedTruncationToken = nil
        self.replyLabel.text = "It can be easy to start a small business, as there are opportunities to fit almost every budget and skill. It is often harder, however, to run a small business successfully. Running a successful smart business is a good a idea bla bla bla. Running a successful smart business is a good a idea bla bla bla."
        
        self.replyLabel.numberOfLines = 0
        self.delegate?.expand(replyCell: self)
    }
}
