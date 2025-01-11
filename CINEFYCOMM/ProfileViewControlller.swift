import UIKit

class ProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var watchlistCollectionView: UICollectionView!
    private var favouritesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        // Background Color
        view.backgroundColor = UIColor.black
        
        // Profile Section
        let profileImageView = UIImageView()
        profileImageView.backgroundColor = UIColor.darkGray
        profileImageView.layer.cornerRadius = 40
        profileImageView.clipsToBounds = true
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileImageView)
        
        let onlineIndicator = UIView()
        onlineIndicator.backgroundColor = .green
        onlineIndicator.layer.cornerRadius = 7
        onlineIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(onlineIndicator)
        
        let nameLabel = UILabel()
        nameLabel.text = "Aaditya Naidu"
        nameLabel.textColor = .white
        nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        
        let roleLabel = UILabel()
        roleLabel.text = "Movie Enthusiast"
        roleLabel.textColor = .lightGray
        roleLabel.font = UIFont.systemFont(ofSize: 14)
        roleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(roleLabel)
        
        let usernameLabel = createInfoLabel(icon: "person.circle", text: "Aaditya Naidu")
        let contactLabel = createInfoLabel(icon: "phone.circle", text: "+2450000000")
        let emailLabel = createInfoLabel(icon: "envelope.circle", text: "mjdesigner@gmail.com")
        
        view.addSubview(usernameLabel)
        view.addSubview(contactLabel)
        view.addSubview(emailLabel)
        
        // Watchlist Section
        let watchlistLabel = createSectionHeader(title: "Watchlist")
        view.addSubview(watchlistLabel)
        
        watchlistCollectionView = createCollectionView()
        view.addSubview(watchlistCollectionView)
        
        // Favourites Section
        let favouritesLabel = createSectionHeader(title: "My Favourites")
        view.addSubview(favouritesLabel)
        
        favouritesCollectionView = createCollectionView()
        view.addSubview(favouritesCollectionView)
        
        // Constraints
        NSLayoutConstraint.activate([
            // Profile Section
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            profileImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 165),
            profileImageView.widthAnchor.constraint(equalToConstant: 80),
            profileImageView.heightAnchor.constraint(equalToConstant: 80),
            
            onlineIndicator.trailingAnchor.constraint(equalTo: profileImageView.trailingAnchor),
            onlineIndicator.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor),
            onlineIndicator.widthAnchor.constraint(equalToConstant: 14),
            onlineIndicator.heightAnchor.constraint(equalToConstant: 14),
            
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 30),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 145),
            
            roleLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            roleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 150),
            
            
            usernameLabel.topAnchor.constraint(equalTo: roleLabel.bottomAnchor, constant: 30),
            usernameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            
            contactLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 8),
            contactLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
           
            
            emailLabel.topAnchor.constraint(equalTo: contactLabel.bottomAnchor, constant: 8),
            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
           
            
            // Watchlist Section
            watchlistLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 16),
            watchlistLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            watchlistCollectionView.topAnchor.constraint(equalTo: watchlistLabel.bottomAnchor, constant: 8),
            watchlistCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            watchlistCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            watchlistCollectionView.heightAnchor.constraint(equalToConstant: 160),
            
            // Favourites Section
            favouritesLabel.topAnchor.constraint(equalTo: watchlistCollectionView.bottomAnchor, constant: 16),
            favouritesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            favouritesCollectionView.topAnchor.constraint(equalTo: favouritesLabel.bottomAnchor, constant: 8),
            favouritesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            favouritesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            favouritesCollectionView.heightAnchor.constraint(equalToConstant: 160)
        ])
    }
    
    private func createInfoLabel(icon: String, text: String) -> UIStackView {
        let imageView = UIImageView(image: UIImage(systemName: icon))
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.text = text
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        
        let stack = UIStackView(arrangedSubviews: [imageView, label])
        stack.axis = .horizontal
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }
    
    private func createSectionHeader(title: String) -> UILabel {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }
    
    private func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        layout.itemSize = CGSize(width: 120, height: 160)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(WatchlistCell.self, forCellWithReuseIdentifier: "WatchlistCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }
    
    // MARK: - UICollectionView DataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WatchlistCell", for: indexPath) as! WatchlistCell
        let images = collectionView == watchlistCollectionView
            ? ["kraven", "pushpa", "fighter", "topgun", "subha"]
            : ["RRR", "DANGAL", "scifi", "munjya", "laapta"]
        cell.configure(imageName: images[indexPath.item])
        return cell
    }
}

// MARK: - WatchlistCell

class WatchlistCell: UICollectionViewCell {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(imageName: String) {
        imageView.image = UIImage(named: imageName)
    }
}


