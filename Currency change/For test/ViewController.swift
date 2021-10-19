//
//  ViewController.swift
//  Currency change
//
//  Created by Ivan Potapenko on 22.09.2021.
//

import UIKit

class ViewController: UIViewController {
    
    private var data: [String: Any] = [:] {
        didSet {
            button.isAvailabled = buttonIsAvailable()
        }
    }
    
    private var isLogin = true {
        didSet {
            button.isAvailabled = buttonIsAvailable()
        }
    }
    
    lazy var emailView: CustomTextField = {
        let view = CustomTextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.identifier = "email"
        view.textField.keyboardType = .emailAddress
        view.textField.returnKeyType = .done
        view.textField.attributedPlaceholder = NSAttributedString(string: "Электронная почта", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray.withAlphaComponent(0.5), .font : UIFont.systemFont(ofSize: 14)])
                        
        return view
    }()
    
    lazy var passwordView: CustomTextField = {
        let view = CustomTextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.identifier = "password"
        view.textField.returnKeyType = .done
        view.textField.keyboardType = .default
        view.isSecureButtonEnabled = true
        view.textField.attributedPlaceholder = NSAttributedString(string: "Пароль", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray.withAlphaComponent(0.5), .font : UIFont.systemFont(ofSize: 14)])
                        
        return view
    }()
    
    lazy var repeatPasswordView: CustomTextField = {
        let view = CustomTextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.identifier = "repeatPassword"
        view.textField.returnKeyType = .done
        view.textField.keyboardType = .default
        view.isSecureButtonEnabled = true
        view.textField.attributedPlaceholder = NSAttributedString(string: "Повторить пароль", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray.withAlphaComponent(0.5), .font : UIFont.systemFont(ofSize: 14)])
        view.isHidden = true
        view.alpha = 0
        return view
    }()
    
    private lazy var stackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [emailView, passwordView, repeatPasswordView])
       stackView.translatesAutoresizingMaskIntoConstraints = false
       stackView.axis = .vertical
       stackView.distribution = .fill
       stackView.alignment = .fill
       stackView.spacing = 8
       return stackView
   }()
    
    lazy var button: MainButton = {
        let button = MainButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.attributedTitle = "Войти"
        button.isAvailabled = false
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)

        return button
    }()
    
    lazy var signUpLoginButton: Button = {
       let button = Button()
       button.translatesAutoresizingMaskIntoConstraints = false
       button.attributedTitle = "Зарегистрироваться"
        button.addTarget(self, action: #selector(didTapSignUpLoginButton(_:)), for: .touchUpInside)
       return button
   }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        addSubviews()
        activateConstraints()
        configureViews()
    }
    
    func configureViews() {
        emailView.delegate = self
        passwordView.delegate = self
        repeatPasswordView.delegate = self
    }

    private func setupView() {
        view.backgroundColor = .white
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapView)))
    }
    
    private func addSubviews() {
     view.addSubview(stackView)
        view.addSubview(button)
        view.addSubview(signUpLoginButton)


    }
        
    private func activateConstraints() {
        NSLayoutConstraint.activate([

            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            
            button.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 24),
            button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            
            signUpLoginButton.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 8),
            signUpLoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func buttonIsAvailable() -> Bool {
        switch isLogin {
        case true:
            guard let email = data["email"] as? String, email.isValidEmail(), let password = data["password"] as? String, password.isValidPassword() else {
                return false
            }
        case false:
            guard let email = data["email"] as? String, email.isValidEmail(), let password = data["password"] as? String, password.isValidPassword(), let repeatPassword = data["repeatPassword"] as? String, repeatPassword.isValidPassword() else {
                return false
            }
        }
        return true
    }
    
    private func updateViews(isLogin: Bool) {
            self.button.attributedTitle = isLogin ? "Зарегистрироваться" : "Войти"
            self.signUpLoginButton.attributedTitle = isLogin ? "Войти" : "Зарегистрироваться"
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if isLogin {
                UIView.animate(withDuration: 0.2) {
                    self.repeatPasswordView.isHidden = !isLogin
                } completion: { success in
                    UIView.animate(withDuration: 0.1) {
                        self.repeatPasswordView.alpha = 1
                    }
                }
            } else {
                UIView.animate(withDuration: 0.1) {
                    self.repeatPasswordView.alpha = 0
                } completion: { success in
                    UIView.animate(withDuration: 0.2) {
                        self.repeatPasswordView.isHidden = !isLogin
                    }
                }
            }
        }
            
    }
    
    //MARK: Actions
    @objc func didTapButton() {
        switch isLogin {
        case true:
            print("login")
        case false:
            registerUser()
        }
    }
    
    @objc func didTapSignUpLoginButton(_ sender: UIButton) {
        updateViews(isLogin: self.isLogin)
        isLogin.toggle()
    }

    @objc func didTapView() {
        view.endEditing(false)
    }
    
    private func registerUser() {
        guard let email = data["email"] as? String, email.isValidEmail(), let password = data["password"] as? String, password.isValidPassword(), let repeatPassword = data["repeatPassword"] as? String, repeatPassword.isValidPassword() else {return}
        guard password == repeatPassword else {
//            ProgressHUD.showError("Passwords don't match")
            return
        }
//        FirebaseManager.shared.registerUserWith(email: email, password: password) { error in
//            if let error = error {
//                ProgressHUD.showError(error.localizedDescription)
//            } else {
//                ProgressHUD.showSuccess()
//            }
//        }
    }
}

//MARK: - CustomTextFieldDelegate
extension ViewController: CustomTextFieldDelegate {
    func customTextFieldDidEndEditing(_ textField: UITextField, with identifier: String) {
        switch identifier {
        case "email":
            data[identifier] = textField.text?.lowercased()
        default:
            data[identifier] = textField.text
        }
    }
    
    func customTextFieldEditingChanged(_ textField: UITextField, with identifier: String) {
        switch identifier {
        case "email":
            data[identifier] = textField.text?.lowercased()
        default:
            data[identifier] = textField.text
        }
    }
    
    func customTextFieldDidBeginEditing(_ textField: UITextField) {
    }
}
