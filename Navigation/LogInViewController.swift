//
//  LogInViewController.swift
//  Navigation
//
//  Created by Миша Козырь on 01.02.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import Foundation
import FirebaseAuth

protocol LoginViewControllerDelegate {
    func currentUser()
    func createUser(email: String, password: String) -> Bool
}

final class LogInViewController: UIViewController {
    
    var delegate: LoginChecker?
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private let wrapperView = UIView()
    
    private let loginView = UIView()
    
    private let passwordView = UIView()
    
    private let middleView = UIView()
    
    private let commonView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.backgroundColor = .systemGray6
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }()
    
    private let loginText: UITextField = {
    let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.textColor = .black
        field.placeholder = "Email or phone"
        field.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        field.autocapitalizationType = .none
        field.tintColor = UIColor.init(named: "accentColor")
        return field
    }()
    
    private let passwordText: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.textColor = .black
        field.placeholder = "Password"
        field.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        field.autocapitalizationType = .none
        field.tintColor = UIColor.init(named: "accentColor")
        field.isSecureTextEntry = true
        return field
        }()
    
    private let imageLogo: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "logo")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var likeButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel"), for: .normal)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.8), for: .selected)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.8), for: .highlighted)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.4), for: .disabled)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(liked), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    private lazy var bruteForceButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Подобрать пароль", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(forceButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = .red
        
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    func handle (error: LoginErrors) {
        switch error {
        case .invalidUserData:
            alertInvalidData()
        case .serverDowntime:
            print("Server doesnt answer, please try later")
        default:
            break
        }
    }
    
    let user: User? = nil
    
    func handleWithResult(completion: (Result<User, LoginErrors>) -> Void) {
        if let checkUser = user {
            completion(.success(checkUser))
        } else {
            completion(.failure(LoginErrors.serverDowntime))
        }
    }
    
    
    func alertInvalidData() {
        let alertController = UIAlertController(title: "Пользователь не найден", message: "Неверный логин или пароль", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Отмена", style: .default) { _ in
            print("Отмена")
        }
        let deleteAction = UIAlertAction(title: "Ок", style: .default) { _ in
            print("Удалить")
        }
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        setupLogInView()
        view.backgroundColor = .white
        likeButton.isEnabled = false
        [loginText, passwordText].forEach({ $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged) })
        
        if delegate?.currentUser() != nil {
            let profile = ProfileViewController()
            navigationController?.pushViewController(profile, animated: true)
        }
    }
    
    @objc func editingChanged() {
        guard let email = loginText.text, !email.isEmpty,
              let password = passwordText.text, !password.isEmpty else {
                return
              }
        likeButton.isEnabled = true
    }
    
    @objc private func liked() {
        
        guard let email = loginText.text, !email.isEmpty,
              let password = passwordText.text, !password.isEmpty else {
            print("Missing field data")
            return
        }
        if let del = self.delegate {
            if del.createUser(email: email, password: password) == true {
                print("OKKK")
                let profile = ProfileViewController()
                self.navigationController?.pushViewController(profile, animated: true) }
            else {
                print("NOT FOUND")
                showCreateAccount(email: email, password: password)
            }
        }
    }
func showCreateAccount(email: String, password: String) {
    let alert = UIAlertController(title: "Профиль с такими данными не найден", message: "Создать новый профиль?", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Создать", style: .default, handler: {_ in
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: {[weak self] result, error in
            guard let strongSelf = self else {
                return
            }
            
            guard error == nil else {
                print("Account creation failed")
                return
            }
            
            print("U have signed in")
            let profile = ProfileViewController()
self?.navigationController?.pushViewController(profile, animated: true) 
        })
    }))
    alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: {_ in
        
    }))
    
    present(alert, animated: true)
}

var password = ""

@objc private func forceButton() {
//    let serialQueueSlow = DispatchQueue(label: "someQueue", qos: .background)
//    let bf = BruteForce()
//    passwordText.isSecureTextEntry = false
//    activityIndicator.startAnimating()
//    serialQueueSlow.async {
//        self.password = bf.bruteForce()
//        self.inputPassword()
//    }
}

func inputPassword() {
    DispatchQueue.main.async {
        self.passwordText.text = self.password
        self.activityIndicator.stopAnimating()
    }
}

private func setupScrollView() {
    
    scrollView.clipsToBounds = true
    wrapperView.translatesAutoresizingMaskIntoConstraints = false
    navigationController?.navigationBar.isHidden = true
    scrollView.delegate = self
    scrollView.contentInsetAdjustmentBehavior = .automatic
    view.addSubview(scrollView)
    scrollView.addSubview(wrapperView)
    wrapperView.addSubviews(imageLogo, commonView, likeButton, bruteForceButton)
    commonView.addSubviews(loginView, middleView, passwordView)
    loginView.addSubview(loginText)
    passwordView.addSubview(passwordText)
    scrollView.addSubview(activityIndicator)
    
    let constraints = [
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
        
        wrapperView.topAnchor.constraint(equalTo: scrollView.topAnchor),
        wrapperView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
        wrapperView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
        wrapperView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        wrapperView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        wrapperView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
        
        imageLogo.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 120),
        imageLogo.centerXAnchor.constraint(equalTo: wrapperView.centerXAnchor),
        imageLogo.widthAnchor.constraint(equalToConstant: 100),
        imageLogo.heightAnchor.constraint(equalToConstant: 100),
        
        commonView.topAnchor.constraint(equalTo: imageLogo.bottomAnchor, constant: 120),
        commonView.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 16),
        commonView.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -16),
        commonView.centerXAnchor.constraint(equalTo: wrapperView.centerXAnchor),
        commonView.heightAnchor.constraint(equalToConstant: 100),
        
        middleView.topAnchor.constraint(equalTo: commonView.topAnchor, constant: 50),
        middleView.leadingAnchor.constraint(equalTo: commonView.leadingAnchor),
        middleView.trailingAnchor.constraint(equalTo: commonView.trailingAnchor),
        middleView.heightAnchor.constraint(equalToConstant: 0.5),
        
        loginView.topAnchor.constraint(equalTo: commonView.topAnchor),
        loginView.leadingAnchor.constraint(equalTo: commonView.leadingAnchor, constant: 10),
        loginView.trailingAnchor.constraint(equalTo: commonView.trailingAnchor, constant: -10),
        loginView.heightAnchor.constraint(equalToConstant: 50),
        
        loginText.centerYAnchor.constraint(equalTo: loginView.centerYAnchor),
        loginText.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
        loginText.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
        loginText.heightAnchor.constraint(equalToConstant: 30),
        
        passwordView.topAnchor.constraint(equalTo: loginView.bottomAnchor),
        passwordView.leadingAnchor.constraint(equalTo: commonView.leadingAnchor, constant: 10),
        passwordView.trailingAnchor.constraint(equalTo: commonView.trailingAnchor, constant: -10),
        passwordView.heightAnchor.constraint(equalToConstant: 50),
        
        passwordText.centerYAnchor.constraint(equalTo: passwordView.centerYAnchor),
        passwordText.leadingAnchor.constraint(equalTo: passwordView.leadingAnchor),
        passwordText.trailingAnchor.constraint(equalTo: passwordView.trailingAnchor),
        passwordText.heightAnchor.constraint(equalToConstant: 30),
        
        likeButton.topAnchor.constraint(equalTo: commonView.bottomAnchor, constant: 40),
        likeButton.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -20),
        likeButton.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 20),
        likeButton.heightAnchor.constraint(equalToConstant: 50),
        
        bruteForceButton.topAnchor.constraint(equalTo: likeButton.bottomAnchor, constant: 16),
        bruteForceButton.trailingAnchor.constraint(equalTo: likeButton.trailingAnchor),
        bruteForceButton.leadingAnchor.constraint(equalTo: likeButton.leadingAnchor),
        bruteForceButton.heightAnchor.constraint(equalToConstant: 50),
        
        activityIndicator.topAnchor.constraint(equalTo: bruteForceButton.bottomAnchor, constant: 16),
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ]
    
    NSLayoutConstraint.activate(constraints)
}

private func setupLogInView() {
    middleView.backgroundColor = .lightGray
    middleView.translatesAutoresizingMaskIntoConstraints = false
    loginView.translatesAutoresizingMaskIntoConstraints = false
    passwordView.translatesAutoresizingMaskIntoConstraints = false
}

/// Keyboard observers
override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
}

override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
}

// MARK: Keyboard actions
@objc fileprivate func keyboardWillShow(notification: NSNotification) {
    if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
        
        scrollView.contentInset.bottom = keyboardSize.height
        scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
    }
}

@objc fileprivate func keyboardWillHide(notification: NSNotification) {
    scrollView.contentInset.bottom = .zero
    scrollView.verticalScrollIndicatorInsets = .zero
}


}



extension UIView {
    func addSubviews(_ subviews: UIView...)  {
        subviews.forEach{addSubview($0)}
    }
}

extension LogInViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("content offset: \(scrollView.contentOffset.y)")
    }
}

extension UIImage {
    func alpha(_ value:CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}

class User {
    var name: String?
    
    init(name: String) {
        self.name = name
    }
}
