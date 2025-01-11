
/*
import UIKit

class DetailedProfileViewController: UIViewController {
    // MARK: - Properties
    private let user: User
    
    // MARK: - UI Components
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "person.circle.fill")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let editButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.tintColor = .systemGreen
        return button
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let infoStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()
    
    private let watchlistLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Watchlist"
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let seeAllButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("See All", for: .normal)
        button.setTitleColor(.red, for: .normal)
        return button
    }()
    
    private let watchlistCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.minimumInteritemSpacing = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private let watchedMoviesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 40, height: 100)
        layout.minimumLineSpacing = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    private let tabBar: UITabBar = {
        let tabBar = UITabBar()
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        tabBar.backgroundColor = .black
        tabBar.tintColor = .red
        tabBar.unselectedItemTintColor = .gray
        
        let homeItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        let exploreItem = UITabBarItem(title: "Explore", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        let communityItem = UITabBarItem(title: "Community", image: UIImage(systemName: "person.3"), tag: 2)
        let profileItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 3)
        
        tabBar.items = [homeItem, exploreItem, communityItem, profileItem]
        tabBar.selectedItem = profileItem
        
        return tabBar
    }()
    
    // MARK: - Initializer
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        configureWithUser()
    }
    
    // MARK: - Setup Methods
    private func setupUI() {
        view.backgroundColor = .black
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(profileImageView)
        contentView.addSubview(editButton)
        contentView.addSubview(nameLabel)
        contentView.addSubview(bioLabel)
        contentView.addSubview(infoStackView)
        contentView.addSubview(watchlistLabel)
        contentView.addSubview(seeAllButton)
        contentView.addSubview(watchlistCollectionView)
        contentView.addSubview(watchedMoviesCollectionView)
        
        view.addSubview(tabBar)
        
        watchlistCollectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "MovieCell")
        watchedMoviesCollectionView.register(WatchedMovieCell.self, forCellWithReuseIdentifier: "WatchedMovieCell")
        
        watchlistCollectionView.delegate = self
        watchlistCollectionView.dataSource = self
        watchedMoviesCollectionView.delegate = self
        watchedMoviesCollectionView.dataSource = self
    }
    
    private func configureWithUser() {
        nameLabel.text = user.name
        bioLabel.text = "Movie Enthusiast"
        
        // Add user info items
        let usernameItem = createInfoItem(icon: "person", title: "Username", value: user.username)
        let contactItem = createInfoItem(icon: "phone", title: "Contact", value: user.contact)
        let emailItem = createInfoItem(icon: "envelope", title: "Email", value: user.email)
        
        [usernameItem, contactItem, emailItem].forEach { infoStackView.addArrangedSubview($0) }
    }
    
    private func createInfoItem(icon: String, title: String, value: String) -> UIView {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        
        let iconImage = UIImageView(image: UIImage(systemName: icon))
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        iconImage.tintColor = .white
        iconImage.contentMode = .scaleAspectFit
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = title
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 16)
        
        let valueLabel = UILabel()
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.text = value
        valueLabel.textColor = .gray
        valueLabel.font = .systemFont(ofSize: 16)
        
        container.addSubview(iconImage)
        container.addSubview(titleLabel)
        container.addSubview(valueLabel)
        
        NSLayoutConstraint.activate([
            iconImage.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            iconImage.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            iconImage.widthAnchor.constraint(equalToConstant: 24),
            iconImage.heightAnchor.constraint(equalToConstant: 24),
            
            titleLabel.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: 12),
            titleLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            
            valueLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            valueLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            
            container.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        return container
    }
}

// MARK: - UICollectionViewDelegate & DataSource
extension DetailedProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == watchlistCollectionView ? 6 : 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == watchlistCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCollectionViewCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WatchedMovieCell", for: indexPath) as! WatchedMovieCell
            return cell
        }
    }
}

// MARK: - Custom Cells
class MovieCollectionViewCell: UICollectionViewCell {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.backgroundColor = .darkGray
        return imageView
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
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

class WatchedMovieCell: UICollectionViewCell {
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.3)
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 4
        imageView.backgroundColor = .darkGray
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 2
        return label
    }()
    
    private let ratingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(containerView)
        containerView.addSubview(movieImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(ratingView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            movieImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            movieImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            movieImageView.widthAnchor.constraint(equalToConstant: 60),
            movieImageView.heightAnchor.constraint(equalToConstant: 80),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 12),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12)
*/






/*
import UIKit
protocol MovieCellConfigurable {
    func configure(with movie: MovieDetail)
}
class DetailedProfileViewController: UIViewController {
    // MARK: - Properties
    private let user: User
    private var movies: [MovieDetail] = []
    private var watchedMovies: [MovieDetail] = []
    
    // MARK: - UI Components
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .black
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "person.circle.fill")
        imageView.tintColor = .systemGray
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var editButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.tintColor = .systemGreen
        button.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private lazy var bioLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()
    
    private lazy var watchlistLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Watchlist"
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private lazy var seeAllButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("See All", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.addTarget(self, action: #selector(seeAllButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var watchlistCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.minimumInteritemSpacing = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private lazy var watchedMoviesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 40, height: 100)
        layout.minimumLineSpacing = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    private lazy var tabBar: UITabBar = {
        let tabBar = UITabBar()
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        tabBar.backgroundColor = .black
        tabBar.tintColor = .systemRed
        tabBar.unselectedItemTintColor = .gray
        
        let homeItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        let exploreItem = UITabBarItem(title: "Explore", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        let communityItem = UITabBarItem(title: "Community", image: UIImage(systemName: "person.3"), tag: 2)
        let profileItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 3)
        
        tabBar.items = [homeItem, exploreItem, communityItem, profileItem]
        tabBar.selectedItem = profileItem
        
        return tabBar
    }()
    
    // MARK: - Initialization
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        configureWithUser()
        loadMockData()
    }
    
    // MARK: - Setup Methods
    private func setupUI() {
        view.backgroundColor = .black
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [profileImageView, editButton, nameLabel, bioLabel, infoStackView,
         watchlistLabel, seeAllButton, watchlistCollectionView,
         watchedMoviesCollectionView].forEach { contentView.addSubview($0) }
        
        view.addSubview(tabBar)
        
        setupCollectionViews()
    }
    
    private func setupCollectionViews() {
        watchlistCollectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "MovieCell")
        watchedMoviesCollectionView.register(WatchedMovieCell.self, forCellWithReuseIdentifier: "WatchedMovieCell")
        
        watchlistCollectionView.delegate = self
        watchlistCollectionView.dataSource = self
        watchedMoviesCollectionView.delegate = self
        watchedMoviesCollectionView.dataSource = self
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // ScrollView
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: tabBar.topAnchor),
            
            // ContentView
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // Profile Components
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            profileImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 80),
            profileImageView.heightAnchor.constraint(equalToConstant: 80),
            
            editButton.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            editButton.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: -20),
            editButton.widthAnchor.constraint(equalToConstant: 24),
            editButton.heightAnchor.constraint(equalToConstant: 24),
            
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 16),
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            bioLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            bioLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            infoStackView.topAnchor.constraint(equalTo: bioLabel.bottomAnchor, constant: 24),
            infoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            infoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // Watchlist Components
            watchlistLabel.topAnchor.constraint(equalTo: infoStackView.bottomAnchor, constant: 24),
            watchlistLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            seeAllButton.centerYAnchor.constraint(equalTo: watchlistLabel.centerYAnchor),
            seeAllButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            watchlistCollectionView.topAnchor.constraint(equalTo: watchlistLabel.bottomAnchor, constant: 16),
            watchlistCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            watchlistCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            watchlistCollectionView.heightAnchor.constraint(equalToConstant: 200),
            
            // Watched Movies Collection
            watchedMoviesCollectionView.topAnchor.constraint(equalTo: watchlistCollectionView.bottomAnchor, constant: 24),
            watchedMoviesCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            watchedMoviesCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            watchedMoviesCollectionView.heightAnchor.constraint(equalToConstant: 350),
            watchedMoviesCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            // TabBar
            tabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func configureWithUser() {
        nameLabel.text = user.name
        bioLabel.text = "Movie Enthusiast"
        
        let usernameItem = createInfoItem(icon: "person", title: "Username", value: user.username)
        let contactItem = createInfoItem(icon: "phone", title: "Contact", value: user.contact)
        let emailItem = createInfoItem(icon: "envelope", title: "Email", value: user.email)
        
        [usernameItem, contactItem, emailItem].forEach { infoStackView.addArrangedSubview($0) }
    }
    
    private func createInfoItem(icon: String, title: String, value: String) -> UIView {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        
        let iconImage = UIImageView(image: UIImage(systemName: icon))
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        iconImage.tintColor = .white
        iconImage.contentMode = .scaleAspectFit
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = title
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 16)
        
        let valueLabel = UILabel()
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.text = value
        valueLabel.textColor = .gray
        valueLabel.font = .systemFont(ofSize: 16)
        
        [iconImage, titleLabel, valueLabel].forEach { container.addSubview($0) }
        
        NSLayoutConstraint.activate([
            iconImage.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            iconImage.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            iconImage.widthAnchor.constraint(equalToConstant: 24),
            iconImage.heightAnchor.constraint(equalToConstant: 24),
            
            titleLabel.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: 12),
            titleLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            
            valueLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            valueLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            
            container.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        return container
    }

class DetailedProfileViewController: UIViewController {
    // MARK: - Properties
    private let user: User
    
    // MARK: - UI Components
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "person.circle.fill")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let editButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.tintColor = .systemGreen
        return button
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let infoStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()
    
    private let watchlistLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Watchlist"
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let seeAllButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("See All", for: .normal)
        button.setTitleColor(.red, for: .normal)
        return button
    }()
    
    private let watchlistCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.minimumInteritemSpacing = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private let watchedMoviesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 40, height: 100)
        layout.minimumLineSpacing = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    private let tabBar: UITabBar = {
        let tabBar = UITabBar()
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        tabBar.backgroundColor = .black
        tabBar.tintColor = .red
        tabBar.unselectedItemTintColor = .gray
        
        let homeItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        let exploreItem = UITabBarItem(title: "Explore", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        let communityItem = UITabBarItem(title: "Community", image: UIImage(systemName: "person.3"), tag: 2)
        let profileItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 3)
        
        tabBar.items = [homeItem, exploreItem, communityItem, profileItem]
        tabBar.selectedItem = profileItem
        
        return tabBar
    }()
    
    // MARK: - Initializer
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        configureWithUser()
    }
    
    // MARK: - Setup Methods
    private func setupUI() {
        view.backgroundColor = .black
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(profileImageView)
        contentView.addSubview(editButton)
        contentView.addSubview(nameLabel)
        contentView.addSubview(bioLabel)
        contentView.addSubview(infoStackView)
        contentView.addSubview(watchlistLabel)
        contentView.addSubview(seeAllButton)
        contentView.addSubview(watchlistCollectionView)
        contentView.addSubview(watchedMoviesCollectionView)
        
        view.addSubview(tabBar)
        
        watchlistCollectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "MovieCell")
        watchedMoviesCollectionView.register(WatchedMovieCell.self, forCellWithReuseIdentifier: "WatchedMovieCell")
        
        watchlistCollectionView.delegate = self
        watchlistCollectionView.dataSource = self
        watchedMoviesCollectionView.delegate = self
        watchedMoviesCollectionView.dataSource = self
    }
    
    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            // ScrollView
            scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: tabBar.topAnchor),
            
            // ContentView
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // Profile Image
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            profileImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 80),
            profileImageView.heightAnchor.constraint(equalToConstant: 80),
            
            // Edit Button
            editButton.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            editButton.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: -20),
            editButton.widthAnchor.constraint(equalToConstant: 24),
            editButton.heightAnchor.constraint(equalToConstant: 24),
            
            // Name Label
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 16),
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            // Bio Label
            bioLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            bioLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            // Info Stack View
            infoStackView.topAnchor.constraint(equalTo: bioLabel.bottomAnchor, constant: 24),
            infoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            infoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // Watchlist Label
            watchlistLabel.topAnchor.constraint(equalTo: infoStackView.bottomAnchor, constant: 24),
            watchlistLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            // See All Button
            seeAllButton.centerYAnchor.constraint(equalTo: watchlistLabel.centerYAnchor),
            seeAllButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // Watchlist Collection View
            watchlistCollectionView.topAnchor.constraint(equalTo: watchlistLabel.bottomAnchor, constant: 16),
            watchlistCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            watchlistCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            watchlistCollectionView.heightAnchor.constraint(equalToConstant: 200),
            
            // Watched Movies Collection View
            watchedMoviesCollectionView.topAnchor.constraint(equalTo: watchlistCollectionView.bottomAnchor, constant: 24),
            watchedMoviesCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            watchedMoviesCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            watchedMoviesCollectionView.heightAnchor.constraint(equalToConstant: 350),
            watchedMoviesCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            // Tab Bar
            tabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func configureWithUser() {
        nameLabel.text = user.name
        bioLabel.text = "Movie Enthusiast"
        
        // Add user info items
        let usernameItem = createInfoItem(icon: "person", title: "Username", value: user.username)
        let contactItem = createInfoItem(icon: "phone", title: "Contact", value: user.contact)
        let emailItem = createInfoItem(icon: "envelope", title: "Email", value: user.email)
        
        [usernameItem, contactItem, emailItem].forEach { infoStackView.addArrangedSubview($0) }
    }
    
    private func createInfoItem(icon: String, title: String, value: String) -> UIView {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        
        let iconImage = UIImageView(image: UIImage(systemName: icon))
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        iconImage.tintColor = .white
        iconImage.contentMode = .scaleAspectFit
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = title
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 16)
        
        let valueLabel = UILabel()
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.text = value
        valueLabel.textColor = .gray
        valueLabel.font = .systemFont(ofSize: 16)
        
        container.addSubview(iconImage)
        container.addSubview(titleLabel)
        container.addSubview(valueLabel)
        
        NSLayoutConstraint.activate([
            iconImage.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            iconImage.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            iconImage.widthAnchor.constraint(equalToConstant: 24),
            iconImage.heightAnchor.constraint(equalToConstant: 24),
            
            titleLabel.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: 12),
            titleLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            
            valueLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            valueLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            
            container.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        return container
    }
}

// MARK: - UICollectionViewDelegate & DataSource
extension DetailedProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == watchlistCollectionView ? 6 : 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == watchlistCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCollectionViewCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WatchedMovieCell", for: indexPath) as! WatchedMovieCell
                        // Configure the cell with movie data
            let movie = MovieDetail(
                            title: "Pushpa 2: The Rule",
                            description: "Chronicles Pushparaj's survival and rise to power, delving into themes of ego, survival...",
                            rating: 4.5,
                            imageURL: nil
                        )
                        cell.configure(with: movie)
                        return cell
                    }
                }
            }

            // MARK: - Movie Collection View Cell
            class MovieCollectionViewCell: UICollectionViewCell {
                private let imageView: UIImageView = {
                    let imageView = UIImageView()
                    imageView.translatesAutoresizingMaskIntoConstraints = false
                    imageView.contentMode = .scaleAspectFill
                    imageView.clipsToBounds = true
                    imageView.layer.cornerRadius = 8
                    imageView.backgroundColor = .darkGray
                    return imageView
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
                    NSLayoutConstraint.activate([
                        imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                        imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
                    ])
                }
                func configure(with movie: Movie) {
                    // Create MovieDetail instance with lowercase variable name
                    let movieDetail = MovieDetail(
                        title: movie.title,
                        description: movie.description,
                        rating: movie.rating,
                        systemImageName: "film"
                    )
                    
                    // Update UI on main thread
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        
                        // Configure text elements
                        self.titleLabel.text = movieDetail.title
                        self.descriptionLabel.text = movieDetail.description
                        self.ratingLabel.text = String(format: "%.1f", movieDetail.rating)
                        
                        // Configure image with animation
                        UIView.transition(with: self.movieImageView,
                                         duration: 0.3,
                                         options: .transitionCrossDissolve) {
                            self.movieImageView.image = UIImage(systemName: movieDetail.systemImageName)?
                                .withRenderingMode(.alwaysTemplate)
                                .withTintColor(.systemBlue)
                        }
                        
                        // Accessibility
                        self.movieImageView.accessibilityLabel = "\(movieDetail.title) poster"
                        self.ratingLabel.accessibilityLabel = "Rating: \(movieDetail.rating) out of 5"
                    }
                    
                    // Optional: Add error handling
                    func handleError(_ error: Error) {
                        DispatchQueue.main.async { [weak self] in
                            guard let self = self else { return }
                            // Set default system image in case of error
                            self.movieImageView.image = UIImage(systemName: "exclamationmark.triangle")
                            // You could also show an alert here if needed
                        }
                    }
                }
                
                

            // MARK: - Watched Movie Cell
            class WatchedMovieCell: UICollectionViewCell {
                private let containerView: UIView = {
                    let view = UIView()
                    view.translatesAutoresizingMaskIntoConstraints = false
                    view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.3)
                    view.layer.cornerRadius = 8
                    return view
                }()
                
                private let movieImageView: UIImageView = {
                    let imageView = UIImageView()
                    imageView.translatesAutoresizingMaskIntoConstraints = false
                    imageView.contentMode = .scaleAspectFill
                    imageView.clipsToBounds = true
                    imageView.layer.cornerRadius = 4
                    imageView.backgroundColor = .darkGray
                    return imageView
                }()
                
                private let titleLabel: UILabel = {
                    let label = UILabel()
                    label.translatesAutoresizingMaskIntoConstraints = false
                    label.textColor = .white
                    label.font = .systemFont(ofSize: 16, weight: .medium)
                    return label
                }()
                
                private let descriptionLabel: UILabel = {
                    let label = UILabel()
                    label.translatesAutoresizingMaskIntoConstraints = false
                    label.textColor = .gray
                    label.font = .systemFont(ofSize: 14)
                    label.numberOfLines = 2
                    return label
                }()
                
                private let ratingView: UIView = {
                    let view = UIView()
                    view.translatesAutoresizingMaskIntoConstraints = false
                    return view
                }()
                
                private let ratingLabel: UILabel = {
                    let label = UILabel()
                    label.translatesAutoresizingMaskIntoConstraints = false
                    label.textColor = .yellow
                    label.font = .systemFont(ofSize: 14, weight: .medium)
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
                    contentView.addSubview(containerView)
                    containerView.addSubview(movieImageView)
                    containerView.addSubview(titleLabel)
                    containerView.addSubview(descriptionLabel)
                    containerView.addSubview(ratingView)
                    ratingView.addSubview(ratingLabel)
                    
                    NSLayoutConstraint.activate([
                        containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
                        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                        
                        movieImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
                        movieImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
                        movieImageView.widthAnchor.constraint(equalToConstant: 60),
                        movieImageView.heightAnchor.constraint(equalToConstant: 80),
                        
                        titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
                        titleLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 12),
                        titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
                        
                        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
                        descriptionLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 12),
                        descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
                        
                        ratingView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
                        ratingView.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 12),
                        ratingView.heightAnchor.constraint(equalToConstant: 20),
                        
                        ratingLabel.topAnchor.constraint(equalTo: ratingView.topAnchor),
                        ratingLabel.leadingAnchor.constraint(equalTo: ratingView.leadingAnchor),
                        ratingLabel.bottomAnchor.constraint(equalTo: ratingView.bottomAnchor)
                    ])
                }
                
                func configure(with movie: MovieDetail) {
                    titleLabel.text = movie.title
                    descriptionLabel.text = movie.description
                    ratingLabel.text = String(format: "%.1f ★", movie.rating)
                    
                    if let imageURL = movie.imageURL {
                        // Load image from URL
                        // You would typically use an image loading library here
                    }
                }
            }
*/
