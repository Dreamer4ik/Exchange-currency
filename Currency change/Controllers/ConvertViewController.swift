//
//  ConvertViewController.swift
//  Currency change
//
//  Created by Ivan Potapenko on 15.08.2021.
//

import UIKit

class ConvertViewController: UIViewController {
    
    var dataPost:String = ""
    var dataGet:String = ""
    var multiplicationСourse:Double? = 0
    var currencies:[Currency] = []
    
    
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
        //MARK: Exception
        view.signImageView.image = UIImage(named: "uah")
        view.codeLabel.text = "UAH"
        
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
        view.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
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
        view.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
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
        view.textColor = UIColor(hue: 45/360, saturation: 100/100, brightness: 55/100, alpha: 1.0)
        view.font = .boldSystemFont(ofSize: 22)
        return view
    }()
    
    lazy var viewLine:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    
    lazy var buttonTest:UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.backgroundColor = .systemBlue
        view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        view.setAttributedTitle(NSAttributedString(string: "TEST", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white]), for: .normal)
        view.setAttributedTitle(NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white]), for: .highlighted)
        
        view.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        return view
    }()
    
    //MARK: TEST
    
    lazy var testField:UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .right
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 8
        view.layer.sublayerTransform = CATransform3DMakeTranslation(-15, 0, 0)
        view.delegate = self
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.title = "Convert"
        addSubViews()
        activateConstrains()
        fetchExchangeRates(.cash)
        configureColor()
        
        
        
    }
    

    
    func configureColor() {
        view.backgroundColor = UIColor(hue: 0.6667, saturation: 0.77, brightness: 0.43, alpha: 1.0)
        
        //MARK: почему не меняет цвет ???
        tabBarItem.badgeColor = UIColor(hue: 0.3333, saturation: 1, brightness: 0.39, alpha: 1.0)
        
        labelCurrently.textColor = UIColor(hue: 0.1083, saturation: 0.74, brightness: 0.89, alpha: 1.0)
        
        labelPost.textColor = .white
        labelGet.textColor = .white
        labelText.textColor = .white
        
        viewLine.backgroundColor = .white
    }
    //MARK: - Helper Functions
    func fetchExchangeRates(_ rate:Rate ) {
        PrivatBankAPI.shared.fetchExchangeRatesJSONWith(rate) { (result) in
            switch result {
            case .success(let currencies):
                self.currencies = currencies
                self.updateDefultLabelCurrently()
                
            case .failure(let error):
                print(error)
            }
            
            
        }
    }
    //меняет изначальный лейбл + параметры
    func updateDefultLabelCurrently() {
        let chosenCCY = self.currencies.first { $0.ccy == "USD" }
        DispatchQueue.main.async {
            self.labelCurrently.text = "1 USD - \((chosenCCY?.sale ?? "").dropChar()) UAH"
            self.multiplicationСourse = Double((chosenCCY?.sale ?? ""))
        }
    }
    //MARK: УМНОЖЕНИЕ
    @objc func editingChanged(_ sender: UITextField!) {
        switch sender {
        case postField:
            print(sender.text ?? "")
            let doubleValue = (Double(sender.text ?? "-") ?? 0.0) * (multiplicationСourse ?? 0.0)
            self.getField.text = String(doubleValue) //тут сделать умножение на курс
           
            
        case getField:
            print(sender.text ?? "")
        
        default:
            break
        }
    }
    
    
    @objc func buttonAction(sender: UIButton!) {
        view.endEditing(true)
        print("Button tapped")
        print("Post: \(dataPost)")
        print("Get: \(dataGet)")
        // print(currencies)
        print("Multiplication: \(multiplicationСourse ?? 0)")
        
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
//        view.addSubview(buttonTest)
//        view.addSubview(testField)
        
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
            
            //MARK: TEST
//            buttonTest.topAnchor.constraint(equalTo: viewLine.bottomAnchor, constant: 80),
//            buttonTest.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
//            buttonTest.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
//            buttonTest.heightAnchor.constraint(equalToConstant: 40),
//
//            testField.topAnchor.constraint(equalTo: buttonTest.bottomAnchor, constant: 80),
//            testField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
//            testField.widthAnchor.constraint(equalToConstant: 220),
//            testField.heightAnchor.constraint(equalToConstant: 45),
            
            
            
            
        ])
    }
    //MARK: POST
    func updateViewsWithpostAction(_ code:String) {
        let chosenCCY = self.currencies.first { $0.ccy == code }
        print(chosenCCY?.sale?.prefix(2) ?? "-")
        labelCurrently.text = "1 \(code) - \((chosenCCY?.sale ?? "").dropChar()) UAH"
        
        multiplicationСourse = Double((chosenCCY?.sale ?? ""))
        postconvertView.codeLabel.text = code

        switch code {
        case "USD":
            postconvertView.signImageView.image = UIImage(named: "usd")
        case "RUR":
            postconvertView.signImageView.image = UIImage(named: "rub")
            labelCurrently.text = "1 \(code == "RUR" ? String(code.dropLast()) + "B" : code) - \((chosenCCY?.sale ?? "").dropChar()) UAH"
            
            postconvertView.codeLabel.text = (code == "RUR" ? String(code.dropLast()) + "B" : code)
            
        case "EUR":
            postconvertView.signImageView.image = UIImage(named: "eur")
            
        case "BTC":
            postconvertView.signImageView.image = UIImage(named: "btc")
            labelCurrently.text = "1 \(code) - \((chosenCCY?.sale?.prefix(8) ?? "")) USD"
            
        case "UAH":
            postconvertView.signImageView.image = UIImage(named: "uah")
//            let chosenCCY = self.currencies.first { $0.ccy == "USD" }
//            labelCurrently.text = "1 USD - \((chosenCCY?.sale ?? "").dropChar()) UAH"
            
            
        default:
            break
        }
    }
    //MARK: GET
    func updateViewsWithgetAction(_ code:String) {
        let chosenCCY = self.currencies.first { $0.ccy == code }
        
        print(chosenCCY?.sale?.prefix(2) ?? "-")
        getconvertView.codeLabel.text = code
        
        switch code {
        case "USD":
            getconvertView.signImageView.image = UIImage(named: "usd")
            
        case "RUR":
            getconvertView.signImageView.image = UIImage(named: "rub")
            getconvertView.codeLabel.text = String(code.dropLast()) + "B"
            
        case "EUR":
            getconvertView.signImageView.image = UIImage(named: "eur")
            
        case "BTC":
            getconvertView.signImageView.image = UIImage(named: "btc")
            
        case "UAH":
            getconvertView.signImageView.image = UIImage(named: "uah")
            
            
            
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

// MARK: EXTENSIONS
extension ConvertViewController : UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == postField {
            dataPost = textField.text ?? ""
        }
        
        if textField == getField {
            dataGet = textField.text ?? ""
        }
                  
        }
        
       
    
    // изменение во время ввода
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == postField || textField == getField    {
            if let field = textField.text, !field.isValidField(){
                textField.backgroundColor = .red
                
            }
            else {
                textField.backgroundColor = .white
            }
            
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.keyboardType = .numbersAndPunctuation
    }
    

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

