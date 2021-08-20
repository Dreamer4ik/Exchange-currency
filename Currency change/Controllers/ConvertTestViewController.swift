//
//  ConvertTestViewController.swift
//  Currency change
//
//  Created by Ivan Potapenko on 15.08.2021.
//

import UIKit

class ConvertTestViewController: UIViewController {
    
    var data:[String:String] = [:]
    
    lazy var postconvertView: ConvertView = {
        let view = ConvertView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled  = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(postAction)))
        return view
    }()
    
    lazy var getconvertView: ConvertView = {
        let view = ConvertView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled  = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(getAction)))
        return view
    }()
    lazy var postField:UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .right
        view.backgroundColor = .lightGray
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 8
        view.layer.sublayerTransform = CATransform3DMakeTranslation(-15, 0, 0)
        view.delegate = self
        return view
    }()
    
    lazy var getField:UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .right
        view.backgroundColor = .lightGray
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 8
        view.layer.sublayerTransform = CATransform3DMakeTranslation(-15, 0, 0)
        view.delegate = self
        return view
    }()
    
    
    lazy var labelPost:UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Отдаёте:"
        view.font = .boldSystemFont(ofSize: 18)
        return view
    }()
    
    lazy var labelGet:UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Получаете:"
        view.font = .boldSystemFont(ofSize: 18)
        return view
    }()
    
    lazy var labelText:UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Курс:"
        view.font = .boldSystemFont(ofSize: 18)
        return view
    }()
    
    lazy var labelCurrently:UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "2131"
        view.font = .boldSystemFont(ofSize: 18)
        return view
    }()
    
    lazy var viewLine:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
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
        view.addSubview(postconvertView)
        view.addSubview(getField)
        view.addSubview(postField)
        view.addSubview(getconvertView)
        view.addSubview(labelText)
        view.addSubview(labelCurrently)
        view.addSubview(labelGet)
        view.addSubview(labelPost)
        view.addSubview(viewLine)

    }
    
    func activateConstrains() {
        NSLayoutConstraint.activate([
            
            labelPost.topAnchor.constraint(equalTo: view.topAnchor, constant: 180),
            labelPost.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            postField.topAnchor.constraint(equalTo: labelPost.bottomAnchor, constant: 10),
            postField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            postField.widthAnchor.constraint(equalToConstant: 220),
            postField.heightAnchor.constraint(equalToConstant: 45),
           
            postconvertView.topAnchor.constraint(equalTo: postField.topAnchor, constant: 0),
            postconvertView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            postconvertView.widthAnchor.constraint(equalToConstant: 125),
            postconvertView.heightAnchor.constraint(equalToConstant: 45),
            
            labelGet.topAnchor.constraint(equalTo: postField.bottomAnchor, constant: 10),
            labelGet.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            getField.topAnchor.constraint(equalTo: labelGet.bottomAnchor, constant: 10),
            getField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            getField.widthAnchor.constraint(equalToConstant: 220),
            getField.heightAnchor.constraint(equalToConstant: 45),
            
            getconvertView.topAnchor.constraint(equalTo: getField.topAnchor, constant: 0),
            getconvertView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            getconvertView.widthAnchor.constraint(equalToConstant: 125),
            getconvertView.heightAnchor.constraint(equalToConstant: 45),
            
            
            labelText.topAnchor.constraint(equalTo: getField.bottomAnchor, constant: 30),
            labelText.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
    
            labelCurrently.topAnchor.constraint(equalTo: labelText.bottomAnchor, constant: 20),
            labelCurrently.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            viewLine.topAnchor.constraint(equalTo: labelCurrently.bottomAnchor, constant: 20),
            viewLine.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            viewLine.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            viewLine.heightAnchor.constraint(equalToConstant: 2),

            
            
            
            

        ])
    }
    //MARK: POST
    func updateViewsWithpostAction(_ code:String) {
        postconvertView.codeLabel.text = code
        switch code {
        case "USD":
            postconvertView.signImageView.image = UIImage(named: "dollar")
            
        case "RUB":
            postconvertView.signImageView.image = UIImage(named: "rub")
            
        case "EUR":
            postconvertView.signImageView.image = UIImage(named: "euro")
            
        case "BTC":
            postconvertView.signImageView.image = UIImage(named: "btc")
            
        case "UAH":
            postconvertView.signImageView.image = UIImage(named: "lira")
           
        default:
            break
        }
    }
    //MARK: GET
    func updateViewsWithgetAction(_ code:String) {
        getconvertView.codeLabel.text = code
        switch code {
        case "USD":
            getconvertView.signImageView.image = UIImage(named: "dollar")
            
        case "RUB":
            getconvertView.signImageView.image = UIImage(named: "rub")
            
        case "EUR":
            getconvertView.signImageView.image = UIImage(named: "euro")
            
        case "BTC":
            getconvertView.signImageView.image = UIImage(named: "btc")
            
        case "UAH":
            getconvertView.signImageView.image = UIImage(named: "lira")
           
        default:
            break
        }
    }

    @objc func postAction() {
        print("postAction")
        let vc = CCYViewController { [weak self] code in
            guard let self = self else {return}
            self.updateViewsWithpostAction(code)
        
        }
        vc.modalPresentationStyle = .automatic
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func getAction() {
        print("getAction")
        let vc = CCYViewController { [weak self] code in
            guard let self = self else {return}
            self.updateViewsWithgetAction(code)
        
        }
        vc.modalPresentationStyle = .automatic
        self.present(vc, animated: true, completion: nil)
    }
}

extension ConvertTestViewController : UITextFieldDelegate {
    
   func textFieldDidEndEditing(_ textField: UITextField) {
//        if textField == login {
//            data["login"] = textField.text
//        }
//
//        if textField == password {
//            data["password"] = textField.text
//        }
   }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

