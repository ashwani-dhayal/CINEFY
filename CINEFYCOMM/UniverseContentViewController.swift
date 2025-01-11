import UIKit

class UniverseContentViewController: UIViewController {
    // MARK: - Properties
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = .black
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    private let navigationBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .systemBlue
        return button
    }()
    
    private let backLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Back"
        label.textColor = .systemBlue
        label.font = .systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    private let carouselCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 15
        layout.itemSize = CGSize(width: 280, height: 380)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        collection.isPagingEnabled = true
        return collection
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "In This Universe"
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private let playTrailerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Play Trailer"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private let trailerImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 12
        iv.image = UIImage(named: "trailer_thumbnail")
        return iv
    }()
    
    private let castView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let castLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Cast"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private let seeAllButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("See all", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        return button
    }()
    
    private let castCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 140, height: 180)
        layout.minimumLineSpacing = 15
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    private let tabBar: UITabBar = {
        let tabBar = UITabBar()
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        tabBar.backgroundColor = UIColor(white: 0.1, alpha: 1.0)
        tabBar.tintColor = .red
        tabBar.unselectedItemTintColor = .gray
        return tabBar
    }()
    
    // MARK: - Data
    private let carouselImages = ["movie1", "movie2"]
    private let castData = [
        (name: "Rajkummar Rao", image: "rajkummar"),
        (name: "Shraddha Kapoor", image: "shraddha"),
        (name: "Varun Dhawan", image: "varundhawan"),
        (name: "Kriti Sanon", image: "kritisanon"),
        (name: "Abhishek Banerjee", image: "AbhishekBanerjee")
    ]
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionViews()
      //  setupTabBar()
    }
    
    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = .black
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        view.addSubview(navigationBar)
        view.addSubview(scrollView)
        view.addSubview(tabBar)
        
        navigationBar.addSubview(backButton)
        navigationBar.addSubview(backLabel)
        
        scrollView.addSubview(contentView)
        
        [titleLabel, carouselCollectionView, playTrailerLabel, trailerImageView,
         castView].forEach { contentView.addSubview($0) }
        
        castView.addSubview(castLabel)
        castView.addSubview(seeAllButton)
        castView.addSubview(castCollectionView)
        
        setupConstraints()
        setupActions()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Navigation Bar
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBar.heightAnchor.constraint(equalToConstant: 44),
            
            backButton.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor, constant: 16),
            backButton.centerYAnchor.constraint(equalTo: navigationBar.centerYAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 24),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            
            backLabel.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 4),
            backLabel.centerYAnchor.constraint(equalTo: navigationBar.centerYAnchor),
            
            // ScrollView
            scrollView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: tabBar.topAnchor),
            
            // Content View
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // Title
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            // Carousel
            carouselCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            carouselCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            carouselCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            carouselCollectionView.heightAnchor.constraint(equalToConstant: 380),
            
            // Play Trailer
            playTrailerLabel.topAnchor.constraint(equalTo: carouselCollectionView.bottomAnchor, constant: 24),
            playTrailerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            // Trailer Image
            trailerImageView.topAnchor.constraint(equalTo: playTrailerLabel.bottomAnchor, constant: 12),
            trailerImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            trailerImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            trailerImageView.heightAnchor.constraint(equalToConstant: 200),
            
            // Cast View
            castView.topAnchor.constraint(equalTo: trailerImageView.bottomAnchor, constant: 24),
            castView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            castView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            castView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            castLabel.topAnchor.constraint(equalTo: castView.topAnchor),
            castLabel.leadingAnchor.constraint(equalTo: castView.leadingAnchor, constant: 16),
            
            seeAllButton.centerYAnchor.constraint(equalTo: castLabel.centerYAnchor),
            seeAllButton.trailingAnchor.constraint(equalTo: castView.trailingAnchor, constant: -16),
            
            castCollectionView.topAnchor.constraint(equalTo: castLabel.bottomAnchor, constant: 16),
            castCollectionView.leadingAnchor.constraint(equalTo: castView.leadingAnchor),
            castCollectionView.trailingAnchor.constraint(equalTo: castView.trailingAnchor),
            castCollectionView.heightAnchor.constraint(equalToConstant: 180),
            castCollectionView.bottomAnchor.constraint(equalTo: castView.bottomAnchor),
            
            // Tab Bar
            tabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupCollectionViews() {
        carouselCollectionView.register(ContentCarouselCell.self, forCellWithReuseIdentifier: "CarouselCell")
        castCollectionView.register(TalentProfileCell.self, forCellWithReuseIdentifier: "CastCell")
        
        carouselCollectionView.delegate = self
        carouselCollectionView.dataSource = self
        castCollectionView.delegate = self
        castCollectionView.dataSource = self
    }
    
    private func setupTabBar() {
        let homeItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
        let exploreItem = UITabBarItem(title: "Explore", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        let communityItem = UITabBarItem(title: "Community", image: UIImage(systemName: "person.3.fill"), tag: 2)
        let profileItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.circle"), tag: 3)
        
        tabBar.items = [homeItem, exploreItem, communityItem, profileItem]
        tabBar.selectedItem = homeItem
        tabBar.delegate = self
    }
    
    private func setupActions() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        seeAllButton.addTarget(self, action: #selector(seeAllTapped), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func seeAllTapped() {
        // Handle see all tapped
    }
}

// MARK: - Collection View Delegates
extension UniverseContentViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == carouselCollectionView ? carouselImages.count : castData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == carouselCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselCell", for: indexPath) as! ContentCarouselCell
            cell.configure(with: UIImage(named: carouselImages[indexPath.item]))
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastCell", for: indexPath) as! TalentProfileCell
            let castMember = castData[indexPath.item]
            cell.configure(with: UIImage(named: castMember.image), name: castMember.name)
            return cell
        }
    }
}

// MARK: - TabBar Delegate
extension UniverseContentViewController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        // Handle tab selection
    }
}

// MARK: - ContentCarouselCell
class ContentCarouselCell: UICollectionViewCell {
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 12
        return iv
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
    
    func configure(with image: UIImage?) {
        imageView.image = image
    }
}

// MARK: - TalentProfileCell
class TalentProfileCell: UICollectionViewCell {
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 8
        return iv
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .left
        label.numberOfLines = 2
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
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(with image: UIImage?, name: String) {
        imageView.image = image
        nameLabel.text = name
    }
}
