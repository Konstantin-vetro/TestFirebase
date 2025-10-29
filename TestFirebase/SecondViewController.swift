//
//  SecondViewController.swift
//  TestFirebase
//
//  Created by Гость on 15.10.2025.
//

import UIKit
import SwiftUI

protocol BackDataProtocolDelegate: AnyObject {
    func returnData(text: String)
}

final class SecondViewController: UIViewController {

    // MARK: - Properties
    private var text: String
    weak var delegate: BackDataProtocolDelegate?

    // MARK: - SubViews

    private let importLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()

    private let changeButton: UIButton = {
        let button = UIButton()
        button.setTitle("изменить на новое", for: .normal)
        return button
    }()

    private let backButton: UIButton = {
        let button = UIButton()
        button.setTitle("вернуться", for: .normal)
        return button
    }()

    private let collectionButton: UIButton = {
        let button = UIButton()
        button.setTitle("Перейти вперед", for: .normal)
        return button
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()

    // MARK: - Init
    init(text: String = "") {
        self.text = text
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    // MARK: - Actions
    @objc
    private func changeValue() {
        importLabel.text = "Your text is changed"
    }

    @objc
    private func backTapped() {
        let text = importLabel.text
        delegate?.returnData(text: text ?? "")
        dismiss(animated: true)
    }

    @objc
    private func goToCollectionTapped() {
        let thirdVC = ThirdViewController()
        present(thirdVC, animated: true)
    }

    // MARK: - SetupLayout

    private func setupViews() {
        view.backgroundColor = .gray
        view.addSubview(stackView)

        [importLabel, changeButton, backButton, collectionButton].forEach {
            stackView.addArrangedSubview($0)
        }

        changeButton.addTarget(self, action: #selector(changeValue), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        collectionButton.addTarget(self, action: #selector(goToCollectionTapped), for: .touchUpInside)

        importLabel.text = text

        [changeButton, backButton, collectionButton].forEach {
            $0.layer.cornerRadius = 20
            $0.layer.masksToBounds = true
            $0.backgroundColor = .blue
        }

        setupLayout()
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
        ])
    }
}
