//
//  ConvertTestViewController.swift
//  Currency change
//
//  Created by Ivan Potapenko on 15.08.2021.
//

import UIKit

class ConvertTestViewController: UIViewController {

    
    lazy var convertView: ConvertView = {
        let view = ConvertView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled  = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(action)))
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tabBarItem.title = "Test"
        navigationItem.title = "Testing"
        addSubViews()
        activateConstrains()
        
        
    }
    
    func addSubViews() {
        view.addSubview(convertView)

    }
    
    func activateConstrains() {
        NSLayoutConstraint.activate([
           
            convertView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            convertView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            convertView.widthAnchor.constraint(equalToConstant: 120),
            convertView.heightAnchor.constraint(equalToConstant: 50)

        ])
    }

    @objc func action() {
        print("action")
        let vc = CCYViewController()
        vc.modalPresentationStyle = .automatic
        self.present(vc, animated: true, completion: nil)
    }
}

