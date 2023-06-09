//
//  ProfileViewController.swift
//  FitApp
//
//  Created by Карина Хайрулина on 28.03.2023.
//


import UIKit
import Firebase

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    let profileImageView = UIImageView()
    let nameLabel = UILabel()
    let emailTextField = UITextField()
    let nameTextField = UITextField()
    let heightTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.placeholder = "Email"
        view.addSubview(emailTextField)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.translatesAutoresizingMaskIntoConstraints = false

        nameTextField.placeholder = "Имя"
        view.addSubview(nameTextField)

        heightTextField.placeholder = "Рост"
        view.addSubview(heightTextField)

        let textFields = [emailTextField, nameTextField, heightTextField]

        textFields.forEach { textField in
            textField.backgroundColor = UIColor(named: "Background")
            textField.layer.cornerRadius = 20
            textField.layer.borderWidth = 3
            textField.layer.borderColor = UIColor(named: "Blue")?.cgColor
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.textAlignment = .left
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
            textField.leftView = paddingView
            textField.leftViewMode = .always

            view.addSubview(textField)
            
        view.backgroundColor = UIColor(named: "Background")
            
        profileImageView.image = UIImage(named: "defaultAvatar")
        profileImageView.layer.cornerRadius = 100
        profileImageView.clipsToBounds = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapProfileImage))
        profileImageView.addGestureRecognizer(tapGesture)
        profileImageView.isUserInteractionEnabled = true
        view.addSubview(profileImageView)
        }


        NSLayoutConstraint.activate([
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            profileImageView.widthAnchor.constraint(equalToConstant: 250),
            profileImageView.heightAnchor.constraint(equalToConstant: 250),
            
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 50),
            emailTextField.widthAnchor.constraint(equalToConstant: 550),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),

            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextField.widthAnchor.constraint(equalToConstant: 550),
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            nameTextField.topAnchor.constraint(equalTo:emailTextField.bottomAnchor, constant: 40),

            heightTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            heightTextField.widthAnchor.constraint(equalToConstant: 550),
            heightTextField.heightAnchor.constraint(equalToConstant: 50),
            heightTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            heightTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            heightTextField.topAnchor.constraint(equalTo:nameTextField.bottomAnchor,constant: 40),
        

        ])

        
    }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let pickedImage = info[.originalImage] as? UIImage {
                profileImageView.image = pickedImage
            }
            dismiss(animated: true, completion: nil)
        }
        
    @objc func didTapProfileImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Сделать фото", style: .default) { (_) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: nil, message: "Камера недоступга", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        let libraryAction = UIAlertAction(title: "Медиатека", style: .default) { (_) in
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Выйти", style: .cancel, handler: nil)
        
        alertController.addAction(cameraAction)
        alertController.addAction(libraryAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
  
}


