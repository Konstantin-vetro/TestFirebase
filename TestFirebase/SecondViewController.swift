//
//  SecondViewController.swift
//  TestFirebase
//
//  Created by Гость on 15.10.2025.
//

import UIKit

protocol BackDataProtocolDelegate: AnyObject {
    func returnData(text: String)
}

final class SecondViewController: UIViewController {

    // MARK: - Properties

    private var text: String
    weak var delegate: BackDataProtocolDelegate?

    // MARK: - SubViews

    private lazy var importLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()

    private lazy var changeButton: UIButton = {
        let button = UIButton()
        button.setTitle("изменить на новое", for: .normal)
        button.addTarget(self, action: #selector(changeValue), for: .touchUpInside)
        return button
    }()

    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setTitle("вернуться", for: .normal)
        button.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        return button
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.addArrangedSubview(importLabel)
        stackView.addArrangedSubview(changeButton)
        stackView.addArrangedSubview(backButton)
        return stackView
    }()

    // MARK: - Initialization

    init(text: String) {
        self.text = text
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
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

    // MARK: - SetupLayout
    private func setupLayout() {
        view.backgroundColor = .gray
        view.addSubview(stackView)
        importLabel.text = text

        [changeButton, backButton].forEach {
            $0.layer.cornerRadius = 20
            $0.layer.masksToBounds = true
            $0.backgroundColor = .blue
        }

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
        ])
    }
}
