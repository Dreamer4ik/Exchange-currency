//
//  Button.swift
//  Currency change
//
//  Created by Ivan Potapenko on 22.09.2021.
//

import UIKit

class Button: UIButton {
    
    var attributedTitle: String? {
        didSet {
            let normalAttributes: [NSAttributedString.Key: Any] = [
                  .font: UIFont.systemFont(ofSize: 14),
                .foregroundColor: UIColor.blue,
                .underlineStyle: NSUnderlineStyle.single.rawValue,
                .underlineColor: UIColor.blue]
            let highlightedAttributes: [NSAttributedString.Key: Any] = [
                  .font: UIFont.systemFont(ofSize: 14),
                .foregroundColor: UIColor.blue.withAlphaComponent(0.5),
                .underlineStyle: NSUnderlineStyle.single.rawValue,
                .underlineColor: UIColor.blue.withAlphaComponent(0.5)]
            setAttributedTitle(NSAttributedString(string: attributedTitle ?? "", attributes: normalAttributes), for: .normal)
            setAttributedTitle(NSAttributedString(string: attributedTitle ?? "", attributes: highlightedAttributes), for: .highlighted)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func setupView() {
        backgroundColor = .clear
        contentVerticalAlignment = .center
        contentHorizontalAlignment = .center
    }
}
