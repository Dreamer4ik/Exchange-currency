//
//  ProfileViewController.swift
//  Currency change
//
//  Created by Ivan Potapenko on 10.08.2021.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var data:[String:String] = [:]

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //MARK: Почему меняется по нажатию ??? c Profile на Sign in
        tabBarItem.title = "Profile"
        title = "Sign in"
        
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
        
        //MARK: делает серой и неактивной, но обратно в enabled не возвращается,дату пишет
//        if emailField.text == "" && passwordField.text == "" {
//            signInButton.isEnabled = false
//            signInButton.alpha = 0.2
//        }
//        else {
//            signInButton.isEnabled = true
//            signInButton.alpha = 1
//        }
    }
    
    func configureTextFields() {
        emailField.delegate = self
        passwordField.delegate = self
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
    
