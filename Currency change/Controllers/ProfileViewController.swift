//
//  ProfileViewController.swift
//  Currency change
//
//  Created by Ivan Potapenko on 10.08.2021.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var data:[String:String] = [:] {
        didSet {
            signInButton.isEnabled = isButtonAvailable()
        }
    }

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    
        override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tabBarItem.title = "Profile"
        navigationItem.title = "Sign in"
        
        configureViews()
        configureTextFields()
    }
    
    @IBAction func signInActionButton(_ sender: UIButton) {
        view.endEditing(true)
        print("Data:\n\(data)")
    }
    
   
    
    
    func configureViews(){
        emailField.layer.borderWidth = 2
        emailField.layer.borderColor = UIColor.gray.cgColor
        emailField.layer.cornerRadius = 6
        
        passwordField.layer.borderWidth = 2
        passwordField.layer.borderColor = UIColor.gray.cgColor
        passwordField.layer.cornerRadius = 6
        
        signInButton.layer.borderWidth = 2
        signInButton.layer.borderColor = UIColor.gray.cgColor
        signInButton.layer.cornerRadius = 6
        
       
            signInButton.isEnabled = false
            signInButton.alpha = 0.2
        
    }
    
    func configureTextFields() {
        emailField.delegate = self
        passwordField.delegate = self
    }
    
    private func isButtonAvailable() -> Bool {
        if let login = data["login"] as? String, !login.isEmpty, let password = data["password"] as? String, !password.isEmpty {
            signInButton.alpha = 1
            return true
        }
        
        signInButton.alpha = 0.2
        return false
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ProfileViewController : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == emailField {
            data["login"] = textField.text
        }
        
        if textField == passwordField {
            data["password"] = textField.text
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
    
