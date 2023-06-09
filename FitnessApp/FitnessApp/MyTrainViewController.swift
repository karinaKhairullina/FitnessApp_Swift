//
//  MyTrainViewController.swift
//  FitnessApp
//
//  Created by Карина Хайрулина on 13.04.2023.
//

import UIKit
import WebKit

struct AllBody: Codable {
    let url: String
}

class MyTrainViewController: UIViewController {
    
    var imageViews: [UIImageView] = []
    let scrollView = UIScrollView()
    var allExercises: [AllBody] = []
    let fileNames = ["allBody", "stretching", "warm-up"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton = UIBarButtonItem(title: "Назад", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backButton
        
        scrollView.frame = view.bounds
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(scrollView)
        
        loadAllExercises()
        
        let textFieldHeight: CGFloat = 60
        let buttonHeight: CGFloat = 60
        let spacing: CGFloat = 20
        let textFieldFrame = CGRect(x: spacing, y: spacing, width: view.bounds.width - 2 * spacing, height: textFieldHeight)
        let buttonFrame = CGRect(x: spacing, y: spacing, width: view.bounds.width - 2 * spacing, height: buttonHeight)
        
        let textField = UITextField(frame: textFieldFrame)
        textField.placeholder = "Введите название тренировки"
        textField.textAlignment = .left
        textField.layer.borderWidth = 3
        textField.layer.cornerRadius = spacing
        textField.layer.borderColor = UIColor(named: "Blue")?.cgColor
        scrollView.addSubview(textField)
        
        let startButton = UIButton(type: .system)
        startButton.frame = buttonFrame
        startButton.setTitle("Старт", for: .normal)
        startButton.backgroundColor = UIColor(named: "Blue")
        startButton.layer.cornerRadius = spacing
        startButton.layer.borderWidth = 3
        startButton.layer.borderColor = UIColor(named: "Blue")?.cgColor
        startButton.setTitleColor(.black, for: .normal)
        scrollView.addSubview(startButton)
        
        startButton.translatesAutoresizingMaskIntoConstraints = false
        let bottomConstraint = startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -spacing)
        let leadingConstraint = startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: spacing)
        let trailingConstraint = startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -spacing)
        let heightConstraint = startButton.heightAnchor.constraint(equalToConstant: buttonHeight)
        NSLayoutConstraint.activate([bottomConstraint, leadingConstraint, trailingConstraint, heightConstraint])
    }
    
    private func loadAllExercises() {
        
        for fileName in fileNames {
            guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
                print("JSON file not found: \(fileName)")
                continue
            }
            
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let exercises = try decoder.decode([String: [AllBody]].self, from: data)["exercises"] ?? []
                allExercises += exercises
                print("Data loaded successfully: \(fileName)")
            } catch {
                print("Error loading data: \(error)")
            }
        }
        
        setupImageViews()
    }
    
    private func setupImageViews() {
        let screenWidth = UIScreen.main.bounds.width
        let spacing: CGFloat = 10
        let rectangleWidth = (screenWidth - spacing * 3) / 2
        var xPosition: CGFloat = spacing
        var yPosition: CGFloat = 100
        let group = DispatchGroup()
        
        for (index, exercise) in allExercises.enumerated() {
            let containerView = UIView(frame: CGRect(x: xPosition, y: yPosition, width: rectangleWidth, height: rectangleWidth))
            containerView.clipsToBounds = true
            containerView.layer.cornerRadius = 20
            containerView.layer.borderWidth = 2
            containerView.layer.borderColor = UIColor(named: "Green")?.cgColor
            scrollView.addSubview(containerView)
            let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: rectangleWidth, height: rectangleWidth))
            webView.contentMode = .scaleAspectFit
            containerView.addSubview(webView)
            
            let plusButton = UIButton(type: .system)
            plusButton.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
            plusButton.tintColor = .black
            plusButton.frame = CGRect(x: rectangleWidth - 35, y: rectangleWidth - 35, width: 35, height: 35)
            containerView.addSubview(plusButton)
            
            if let url = URL(string: exercise.url) {
                let request = URLRequest(url: url)
                group.enter()
                webView.load(request)
            } else {
                print("Invalid URL: \(exercise.url)")
            }
            
            if index % 2 == 0 {
                xPosition += rectangleWidth + spacing
            } else {
                yPosition += rectangleWidth + spacing
                xPosition = spacing
            }
        }
        
        group.notify(queue: .main) {
            print("All gifs have finished loading")
        }
        
        scrollView.contentSize = CGSize(width: screenWidth, height: yPosition + rectangleWidth - spacing - 50)
    }
}
