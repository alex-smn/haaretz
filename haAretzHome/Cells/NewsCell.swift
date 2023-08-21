//
//  NewsCell.swift
//  haAretzHome
//
//  Created by Alexander Livshits on 21/08/2023.
//

import Foundation
import UIKit

class NewsCell: UITableViewCell {
    @IBOutlet private weak var newsImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var authorLeadingImageConstraint: NSLayoutConstraint!
    @IBOutlet private weak var authorLeadingSuperviewConstraint: NSLayoutConstraint!
    
    func setup(with item: NewsItem) {
        newsImageView.image = item.image
        titleLabel.text = item.title
        authorLabel.text = item.author
        
        let hasNoImage = item.image == nil
        authorLeadingImageConstraint.isActive = !hasNoImage
        authorLeadingSuperviewConstraint.isActive = hasNoImage
        titleLabel.textColor = hasNoImage ? .black : .brown
    }
    
    override func prepareForReuse() {
        newsImageView.image = nil
        super.prepareForReuse()
    }
}

