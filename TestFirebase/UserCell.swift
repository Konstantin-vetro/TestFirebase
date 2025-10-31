//
//  UserCell.swift
//  TestFirebase
//
//  Created by Гость on 30.10.2025.
//

import UIKit

final class UserCell: UICollectionViewCell {

    static let identifier = "userCellIdentifier"

    private let spacing: CGFloat = 8

    private let avatarImage: UIImageView = {
        let image = UIImage(systemName: "photo.artframe.circle")
        let imageView = UIImageView(image: image)
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        imageView.backgroundColor = .red
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private let userNameLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private let emailLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private let phoneLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubview()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCell(for user: UserModel, manager: NetworkManagerProtocol) {
        nameLabel.text = "Name: \(user.name)"
        userNameLabel.text = "User name: \(user.name)"
        emailLabel.text = "Email: \(user.email)"
        phoneLabel.text = "Phone: \(user.phone)"

        loadImage(from: manager)
    }

    private func setupSubview() {
        [avatarImage, nameLabel, userNameLabel, emailLabel, phoneLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }

        setupConstraint()
    }

    private func setupConstraint() {
        NSLayoutConstraint.activate([
            avatarImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: spacing),
            avatarImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: spacing),
            avatarImage.heightAnchor.constraint(equalToConstant: 50),
            avatarImage.widthAnchor.constraint(equalToConstant: 50)
        ])

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: spacing),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImage.leadingAnchor, constant: spacing)
        ])

        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: spacing),
            userNameLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor)
        ])

        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: spacing),
            emailLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor)
        ])

        NSLayoutConstraint.activate([
            phoneLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: spacing),
            phoneLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor)
        ])
    }

    private func loadImage(from manager: NetworkManagerProtocol) {
        Task {
            let image = await manager.downloadImage()
            DispatchQueue.main.async {
                self.avatarImage.image = image
            }
        }
    }
}
