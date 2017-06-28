//
//  NTWTagsTableViewCell.swift
//  Networkd
//
//  Created by CloudStream on 5/4/17.
//  Copyright © 2017 CloudStream LLC. All rights reserved.
//

import UIKit

class NTWTagsTableViewCell: UITableViewCell {

    @IBOutlet weak var tagsCollectionView: UICollectionView!
    @IBOutlet weak var tagsCollectionHeight: NSLayoutConstraint!
    var tags: [String]!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.tagsCollectionView.delegate = nil
        self.tagsCollectionView.dataSource = nil
    }
    
    func showTags(_ tags: [String]) {
        self.tags = tags
        self.tagsCollectionView.delegate = self
        self.tagsCollectionView.dataSource = self
        self.tagsCollectionView.reloadData()
    }
}


extension NTWTagsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tagCell", for: indexPath) as! NTWTagCollectionViewCell
        cell.tagButton.setTitle(self.tags[indexPath.row], for: .normal)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.tagsCollectionHeight.constant = collectionView.contentSize.height
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.evaluateStringWidth(textToEvaluate: self.tags[indexPath.row]), height: 35.0)
    }
    
    func evaluateStringWidth (textToEvaluate: String) -> CGFloat{
        let font = UIFont.systemFont(ofSize: 15.0)
        let attributes = [NSFontAttributeName : font]
        let sizeOfText = textToEvaluate.size(attributes: (attributes))
        return sizeOfText.width + 21
    }
}
