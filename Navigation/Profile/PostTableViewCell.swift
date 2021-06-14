//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Миша Козырь on 02.02.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    let dataModel = DataStorageModel()
    
    var completion: (() -> Void)?
   
    var post: PostModel? {
        didSet {
            autorPost.text = post?.autor
            descriptionPost.text = post?.description
            imagePost.image = UIImage.init(imageLiteralResourceName: (post?.imageName)!)
            likesPost.text = String(post!.likes)
            viewsPost.text = String(post!.views)
        }
    }
    
    private var autorPost: UILabel = {
        let string = UILabel()
        string.translatesAutoresizingMaskIntoConstraints = false
        string.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        string.numberOfLines = 2
        string.textColor = .black
        return string
    }()
    
    private var descriptionPost: UILabel = {
        let string = UILabel()
        string.translatesAutoresizingMaskIntoConstraints = false
        string.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        string.numberOfLines = 0
        string.textColor = .systemGray
        return string
    }()
    
    private var imagePost: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .black
        image.isUserInteractionEnabled = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private var likesPost: UILabel = {
        let number = UILabel()
        number.translatesAutoresizingMaskIntoConstraints = false
        number.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        number.textColor = .black
        return number
    }()
    
    private var viewsPost: UILabel = {
        let number = UILabel()
        number.translatesAutoresizingMaskIntoConstraints = false
        return number
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func favorite() {
        guard completion != nil else {
            return
        }
        completion!()
        print("okkkkkk")
    }
    
    private func setupCell(){
        contentView.addSubviews(autorPost, descriptionPost, imagePost, likesPost, viewsPost)
        let favoriteRecognizer = UITapGestureRecognizer(target: self, action: #selector(favorite))
        favoriteRecognizer.numberOfTapsRequired = 2
        imagePost.addGestureRecognizer(favoriteRecognizer)
        
        let constraints = [
            imagePost.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imagePost.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imagePost.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            imagePost.heightAnchor.constraint(equalTo: imagePost.widthAnchor),
            
            autorPost.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            autorPost.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            autorPost.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            autorPost.bottomAnchor.constraint(equalTo: imagePost.topAnchor, constant: -12),
            
            descriptionPost.topAnchor.constraint(equalTo: imagePost.bottomAnchor, constant: 16),
            descriptionPost.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionPost.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            likesPost.topAnchor.constraint(equalTo: descriptionPost.bottomAnchor, constant: 16),
            likesPost.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            likesPost.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            viewsPost.topAnchor.constraint(equalTo: likesPost.topAnchor),
            viewsPost.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
