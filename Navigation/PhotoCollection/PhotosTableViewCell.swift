//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Миша Козырь on 08.02.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    let wrapperView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Photos"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    let buttonArrow: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        button.setImage(UIImage(named: "arrow"), for: .normal)
        return button
    }()
    
    let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let imageOne: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "1")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.layer.cornerRadius = 6
        return image
    }()
    
    let imageTwo: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "14")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.layer.cornerRadius = 6
        return image
    }()
    
    let imageThree: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "16")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.layer.cornerRadius = 6
        return image
    }()
    
    let imageFour: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "4")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.layer.cornerRadius = 6
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        addSubview(wrapperView)
        wrapperView.addSubview(label)
        wrapperView.addSubview(buttonArrow)
        wrapperView.addSubview(stack)
        stack.addArrangedSubview(imageOne)
        stack.addArrangedSubview(imageTwo)
        stack.addArrangedSubview(imageThree)
        stack.addArrangedSubview(imageFour)
        
        let width: CGFloat = (frame.width - 12 * 2 - 8 * 3) / 4
        
        let constraints = [
            wrapperView.heightAnchor.constraint(equalToConstant: 100),
            
            label.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            
            buttonArrow.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            buttonArrow.centerYAnchor.constraint(equalTo: label.centerYAnchor),
            
            stack.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 12),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            
            imageOne.widthAnchor.constraint(equalToConstant: width),
            imageOne.heightAnchor.constraint(equalToConstant: width)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}



