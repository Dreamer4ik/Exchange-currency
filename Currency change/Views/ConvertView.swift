//
//  ConvertView.swift
//  Currency change
//
//  Created by Ivan Potapenko on 14.08.2021.
//

import UIKit

class ConvertView: UIView {
    
    lazy var signImageView: UIImageView = {
       let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "usd")
        return view
    }()
    
    lazy var codeLabel: UILabel = {
       let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.backgroundColor = .clear
        view.text = "USD"
        return view
    }()
    
    lazy var arrowImageView: UIImageView = {
       let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "arrow.png")
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [signImageView, codeLabel, arrowImageView])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .fill
        view.distribution = .fillEqually
        view.axis = .horizontal
        view.spacing = 8
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        //MARK: Change color post view
        backgroundColor = UIColor(hue: 0.3333, saturation: 1, brightness: 0.39, alpha: 1.0)
        layer.cornerRadius = 8
        clipsToBounds = true
        addSubViews()
        activateConstrains()
    }
    
    required init?(coder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: coder)
        addSubViews()
        activateConstrains()
    }
    
    func addSubViews() {
        addSubview(stackView)
    }
    
    func activateConstrains() {
        signImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        arrowImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
        ])
    }
}
