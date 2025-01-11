import Foundation
import UIKit

struct HomeContent {
    let featuredContent: MovieContent
    let sections: [HomeSection]
}

struct HomeSection {
    let title: String
    let type: HomeSectionType
    let content: [MovieContent]
}

enum HomeSectionType {
    case trending
    case topPicks
    case fanFavorites
    case behindTheScenes
    case bestOfYear
    case topBoxOffice
    case comingSoon
}

struct MovieContent {
    let id: String
    let title: String
    let posterImage: String
    let rating: Double?
    let releaseDate: Date?
    let overview: String?
    var isFeatured: Bool = false
}


class HomeViewController: UIViewController {
    
    private var homeData: HomeContent?
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.showsVerticalScrollIndicator = false
        return sv
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 24
        sv.alignment = .fill
        return sv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        setupNavigationBar()
        setupScrollView()
    }
    
    private func setupNavigationBar() {
        let titleText = "Welcome to Cinefy"
        let attributedTitle = NSMutableAttributedString(string: titleText)
        
        attributedTitle.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: titleText.count))
        
        if let cinefyRange = titleText.range(of: "Cinefy") {
            let nsRange = NSRange(cinefyRange, in: titleText)
            attributedTitle.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: nsRange.location, length: 1))
        }
        
        let titleLabel = UILabel()
        titleLabel.attributedText = attributedTitle
        titleLabel.font = .systemFont(ofSize: 28, weight: .bold)
        navigationItem.titleView = titleLabel
        
        navigationController?.navigationBar.prefersLargeTitles = false
        
        let searchButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(searchTapped))
        
        let notificationButton = UIBarButtonItem(image: UIImage(systemName: "bell"),
                                               style: .plain,
                                               target: self,
                                               action: #selector(notificationTapped))
        
        navigationItem.rightBarButtonItems = [notificationButton, searchButton]
        searchButton.tintColor = .white
        notificationButton.tintColor = .white
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func loadData() {
        let mockData = createMockData()
        self.homeData = mockData
        updateUI(with: mockData)
    }
    
    private func updateUI(with data: HomeContent) {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        let featuredSection = createFeaturedSection(with: data.featuredContent)
        stackView.addArrangedSubview(featuredSection)
        
        data.sections.forEach { section in
            addSection(section)
        }
    }
    
    private func createFeaturedSection(with content: MovieContent) -> UIView {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.image = UIImage(named: content.posterImage)
        
        let titleLabel = UILabel()
        titleLabel.text = content.title
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let ratingLabel = UILabel()
        if let rating = content.rating {
            ratingLabel.text = String(format: "%.1f ★", rating)
        }
        ratingLabel.textColor = .white
        ratingLabel.font = .systemFont(ofSize: 16, weight: .medium)
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(imageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(ratingLabel)
        
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: 400),
            
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 16),
            titleLabel.bottomAnchor.constraint(equalTo: ratingLabel.topAnchor, constant: -8),
            
            ratingLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 16),
            ratingLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -16)
        ])
        
        // Add tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(featuredMovieTapped))
        containerView.addGestureRecognizer(tapGesture)
        containerView.isUserInteractionEnabled = true
        
        return containerView
    }
    
    @objc private func featuredMovieTapped() {
        if let featuredContent = homeData?.featuredContent,
           featuredContent.title == "Stree 2" {
            let detailVC = MovieDetailViewController()
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    private func addSection(_ section: HomeSection) {
        let sectionView = HomeSectionView(section: section)
        stackView.addArrangedSubview(sectionView)
    }
    
    @objc private func searchTapped() {
        
    }
    
    @objc private func notificationTapped() {
       
    }
    
    private func createMockData() -> HomeContent {
        let featuredContent = MovieContent(
            id: "1",
            title: "Stree 2",
            posterImage: "stree2",
            rating: 9.5,
            releaseDate: Date(),
            overview: "After thirty years, Maverick is still pushing the envelope as a top naval aviator.",
            isFeatured: true
        )
        
        let sections = [
            HomeSection(
                title: "Trending Trailers",
                type: .trending,
                content: [
                    MovieContent(id: "2", title: "Kill", posterImage: "kill", rating: 8.5, releaseDate: Date(), overview: nil),
                    MovieContent(id: "3", title: "Devara", posterImage: "devara", rating: 8.0, releaseDate: Date(), overview: nil),
                    MovieContent(id: "4", title: "Emergency", posterImage: "emergency", rating: 8.7, releaseDate: Date(), overview: nil),
                    MovieContent(id: "5", title: "Jigra", posterImage: "jigra", rating: 9.2, releaseDate: Date(), overview: nil)
                ]
            ),
            // ... rest of your sections remain the same
            HomeSection(
                title: "Top Picks for you",
                type: .topPicks,
                content: [
                    MovieContent(id: "6", title: "Fighter", posterImage: "fighter", rating: 8.3, releaseDate: Date(), overview: nil),
                    MovieContent(id: "7", title: "Singham Again", posterImage: "singham", rating: 8.4, releaseDate: Date(), overview: nil),
                    MovieContent(id: "8", title: "Do Aur do Pyaar", posterImage: "dodo", rating: 8.9, releaseDate: Date(), overview: nil)
                ]
            ),
            HomeSection(
                title: "Fan Favourite",
                type: .fanFavorites,
                content: [
                    MovieContent(id: "11", title: "Stree 2", posterImage: "2", rating: 9.1, releaseDate: Date(), overview: nil),
                    MovieContent(id: "9", title: "Laapta Ladies", posterImage: "laapta", rating: 9.3, releaseDate: Date(), overview: nil),
                    MovieContent(id: "10", title: "The diary of West Bengal", posterImage: "west", rating: 9.1, releaseDate: Date(), overview: nil),
                    MovieContent(id: "11", title: "Munjya", posterImage: "munjya", rating: 9.1, releaseDate: Date(), overview: nil)
                ]
            ),
            HomeSection(
                title: "Behind the Scenes",
                type: .behindTheScenes,
                content: [
                    MovieContent(id: "9", title: "a", posterImage: "a", rating: 9.3, releaseDate: Date(), overview: nil),
                    MovieContent(id: "10", title: "b", posterImage: "b", rating: 9.1, releaseDate: Date(), overview: nil),
                    MovieContent(id: "11", title: "c", posterImage: "c", rating: 9.1, releaseDate: Date(), overview: nil),
                    MovieContent(id: "12", title: "d", posterImage: "d", rating: 9.1, releaseDate: Date(), overview: nil),
                ]
            ),
            HomeSection(
                title: "Best of this Year",
                type: .bestOfYear,
                content: [
                    MovieContent(id: "10", title: "Madgaon Express", posterImage: "madgav", rating: 9.3, releaseDate: Date(), overview: nil),
                    MovieContent(id: "11", title: "Stree 2", posterImage: "2", rating: 9.1, releaseDate: Date(), overview: nil),
                    MovieContent(id: "12", title: "Ghuchadi", posterImage: "ghud", rating: 9.1, releaseDate: Date(), overview: nil),
                    MovieContent(id: "13", title: "Atal", posterImage: "atal", rating: 9.1, releaseDate: Date(), overview: nil),
                ]
            ),
            HomeSection(
                title: "Top Box Office",
                type: .topBoxOffice,
                content: [
                    MovieContent(id: "14", title: "RRR", posterImage: "RRR", rating: 9.3, releaseDate: Date(), overview: nil),
                    MovieContent(id: "15", title: "VEER", posterImage: "VEER", rating: 9.1, releaseDate: Date(), overview: nil),
                    MovieContent(id: "16", title: "YODHA", posterImage: "YODHA", rating: 9.1, releaseDate: Date(), overview: nil),
                    MovieContent(id: "17", title: "DANGAL", posterImage: "DANGAL", rating: 9.1, releaseDate: Date(), overview: nil),
                ]
            ),
            HomeSection(
                title: "Coming Soon",
                type: .comingSoon,
                content: [
                    MovieContent(id: "18", title: "Kraven", posterImage: "kraven", rating: nil, releaseDate: Date(), overview: nil),
                    MovieContent(id: "19", title: "Subha", posterImage: "subha", rating: nil, releaseDate: Date(), overview: nil),
                    MovieContent(id: "20", title: "Pushpa", posterImage: "pushpa", rating: nil, releaseDate: Date(), overview: nil),
                    MovieContent(id: "21", title: "Ramayana", posterImage: "ramayana", rating: nil, releaseDate: Date(), overview: nil)
                ]
            )
        ]
        
        return HomeContent(featuredContent: featuredContent, sections: sections)
    }
}

class HomeSectionView: UIView {
    private let section: HomeSection
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    init(section: HomeSection) {
        self.section = section
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(titleLabel)
        addSubview(collectionView)
        
        titleLabel.text = section.title
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HomeContentCell.self, forCellWithReuseIdentifier: "HomeContentCell")
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}

extension HomeSectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.section.content.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeContentCell", for: indexPath) as! HomeContentCell
        let content = self.section.content[indexPath.item]
        cell.configure(with: content)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if section.type == .trending {
            return CGSize(width: 370, height: 200)
        }
        return CGSize(width: 140, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // For now, do nothing when tapping other movies
        // You can implement different behavior for other movies here
    }
}

class HomeContentCell: UICollectionViewCell {
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 8
        iv.translatesAutoresizingMaskIntoConstraints = false
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
    
    func configure(with content: MovieContent) {
        imageView.image = UIImage(named: content.posterImage)
    }
}
