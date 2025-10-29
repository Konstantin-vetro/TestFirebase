//
//  ViewController.swift
//  TestFirebase
//
//  Created by Гость on 15.10.2025.
//

import UIKit

final class ViewController: UIViewController {

    // MARK: - Properties

    private var count = 0

    // MARK: - UI

    private let textLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Hello world"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()

    private let tapButton: UIButton = {
        let button = UIButton()
        button.setTitle("Tap me", for: .normal)
        button.backgroundColor = .blue
        return button
    }()

    private let putDataButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save Value", for: .normal)
        button.backgroundColor = .green
        return button
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.addArrangedSubview(textLabel)
        stackView.addArrangedSubview(tapButton)
        stackView.addArrangedSubview(putDataButton)
        return stackView
    }()

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - SetupLayouts
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(stackView)

        [tapButton, putDataButton].forEach {
            $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = true
        }
        tapButton.addTarget(self, action: #selector(tapMe), for: .touchUpInside)
        putDataButton.addTarget(self, action: #selector(putData), for: .touchUpInside)

        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
        ])
    }

    // MARK: - Actions
    @objc
    private func tapMe() {
        count += 1
        textLabel.text = "\(count)"
    }

    @objc
    private func putData() {
        let secondVC = SecondViewController(text: "\(count)")
        secondVC.delegate = self
        present(secondVC, animated: true)
    }
}

extension ViewController: BackDataProtocolDelegate {
    func returnData(text: String) {
        textLabel.text = text
    }
}
