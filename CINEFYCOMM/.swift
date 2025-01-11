//
//  MovieDetailsViewController.swift
//  CINEFYCOMM
//
//  Created by user@71 on 03/01/25.
//

import UIKit

// MARK: - MovieDetailsViewController
class MovieDetailsViewController: UIViewController {
    
    // MARK: - UI Components
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = .black
        sv.showsVerticalScrollIndicator = false
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let headerImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let playTrailerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Play Trailer", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let movieInfoStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private let movieMetadataLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let movieDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private let genreStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .fillProportionally
        return stack
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let watchlistButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add to Watchlist", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let castTitleStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    
    private let castLabel: UILabel = {
        let label = UILabel()
        label.text = "Cast"
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let seeAllButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("See all", for: .normal)
        button.tintColor = .systemRed
        return button
    }()
    
    private lazy var castCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 140)
        layout.minimumInteritemSpacing = 10
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        cv.delegate = self
        cv.dataSource = self
        cv.register(CastCollectionViewCell.self, forCellWithReuseIdentifier: "CastCell")
        cv.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    // MARK: - Properties
    private var castMembers: [(name: String, image: String)] = [
        ("Tom Cruise", "tomcruise"),
        ("Miles Teller", "milesteller")
    ]
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureNavigationBar()
        populateMovieData()
    }
    
    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = .black
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentStack)
        
        // Add header image and play button
        contentStack.addArrangedSubview(headerImageView)
        headerImageView.addSubview(playTrailerButton)
        
        // Add movie info
        contentStack.addArrangedSubview(movieInfoStack)
        movieInfoStack.addArrangedSubview(movieTitleLabel)
        movieInfoStack.addArrangedSubview(movieMetadataLabel)
        movieInfoStack.addArrangedSubview(genreStack)
        movieInfoStack.addArrangedSubview(movieDescriptionLabel)
        
        // Add watchlist button
        contentStack.addArrangedSubview(watchlistButton)
        
        // Add cast section
        contentStack.addArrangedSubview(castTitleStack)
        castTitleStack.addArrangedSubview(castLabel)
        castTitleStack.addArrangedSubview(seeAllButton)
        
        contentStack.addArrangedSubview(castCollectionView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentStack.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            headerImageView.heightAnchor.constraint(equalToConstant: 300),
            
            playTrailerButton.centerXAnchor.constraint(equalTo: headerImageView.centerXAnchor),
            playTrailerButton.centerYAnchor.constraint(equalTo: headerImageView.centerYAnchor),
            playTrailerButton.widthAnchor.constraint(equalToConstant: 120),
            playTrailerButton.heightAnchor.constraint(equalToConstant: 40),
            
            watchlistButton.heightAnchor.constraint(equalToConstant: 44),
            watchlistButton.leadingAnchor.constraint(equalTo: contentStack.leadingAnchor, constant: 16),
            watchlistButton.trailingAnchor.constraint(equalTo: contentStack.trailingAnchor, constant: -16),
            
            castCollectionView.heightAnchor.constraint(equalToConstant: 140)
        ])
    }
    
    private func configureNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    private func populateMovieData() {
        headerImageView.image = UIImage(named: "topgun")
        movieTitleLabel.text = "Top Gun: Maverick"
        movieMetadataLabel.text = "2022 · U/A · 2h 10m"
        ratingLabel.text = "9.5 ★"
        movieDescriptionLabel.text = "Top Gun: Maverick is a high-octane tale of legacy, redemption, and heroics. The story involves Maverick confronting his past while training a group of younger Top Gun graduates, including the son of his deceased best friend, for a dangerous mission."
        
        // Add genre pills
        ["Action Epic", "Epic", "Drama"].forEach { genre in
            let pill = createGenrePill(with: genre)
            genreStack.addArrangedSubview(pill)
        }
    }
    
    private func createGenrePill(with text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .white
        label.font = .systemFont(ofSize: 12)
        label.backgroundColor = .darkGray
        label.layer.cornerRadius = 4
        label.clipsToBounds = true
        label.textAlignment = .center
        label.layoutMargins = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        return label
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UICollectionView Extensions
extension MovieDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return castMembers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastCell", for: indexPath) as! CastCollectionViewCell
        let castMember = castMembers[indexPath.item]
        cell.configure(name: castMember.name, image: castMember.image)
        return cell
    }
}

// MARK: - Cast Collection View Cell
class CastCollectionViewCell: UICollectionViewCell {
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 8
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(name: String, image: String) {
        nameLabel.text = name
        imageView.image = UIImage(named: image)
    }
}
