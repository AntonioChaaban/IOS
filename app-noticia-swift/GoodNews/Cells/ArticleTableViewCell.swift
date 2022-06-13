//
//  ArticleTableViewCell.swift
//  GoodNews
//


import Foundation
import UIKit

class ArticleTableViewCell: UITableViewCell {
    

    @IBOutlet weak var titleFavorites: UILabel!
    
    @IBOutlet weak var descriptionFavorites: UILabel!
    
    var actionBlock: (() -> Void)? = nil
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
  
    @IBAction func tapFavoriteButton(_ sender: Any) {
        actionBlock?()
    }
    @IBAction func didTapButton(_ sender: Any) {
        actionBlock?()
    }
}

