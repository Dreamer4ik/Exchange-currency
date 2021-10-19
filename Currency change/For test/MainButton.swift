//
//  MainButton.swift
//  Currency change
//
//  Created by Ivan Potapenko on 22.09.2021.
//

import UIKit

class MainButton: UIButton {

    var isAvailabled: Bool = true {
        didSet {
            switch isAvailabled {
            case true:
                isEnabled = true
                backgroundColor = .red
                setAttributedTitle(NSAttributedString(string: attributedTitle ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, .font : UIFont.systemFont(ofSize: 16)]), for: .normal)
            case false:
                isEnabled = false
                backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
                setAttributedTitle(NSAttributedString(string: attributedTitle ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, .font : UIFont.systemFont(ofSize: 16)]), for: .normal)
            }
        }
    }
    
    var attributedTitle: String? {
        didSet {
            setAttributedTitle(NSAttributedString(string: attributedTitle ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, .font : UIFont.systemFont(ofSize: 16)]), for: .normal)
            setAttributedTitle(NSAttributedString(string: attributedTitle ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white.withAlphaComponent(0.5), .font : UIFont.systemFont(ofSize: 16)]), for: .highlighted)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        activateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func setupView() {
        backgroundColor = .red
        layer.cornerRadius = 16
        clipsToBounds = true
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 51),
        ])
    }
}
