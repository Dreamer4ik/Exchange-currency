//
//  CustomTextField.swift
//  Currency change
//
//  Created by Ivan Potapenko on 22.09.2021.
//

import UIKit

protocol CustomTextFieldDelegate: AnyObject {
    func customTextFieldDidBeginEditing(_ textField: UITextField)
    func customTextFieldDidEndEditing(_ textField: UITextField, with identifier: String)
    func customTextFieldEditingChanged(_ textField: UITextField, with identifier: String)
}

class CustomTextField: UIView {
    
    var identifier: String?
    
    var isSecureButtonEnabled: Bool = false {
        didSet {
            textField.isSecureTextEntry = isSecureButtonEnabled
        }
    }
    
    weak var delegate: CustomTextFieldDelegate?
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor.lightGray.withAlphaComponent(0.5)
        label.textAlignment = .left
        return label
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .systemFont(ofSize: 14)
        textField.textColor = .darkGray
        textField.textAlignment = .left
        textField.delegate = self
        textField.tintColor = .red
        textField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        return textField
    }()
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.red.cgColor
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .darkGray
        return view
    }()
    
    private lazy var toolbar: UIToolbar = {
        let toolbar = UIToolbar(frame: .zero)
        toolbar.barTintColor = .white
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapDoneButton))
        doneButton.tintColor = UIColor(red: 1, green: 0, blue: 0.62, alpha: 1)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexibleSpace,doneButton], animated: true)
        toolbar.sizeToFit()
        return toolbar
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        addSubviews()
        activateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(titleLabel)
        addSubview(backgroundView)
        backgroundView.addSubview(textField)
        addSubview(separatorView)
    }
    
    private func setupView() {
        backgroundColor = .white
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: backgroundView.topAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 16),
            
            //            backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            //            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backgroundView.heightAnchor.constraint(equalToConstant: 40),
            
            textField.topAnchor.constraint(equalTo: backgroundView.topAnchor),
            textField.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor),
            
            separatorView.topAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: 1),
            separatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            
        ])
    }
    
    //MARK: - Actions
    @objc func didTapDoneButton(){
        textField.resignFirstResponder()
    }
    
    @objc func textFieldEditingChanged(_ textField: UITextField) {
        guard let identifier = self.identifier else {return}
        if identifier == "email" {
            if let text = textField.text {
                textField.text = text.lowercased()
            }
        }
        switch identifier {
        case "email":
            titleLabel.text = textField.hasText ? "Электронная почта" : ""
        case "password":
            titleLabel.text = textField.hasText ? "Пароль" : ""
        case "repeatPassword":
            titleLabel.text = textField.hasText ? "Повторить пароль" : ""

        default: break
        }
        delegate?.customTextFieldEditingChanged(textField, with: identifier)
    }
}

//MARK: - UITextFieldDelegate
extension CustomTextField: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let identifier = self.identifier else {return}
        switch identifier {
        case "email":
            if let email = textField.text, !email.isValidEmail() {
                backgroundView.layer.borderWidth = 1
            }
        case "password", "repeatPassword":
            if let password = textField.text, !password.isValidPassword() {
                backgroundView.layer.borderWidth = 1
            }
        default: break
        }
        delegate?.customTextFieldDidEndEditing(textField, with: identifier)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        backgroundView.layer.borderWidth = 0
        delegate?.customTextFieldDidBeginEditing(textField)
        guard let identifier = self.identifier else {return}
        switch identifier {
        case "email":
            print(identifier)
        case "password", "repeatPassword":
            print(identifier)
        default:
            break
        }
    }
}


