//
//  HistoryViewController.swift
//  FitnessApp
//
//  Created by Карина Хайрулина on 29.05.2023.
//

import UIKit

struct Training {
    var name: String
    var isLiked: Bool
}

class HistoryViewController: UITableViewController {
    var trainings: [Training] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: "CustomCell")
        tableView.tableFooterView = UIView()

        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none

        fetchTrainingsFromFirebase()
    }

    func fetchTrainingsFromFirebase() {
        // здесь симуляция того, что получаешь из файребейза, нужно изменить на реальное получение данных
        let trainingNames: [String] = ["Тренировка 1", "Тренировка 2", "Тренировка 3"]
        trainings = trainingNames.map { Training(name: $0, isLiked: false) }

        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trainings.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! HistoryTableViewCell

        let training = trainings[indexPath.row]
        cell.titleLabel.text = training.name
        cell.likeButton.isSelected = training.isLiked

        cell.selectionStyle = .none // Отключение выделения ячейки при нажатии

        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped(_:)), for: .touchUpInside)

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }

    @objc func likeButtonTapped(_ sender: UIButton) {
        let index = sender.tag
        trainings[index].isLiked.toggle()

        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
    }
}

class HistoryTableViewCell: UITableViewCell {
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.layer.cornerRadius = 10.0
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 18.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        button.tintColor = UIColor.red
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
        setupConstraints()

        let arrowImageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        arrowImageView.tintColor = UIColor.black
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(arrowImageView)

        NSLayoutConstraint.activate([
            arrowImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16.0),
            arrowImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            arrowImageView.widthAnchor.constraint(equalToConstant: 24.0),
            arrowImageView.heightAnchor.constraint(equalToConstant: 24.0)
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(likeButton)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0),
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 8.0),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8.0),

            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16.0),
            titleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),

            likeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -48.0),
            likeButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            likeButton.widthAnchor.constraint(equalToConstant: 24.0),
            likeButton.heightAnchor.constraint(equalToConstant: 24.0)
        ])
    }
}





