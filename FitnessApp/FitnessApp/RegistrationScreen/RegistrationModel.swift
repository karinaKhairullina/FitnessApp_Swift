//
//  RegistrationModel.swift
//  FitnessApp
//
//  Created by Радмир Фазлыев on 23.03.2023.
//

class User {
    var name: String
    var surname: String
    var email: String
    var password: String
    var confirmPassword: String

    init(name: String, surname: String, email: String, password: String, confirmPassword: String) {
        self.name = name
        self.surname = surname
        self.email = email
        self.password = password
        self.confirmPassword = confirmPassword
    }

    var dictionaryRepresentation: [String: Any] {
        return [
            "name": name,
            "surname": surname,
            "email": email,
            "password": password,
            "confirmPassword": confirmPassword
        ]
    }
}
