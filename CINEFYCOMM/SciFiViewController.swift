

import UIKit

class SciFiViewController: UIViewController {
    private var trendingMovies: [Movie] = []
    private var polls: [MoviePoll] = []
    private var searchResults: [Movie] = []
    private var isSearching: Bool = false
    
    // MARK: - UI Components
    private lazy var backButton: UIButton = {
        let button = UIButton()
        
        // Create container stack view for icon and text
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        
        // Configure icon image view
        let imageView = UIImageView(image: UIImage(systemName: "chevron.left"))
        imageView.tintColor = .systemBlue
        imageView.contentMode = .scaleAspectFit
        
        // Configure text label
        let label = UILabel()
        label.text = "Back"
        label.textColor = .systemBlue
        label.font = .systemFont(ofSize: 17)
        
        // Add icon and text to stack view
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
        
        // Add stack view to button
        button.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: button.centerYAnchor)
        ])
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Scifi"
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search your movie"
        searchBar.searchBarStyle = .minimal
        searchBar.backgroundColor = UIColor(white: 0.2, alpha: 1.0)
        searchBar.barTintColor = UIColor(white: 0.2, alpha: 1.0)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.showsCancelButton = true // Add this line
        
        let searchImage = UIImage(systemName: "magnifyingglass.circle")
        searchBar.setImage(searchImage, for: .search, state: .normal)
        
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.textColor = .white
            textField.backgroundColor = UIColor(white: 0.2, alpha: 1.0)
            textField.attributedPlaceholder = NSAttributedString(
                string: "Search your movie",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
            )
        }
        searchBar.delegate = self
        return searchBar
    }()
    

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
    
    private let trendingLabel: UILabel = {
        let label = UILabel()
        label.text = "Trending Movie Discussion"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var trendingCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 0
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
        cv.showsHorizontalScrollIndicator = false
        cv.register(MoviePosterCell.self, forCellWithReuseIdentifier: MoviePosterCell.identifier)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    private let pollingLabel: UILabel = {
        let label = UILabel()
        label.text = "Polling"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var pollCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 0
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
        cv.showsHorizontalScrollIndicator = false
        cv.register(PollCell.self, forCellWithReuseIdentifier: PollCell.identifier)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    private lazy var searchResultsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
        cv.isHidden = true
        cv.showsVerticalScrollIndicator = false
        cv.register(MoviePosterCell.self, forCellWithReuseIdentifier: MoviePosterCell.identifier)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
    
    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = .black
        
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(searchBar)
        view.addSubview(scrollView)
        view.addSubview(searchResultsCollectionView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(trendingLabel)
        contentView.addSubview(trendingCollectionView)
        contentView.addSubview(pollingLabel)
        contentView.addSubview(pollCollectionView)
        
        // Constant for consistent padding
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            backButton.heightAnchor.constraint(equalToConstant: 44),
            
            titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: padding),
            
            searchBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            scrollView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            searchResultsCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: padding),
            searchResultsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            searchResultsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            searchResultsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            trendingLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            trendingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            
            trendingCollectionView.topAnchor.constraint(equalTo: trendingLabel.bottomAnchor, constant: padding),
            trendingCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            trendingCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            trendingCollectionView.heightAnchor.constraint(equalToConstant: 200),
            
            pollingLabel.topAnchor.constraint(equalTo: trendingCollectionView.bottomAnchor, constant: padding),
            pollingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            
            pollCollectionView.topAnchor.constraint(equalTo: pollingLabel.bottomAnchor, constant: padding),
            pollCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            pollCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            pollCollectionView.heightAnchor.constraint(equalToConstant: 200),
            pollCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
        ])
    }
    
    private func loadData() {
        // Sample data
        trendingMovies = [
            Movie(id: 1, title: "Alien: Romulus", posterImage: "alien_romulus", hasDiscussion: true),
            Movie(id: 2, title: "Dune: Part Two", posterImage: "dune2", hasDiscussion: false),
            Movie(id: 3, title: "A Quiet Place One Day", posterImage: "quietplace", hasDiscussion: false),
            Movie(id: 4, title: "Avatar 3", posterImage: "avatar5", hasDiscussion: false)
        ]
        
        polls = [
            MoviePoll(question: "Best Scifi Movie of 2024?",
                     options: [
                        PollOption(movieTitle: "Avengers: Multiverse Saga", votePercentage: 70),
                        PollOption(movieTitle: "Batman: Gotham Nights", votePercentage: 30)
                     ])
        ]
        
        // Add sample Marvel movies for search
        searchResults = [
            Movie(id: 1, title: "Iron Man", posterImage: "ironman", hasDiscussion: false),
            Movie(id: 2, title: "Thor: Love and Thunder", posterImage: "thor", hasDiscussion: false),
            Movie(id: 3, title: "The Incredible Hulk", posterImage: "hulk", hasDiscussion: false)
        ]
        
        trendingCollectionView.reloadData()
        searchResultsCollectionView.reloadData()
        pollCollectionView.reloadData()
    }
    /*
    private func loadData() {
        // Sample data including both trending and Marvel movies
        trendingMovies = [
            Movie(id: 1, title: "Alien: Romulus", posterImage: "alien_romulus", hasDiscussion: true),
            Movie(id: 2, title: "Dune: Part Two", posterImage: "dune2", hasDiscussion: false),
            Movie(id: 3, title: "A Quiet Place One Day", posterImage: "quietplace", hasDiscussion: false),
            Movie(id: 4, title: "Avatar 3", posterImage: "avatar5", hasDiscussion: false),
            Movie(id: 5, title: "Iron Man", posterImage: "ironman", hasDiscussion: true),
            Movie(id: 6, title: "Thor: Love and Thunder", posterImage: "thor", hasDiscussion: true),
            Movie(id: 7, title: "The Incredible Hulk", posterImage: "hulk", hasDiscussion: true)
        ]
        
        polls = [
            MoviePoll(question: "Best Scifi Movie of 2024?",
                     options: [
                        PollOption(movieTitle: "Avengers: Multiverse Saga", votePercentage: 70),
                        PollOption(movieTitle: "Batman: Gotham Nights", votePercentage: 30)
                     ])
        ]
        
        trendingCollectionView.reloadData()
        pollCollectionView.reloadData()
    } */
    
    private func updateUIForSearchState() {
        UIView.animate(withDuration: 0.3) {
            self.scrollView.isHidden = self.isSearching
            self.searchResultsCollectionView.isHidden = !self.isSearching
        }
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UICollectionViewDelegate & DataSource
extension SciFiViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView === searchResultsCollectionView {
            return isSearching ? searchResults.count : 0
        } else if collectionView === trendingCollectionView {
            return trendingMovies.count
        } else {
            return polls.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView === searchResultsCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviePosterCell.identifier, for: indexPath) as? MoviePosterCell else {
                return UICollectionViewCell()
            }
            let movie = searchResults[indexPath.item]
            cell.configure(with: movie)
            cell.onTap = { [weak self] in
                if movie.hasDiscussion {
                    let discussionVC = MovieDiscussionViewController.createSample()
                    self?.navigationController?.pushViewController(discussionVC, animated: true)
                }
            }
            return cell
        } else if collectionView === trendingCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviePosterCell.identifier, for: indexPath) as? MoviePosterCell else {
                return UICollectionViewCell()
            }
            let movie = trendingMovies[indexPath.item]
            cell.configure(with: movie)
            cell.onTap = { [weak self] in
                if movie.hasDiscussion {
                    let discussionVC = MovieDiscussionViewController.createSample()
                    self?.navigationController?.pushViewController(discussionVC, animated: true)
                }
            }
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PollCell.identifier, for: indexPath) as? PollCell else {
                return UICollectionViewCell()
            }
            let poll = polls[indexPath.item]
            cell.configure(with: poll)
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
//extension SciFiViewController: UICollection
extension SciFiViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.bounds.width - 32  // Full width minus padding
        if collectionView === trendingCollectionView {
            return CGSize(width: width, height: 200)
        } else {
            return CGSize(width: width, height: 200)
        }
    }
}

// MARK: - UISearchBarDelegate
extension SciFiViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearching = false
        } else {
            isSearching = true
            // Filter movies based on search text
            searchResults = searchResults.filter { movie in
                movie.title.lowercased().contains(searchText.lowercased())
            }
        }
        
        // Update the UI
        updateUIForSearchState()
        searchResultsCollectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        isSearching = false
        updateUIForSearchState()
        searchResultsCollectionView.reloadData()
        searchBar.resignFirstResponder()
    }
}



// MARK: - Updated Cell
class MoviePosterCell: UICollectionViewCell {
    static let identifier = "MoviePosterCell"
    
    var onTap: (() -> Void)?
    
    private let posterImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 12
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
        contentView.addSubview(posterImageView)
        
        // Add tap gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        contentView.addGestureRecognizer(tapGesture)
        contentView.isUserInteractionEnabled = true
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    @objc private func cellTapped() {
        onTap?()
    }
    
    func configure(with movie: Movie) {
        posterImageView.image = UIImage(named: movie.posterImage)
    }
}


// MARK: - Poll Cell
class PollCell: UICollectionViewCell {
    static let identifier = "PollCell"
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 12
        sv.distribution = .fillEqually
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = UIColor(white: 0.15, alpha: 1.0)
        contentView.layer.cornerRadius = 12
        
        contentView.addSubview(questionLabel)
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            questionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            questionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            stackView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    func configure(with poll: MoviePoll) {
        // Clear existing option views
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        questionLabel.text = poll.question
        
        // Add option views
        for option in poll.options {
            let optionView = PollOptionView(option: option)
            stackView.addArrangedSubview(optionView)
        }
    }
}

// MARK: - Poll Option View
class PollOptionView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let percentageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let progressView: UIProgressView = {
        let pv = UIProgressView(progressViewStyle: .default)
        pv.progressTintColor = .systemBlue
        pv.trackTintColor = UIColor(white: 0.3, alpha: 1.0)
        pv.layer.cornerRadius = 2
        pv.clipsToBounds = true
        pv.translatesAutoresizingMaskIntoConstraints = false
        return pv
    }()
    
    init(option: PollOption) {
        super.init(frame: .zero)
        setupUI()
        configure(with: option)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(titleLabel)
        addSubview(percentageLabel)
        addSubview(progressView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            percentageLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            percentageLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            progressView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            progressView.leadingAnchor.constraint(equalTo: leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: trailingAnchor),
            progressView.bottomAnchor.constraint(equalTo: bottomAnchor),
            progressView.heightAnchor.constraint(equalToConstant: 4)
        ])
    }
    
    private func configure(with option: PollOption) {
        titleLabel.text = option.movieTitle
        percentageLabel.text = "\(option.votePercentage)%"
        progressView.progress = Float(option.votePercentage) / 100.0
    }
}



