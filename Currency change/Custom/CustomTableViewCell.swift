//
//  CustomTableViewCell.swift
//  Currency change
//
//  Created by Ivan Potapenko on 16.08.2021.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    static let identifier = "CustomTable1"
    
    lazy var labelCode:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .black
        label.text = "$"
        label.font = .boldSystemFont(ofSize: 26)
        return label
    }()
    
    lazy var labelName:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .black
        label.text = "- USD"
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    lazy var imageArrow:UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "arrowLeft.png")
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .lightGray
        addSubView()
        activateConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(textCode:String,textName:String) {
        labelCode.text = textCode
        labelName.text = textName
    }
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        labelCode.text = nil
//        labelName.text = nil
//    }
    
    func addSubView() {
        contentView.addSubview(labelCode)
        contentView.addSubview(labelName)
        contentView.addSubview(imageArrow)
        
    }
    
//    override func layoutSubviews() {
//        let imageSize = contentView.frame.size.height-6
//
//        labelCode.frame = CGRect(x: -10, y: 5, width: 100, height: contentView.frame.size.height - 10 )
//        labelName.frame = CGRect(x: 25, y: 5, width: 100, height: contentView.frame.size.height - 10)
//        imageArrow.frame = CGRect(x: contentView.frame.size.width - imageSize, y: 5, width: contentView.frame.size.height - 10, height: imageSize)
//    }
    
    func activateConstrains() {
        NSLayoutConstraint.activate([

            labelCode.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
            labelCode.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//                labelCode.heightAnchor.constraint(equalToConstant: 20),


            labelName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
            labelName.leadingAnchor.constraint(equalTo: labelCode.trailingAnchor, constant: 8),
//                labelName.heightAnchor.constraint(equalToConstant: 20),


            imageArrow.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
            imageArrow.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            imageArrow.heightAnchor.constraint(equalToConstant: 32),
            imageArrow.widthAnchor.constraint(equalToConstant: 32),


        ])
    }
    
}
