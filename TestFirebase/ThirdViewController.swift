//
//  thirdViewController.swift
//  TestFirebase
//
//  Created by Гость on 29.10.2025.
//

import UIKit
import SwiftUI

struct Person: Hashable {
    let id: UUID
    let name: String
}

final class ThirdViewController: UIViewController {

    // MARK: - Properties
    private var users: [UserModel] = []

    private var dataSource: UICollectionViewDiffableDataSource<Section, UserModel>?
    private let networkManager: NetworkManagerProtocol = NetworkManager()

    private enum Section: CaseIterable {
        case main
    }

    // MARK: - SubView
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .darkGray
        collectionView.register(UserCell.self, forCellWithReuseIdentifier: UserCell.identifier)
        return collectionView
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        view.addSubview(collectionView)
        setupDataSource()
        loadData()
    }

    // MARK: - Create Compositional Layout
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let spacing: CGFloat = 10

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.23))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }

    private func updateSnapshot(with users: [UserModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, UserModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(users)
        dataSource?.apply(snapshot)
    }

    // MARK: - Setup DataSource
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource(
            collectionView: collectionView,
            cellProvider: { [weak self] collectionView, indexPath, user in
                guard let self, let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserCell.identifier, for: indexPath) as? UserCell else { return UICollectionViewCell()}
                cell.configureCell(for: user, manager: self.networkManager)
                cell.backgroundColor = .gray
                cell.layer.cornerRadius = 10
                cell.clipsToBounds = true
                return cell
            })
    }

    private func loadData() {
        Task {
            do {
                let fetchedUsers = try await networkManager.fetchData()
                users = fetchedUsers
                updateSnapshot(with: users)
            } catch {
                print("Ошибка загрузки: \(error)")
            }
        }
    }
}

// MARK: - SwiftUI Preview
struct ThirdProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {

        let collectionVC = ThirdViewController()

        func makeUIViewController(context: Context) -> ThirdViewController {
            return collectionVC
        }

        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    }
}
