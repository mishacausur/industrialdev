//
//  ProfileTableHeaderView.swift
//  Navigation
//
//  Created by Миша Козырь on 03.02.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class ProfileHeaderView: UITableViewHeaderFooterView {

    let imageProfile: UIImageView = UIImageView(image: #imageLiteral(resourceName: "6485"))
    let labelProfile = UILabel()
    let statusLabel = UITextField()
    let profileButton = UIButton()
    let resetStatus = UITextField()
    let backView: UIView = {
        let view = UIView()
        view.alpha = 0
        return view
    }()
    
    let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "clear"), for: .normal)
        button.alpha = 0
        button.tintColor = .white
        return button
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        imageProfile.isUserInteractionEnabled = true
        addSubview(labelProfile)
        labelSettings()
        addSubview(profileButton)
        buttonSettings()
        addSubview(statusLabel)
        statusSettings()
        addSubview(resetStatus)
        resetSettings()
        profileButton.roundCornersWithRadius(4, top: true, bottom: true, shadowEnabled: true)
        addSubview(backView)
        addSubview(imageProfile)
        imageSetting()
        addSubview(closeButton)
       
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)!
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageProfile.frame = CGRect(
            x: 16,
            y: safeAreaInsets.top + 16,
            width: 100,
            height: 100)
        
        let recognizerAvatar = UITapGestureRecognizer(target: self, action: #selector(avatarZoom))
        imageProfile.addGestureRecognizer(recognizerAvatar)
        
        labelProfile.frame = CGRect(
            x: (imageProfile.frame.maxX + (frame.width - imageProfile.frame.maxX))/2,
            y: safeAreaInsets.top + 27,
            width: 150,
            height: 18)
        
        profileButton.frame = CGRect(
            x: 16,
            y: imageProfile.frame.maxY + 16 + 40,
            width: frame.width - (16 * 2),
            height: 50)
        
        statusLabel.frame = CGRect(
            x: labelProfile.frame.minX,
            y: profileButton.frame.minY - statusLabel.frame.height - 34 - 50,
            width: 150,
            height: 14)
        
        resetStatus.frame = CGRect(
            x: statusLabel.frame.minX,
            y: profileButton.frame.minY - 16 - 40,
            width: frame.width - statusLabel.frame.minX - 16,
            height: 40)
    }
   
 
    private func imageSetting() {
       
        imageProfile.contentMode = .scaleAspectFill
        imageProfile.layer.cornerRadius = 100/2
        imageProfile.clipsToBounds = true
        imageProfile.layer.borderWidth = 3
        imageProfile.layer.borderColor = UIColor.white.cgColor
        
    }
    
    private func labelSettings() {
        labelProfile.text = "Illustrasha"
        labelProfile.font = UIFont.boldSystemFont(ofSize: 18)
        labelProfile.textColor = UIColor.black
    }
   
    private func buttonSettings() {
        profileButton.backgroundColor = .blue
        profileButton.setTitle("Set status", for: .normal)
        profileButton.layer.cornerRadius = 4
        profileButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
    }
    
    @objc private func buttonTapped() {
        statusLabel.text = statusText
    }
    
    private func statusSettings() {
        statusLabel.text = "Drawing the piano"
        statusLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        statusLabel.textColor = .gray
    }
    
    private func resetSettings() {
        resetStatus.backgroundColor = .white
        resetStatus.layer.borderWidth = 1
        resetStatus.layer.borderColor = UIColor.black.cgColor
        resetStatus.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        resetStatus.textColor = .black
        resetStatus.layer.cornerRadius = 12
        resetStatus.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
    }
    
    private var statusText: String? = "Write your status"
    
    @objc private func statusTextChanged(_ textField: UITextField) {
        if resetStatus.text != nil {
            statusText = resetStatus.text!}
    }
    
    override func setNeedsLayout() {
        super.setNeedsLayout()
        let recognizerAvatar = UITapGestureRecognizer(target: self, action: #selector(avatarZoom))
        imageProfile.addGestureRecognizer(recognizerAvatar)
        
        let recognizerCloseButton = UITapGestureRecognizer(target: self, action: #selector(closeButtonTapped))
        closeButton.addGestureRecognizer(recognizerCloseButton)
    }
    
    private func setupBackView(){
        backView.backgroundColor = .black
        backView.frame = CGRect(x: 0,
                           y: 0,
                           width: superview!.frame.width,
                           height: superview!.frame.height)
    }
    
    private func setupBackViewBack(){
        backView.alpha = 0
    }
    
    private func setupCloseButton(){
        closeButton.frame = CGRect(x: frame.maxX - 50,
                                   y: frame.minY + 50,
                                   width: 50,
                                   height: 50)
    }
    @objc func avatarZoom() {

        setupBackView()
        setupCloseButton()
        let avatarAnimationX = CABasicAnimation(keyPath: "position.x")
        avatarAnimationX.fromValue = 16
        avatarAnimationX.toValue = superview!.frame.width/2
        
        let avatarAnimationY = CABasicAnimation(keyPath: "position.y")
        avatarAnimationY.fromValue = safeAreaInsets.top + 16
        avatarAnimationY.toValue = superview!.frame.height/2
        
        let xScaleAnimation = CABasicAnimation(keyPath: "transform.scale.x")
        xScaleAnimation.fromValue = 1
        xScaleAnimation.toValue = superview!.frame.width/100
        
        let yScaleAnimation = CABasicAnimation(keyPath: "transform.scale.y")
        yScaleAnimation.fromValue = 1
        yScaleAnimation.toValue = superview!.frame.width/100
        
        let group = CAAnimationGroup()
        group.animations = [avatarAnimationX, avatarAnimationY, xScaleAnimation, yScaleAnimation]
        group.duration = 0.5
        group.isRemovedOnCompletion = false
        group.fillMode = .forwards
        group.autoreverses = false
        imageProfile.layer.add(group, forKey: "scale+position")
        
        let cornerRadiusAnimator = UIViewPropertyAnimator(duration: 0.5, curve: .easeOut) {
            self.imageProfile.layer.cornerRadius = 0
        }
        
        cornerRadiusAnimator.startAnimation()
        
        let animatorBackView = UIViewPropertyAnimator(duration: 0.5, curve: .linear) {
            self.backView.alpha = 0.5
        }
        
        animatorBackView.startAnimation()
        
        let animatorCloseButton = UIViewPropertyAnimator(duration: 0.3, curve: .linear) {
            self.closeButton.alpha = 1
        }
        animatorCloseButton.startAnimation(afterDelay: 0.5)
    }
    
   @objc func  closeButtonTapped() {
    let animatorBackView = UIViewPropertyAnimator(duration: 0.5, curve: .linear) {
        self.backView.alpha = 0
    }
    animatorBackView.startAnimation()
    
    let animatorCloseButton = UIViewPropertyAnimator(duration: 0.3, curve: .linear) {
        self.closeButton.alpha = 0
    }
    animatorCloseButton.startAnimation()
    
    let avatarAnimationX = CABasicAnimation(keyPath: "position.x")
    avatarAnimationX.fromValue = superview!.frame.width/2
    avatarAnimationX.toValue = superview!.frame.minX + 16 + 50
    
    let avatarAnimationY = CABasicAnimation(keyPath: "position.y")
    avatarAnimationY.fromValue = superview!.frame.height/2
    avatarAnimationY.toValue = superview!.safeAreaInsets.top + 16 + 50
    
    let xScaleAnimation = CABasicAnimation(keyPath: "transform.scale.x")
    xScaleAnimation.fromValue = (superview!.frame.width/100)
    xScaleAnimation.toValue = (superview!.frame.width/100)/(superview!.frame.width/100)
    
    let yScaleAnimation = CABasicAnimation(keyPath: "transform.scale.y")
    yScaleAnimation.fromValue = (superview!.frame.width/100)
    yScaleAnimation.toValue = (superview!.frame.width/100)/(superview!.frame.width/100)
    
    let group = CAAnimationGroup()
    group.animations = [avatarAnimationX, avatarAnimationY, xScaleAnimation, yScaleAnimation]
    group.duration = 0.5
    group.isRemovedOnCompletion = false
    group.fillMode = .forwards
    group.autoreverses = false
    imageProfile.layer.add(group, forKey: "scale+position")
    
    let cornerRadiusAnimator = UIViewPropertyAnimator(duration: 0.5, curve: .easeOut) {
        self.imageProfile.layer.cornerRadius = self.imageProfile.frame.width/2
    }
    
    cornerRadiusAnimator.startAnimation()
    
    }
    
}



