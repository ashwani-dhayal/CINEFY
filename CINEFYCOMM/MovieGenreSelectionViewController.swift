
import UIKit

class MovieGenreSelectionViewController: UIViewController {
    
    // MARK: - Properties
    private let genres: [(name: String, imageName: String)] = [
        ("Action", "genre_action"),
        ("Adventure", "genre_adventure"),
        ("Animation", "genre_animation"),
        ("Comedy", "genre_comedy"),
        ("Drama", "genre_drama"),
        ("Fantasy", "genre_fantasy"),
        ("Horror", "genre_horror"),
        ("Mystery", "genre_mystery"),
        ("Romance", "genre_romance"),
        ("Sci-Fi", "scifi"),
        ("Thriller", "genre_thriller"),
        ("Western", "genre_western")
    ]
    
    private let logoLabel: UILabel = {
        let label = UILabel()
        // Create attributed string for "Cinefy." with red C
        let fullText = "Cinefy"
        let attributedString = NSMutableAttributedString(string: fullText)
        
        // Set the "C" to red
        attributedString.addAttribute(.foregroundColor,
                                    value: UIColor.systemRed,
                                    range: NSRange(location: 0, length: 1))
        
        // Set the rest to white
        attributedString.addAttribute(.foregroundColor,
                                    value: UIColor.white,
                                    range: NSRange(location: 1, length: fullText.count - 1))
        
        label.attributedText = attributedString
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Select your genre"
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 20
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
        cv.register(MovieCategoryCell.self, forCellWithReuseIdentifier: "MovieCategoryCell")
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    private let continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Continue", for: .normal)
        button.backgroundColor = .systemRed
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = .black
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        view.addSubview(logoLabel)
        view.addSubview(titleLabel)
        view.addSubview(collectionView)
        view.addSubview(continueButton)
        
        NSLayoutConstraint.activate([
            logoLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            logoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            titleLabel.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            continueButton.heightAnchor.constraint(equalToConstant: 50),
            
            collectionView.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -20)
        ])
        
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
    }
    
  
    @objc private func continueButtonTapped() {
        let artistSelectionVC = ArtistSelectionViewController()
        artistSelectionVC.modalPresentationStyle = .fullScreen
        present(artistSelectionVC, animated: true)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension MovieGenreSelectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCategoryCell", for: indexPath) as! MovieCategoryCell
        let genre = genres[indexPath.item]
        cell.configure(with: genre.name, imageName: genre.imageName)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MovieGenreSelectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 16) / 2
        return CGSize(width: width, height: width * 1.2) // Slightly taller to accommodate the label
    }
}

// MARK: - Movie Category Cell
class MovieCategoryCell: UICollectionViewCell {
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = (UIScreen.main.bounds.width - 56) / 4 // Make it perfectly circular
        iv.backgroundColor = .darkGray // Placeholder color
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(with title: String, imageName: String) {
        titleLabel.text = title
        
        // Load and set the image
        if let image = UIImage(named: imageName) {
            imageView.image = image
        } else {
            
            imageView.backgroundColor = .darkGray
        }
    }
}
