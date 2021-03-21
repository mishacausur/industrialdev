//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Миша Козырь on 02.02.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import SnapKit

class PostTableViewCell: UITableViewCell {

   
    var post: PostModel? {
        didSet {
            autorPost.text = post?.autor
            descriptionPost.text = post?.description
            imagePost.image = UIImage.init(imageLiteralResourceName: String((post?.imageName)!))
            likesPost.text = String(post!.likes)
            viewsPost.text = String(post!.views)
        }
    }
    
    private var autorPost: UILabel = {
        let string = UILabel()
        string.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        string.numberOfLines = 2
        string.textColor = .black
        return string
    }()
    
    private var descriptionPost: UILabel = {
        let string = UILabel()
        string.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        string.numberOfLines = 0
        string.textColor = .systemGray
        return string
    }()
    
    private var imagePost: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .black
        return image
    }()
    
    private var likesPost: UILabel = {
        let number = UILabel()
        number.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        number.textColor = .black
        return number
    }()
    
    private var viewsPost: UILabel = {
        let number = UILabel()
      
        return number
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell(){
        contentView.addSubviews(autorPost, descriptionPost, imagePost, likesPost, viewsPost)
        
        imagePost.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(contentView)
            make.trailing.equalTo(contentView)
            make.width.equalTo(contentView)
            make.height.equalTo(imagePost.snp.width)
    }
        
        autorPost.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(contentView).offset(16)
            make.leading.equalTo(contentView).offset(16)
            make.trailing.equalTo(contentView)
            make.bottom.equalTo(imagePost.snp.top).offset(-12)
        }
        
        descriptionPost.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(imagePost.snp.bottom).offset(16)
            make.leading.equalTo(contentView).offset(16)
            make.trailing.equalTo(contentView)
        }
        
        likesPost.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(descriptionPost.snp.bottom).offset(16)
            make.leading.equalTo(contentView).offset(16)
            make.bottom.equalTo(contentView).offset(-16)
        }
        
        viewsPost.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(likesPost)
            make.trailing.equalTo(contentView).offset(-16)
        }
    }
    
    
    
    
}
