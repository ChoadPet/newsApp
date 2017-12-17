//
//  ArticleTableViewCell.swift
//  NewsApp
//
//  Created by Vitalii Poltavets on 12/16/17.
//  Copyright © 2017 Vitalii Poltavets. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var articleImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setArticle(for article: Articles) {
        if let image = article.image {
            let url = URL(string: image)
            if let url = url {
                let data = try? Data(contentsOf: url)
                if let data = data {
                    articleImage.image = UIImage(data: data)
                }
            }
        }
        if let title = article.title {
            titleLbl.text = title
        }
        if let desc = article.description {
            descriptionLbl.text = desc
        }
    }
    
}
