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
    private var persons: [Person] = [
        Person(id: UUID(), name: "Alex"),
        Person(id: UUID(), name: "Jake"),
        Person(id: UUID(), name: "Lisa")
    ]
    private var dataSource: UICollectionViewDiffableDataSource<Section, Person>?

    private enum Section: CaseIterable {
        case main
    }

    // MARK: - SubView
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .white
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        return collectionView
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        view.addSubview(collectionView)
        setupDataSource()
        updateSnapshot()
    }

    // MARK: - Setup Views
    // 1 CREATE Compositional LAYOUT
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let inset: CGFloat = 5

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.2))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 5
        section.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }

    private func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Person>()
        snapshot.appendSections([.main])
        snapshot.appendItems(persons)
        dataSource?.apply(snapshot)
    }

    // MARK: - Setup Constraints

    // MARK: - Private Methods
    // 2 Setup DataSource
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, person in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
                var configuration = UIListContentConfiguration.cell()
                configuration.text = person.name
                cell.contentConfiguration = configuration
                cell.backgroundColor = .orange
                cell.layer.borderColor = UIColor.red.cgColor
                cell.layer.borderWidth = 5
                return cell
        })
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
