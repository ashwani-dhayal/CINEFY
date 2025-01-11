import UIKit

class CommunityViewController: UIViewController {
    private let genreDataSource = GenreDataSource.shared
    
    private lazy var titleStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var cinefyLabel: UILabel = {
        let label = UILabel()
        let text = "Cinefy"
        let attributedString = NSMutableAttributedString(string: text)
        
        // Set "C" to red
        attributedString.addAttribute(.foregroundColor,
                                    value: UIColor.red,
                                    range: NSRange(location: 0, length: 1))
        
        // Set rest of text to white
        attributedString.addAttribute(.foregroundColor,
                                    value: UIColor.white,
                                    range: NSRange(location: 1, length: text.count - 1))
        
        label.attributedText = attributedString
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private lazy var communityLabel: UILabel = {
        let label = UILabel()
        label.text = "Community"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
        cv.register(GenreCell.self, forCellWithReuseIdentifier: GenreCell.identifier)
        cv.showsVerticalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        
        // Add and configure stack view with labels
        view.addSubview(titleStackView)
        titleStackView.addArrangedSubview(cinefyLabel)
        titleStackView.addArrangedSubview(communityLabel)
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            titleStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            collectionView.topAnchor.constraint(equalTo: titleStackView.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.isHidden = true // Hide the navigation bar
    }
}

// MARK: - UICollectionViewDelegate & DataSource
extension CommunityViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genreDataSource.genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCell.identifier, for: indexPath) as? GenreCell else {
            return UICollectionViewCell()
        }
        
        let genre = genreDataSource.genres[indexPath.item]
        cell.configure(with: genre)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let genre = genreDataSource.genres[indexPath.item]
        if genre.name == "Scific" {
            let sciFiVC = SciFiViewController()
            navigationController?.pushViewController(sciFiVC, animated: true)
        }
        // Handle genre selection
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CommunityViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - 32 // Accounting for left and right insets
        return CGSize(width: width, height: 160)
    }
}
