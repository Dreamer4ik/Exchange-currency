//
//  Extensions.swift
//  Currency change
//
//  Created by Ivan Potapenko on 17.08.2021.
//

import Foundation

//MARK: проверка эмейла и пароля
extension String {
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    func isValidPassword() -> Bool {
//        let passwordRegEx = "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{6,}"//"(?=.*[0-9])(?=.*[a-z]).{6,}"
//        let passwordPred = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
//        return passwordPred.evaluate(with: self)
       return self.count >= 8
    }
    
    func dropChar() -> String {
        let newString = String(self.prefix(5))
        return newString
    }
}

