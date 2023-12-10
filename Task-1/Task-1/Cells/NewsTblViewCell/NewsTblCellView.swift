//
//  NewsTblCellView.swift
//  Task-1
//
//  Created by Vasu Chovatiya on 30/11/23.
//

import UIKit
import Nuke

class NewsTblCellView: UITableViewCell {
    // MARK: -  IBOutlet
    
    @IBOutlet weak var viewMainContainer: UIView!
    @IBOutlet weak var imgViewForArticle: UIImageView!
    @IBOutlet weak var lblArticleTitle: UILabel!
    @IBOutlet weak var lblArticleDescription: UILabel!
    
    // MARK: -  LifeCycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    // MARK: -  Fucntions
    private func setupUI() {
        viewMainContainer.addCornerRadius(15)
    }
    
    
    func config(info: ArticleInfo) {
        lblArticleTitle.text = info.title
        lblArticleDescription.text = info.description
        self.loadImage(from: info.imageURL, in: self.imgViewForArticle)
    }
    
    func loadImage(from url: URL?, in view: UIImageView) {
        Nuke.loadImage(with: url, into: view)
    }
    
    // MARK: -  Deinit
    deinit {
        DLog("NewsTblCellView Deinited")
    }

}
