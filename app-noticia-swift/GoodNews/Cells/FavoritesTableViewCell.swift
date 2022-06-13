//
//  FavoritesTableViewCell.swift
//  GoodNews
//


import Foundation
import UIKit

class FavoritesTableViewCell: UITableViewCell {
    
    var actionBlock: (() -> Void)? = nil
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBAction func tapButtonRead(_ sender: Any) {
        actionBlock?()
    }
}
