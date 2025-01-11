import UIKit
class MovieDetailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var scrollView: UIScrollView!
    var contentView: UIView!
    var movieImageView: UIImageView!
    var movieTitleLabel: UILabel!
    var movieInfoLabel: UILabel!
    var genreLabel: UILabel!
    var ratingLabel: UILabel!
    var starImageView: UIImageView!
    var favouriteLabel: UILabel!
    var descriptionLabel: UILabel!
    var addToWatchListButton: UIButton!
    var viewMovieUniverseButton: UIButton!

    var carouselCollectionView: UICollectionView!
    var carouselData: [String] = ["", "", "", ""] // Single carousel with 4 items
    
    var secondCarouselCollectionView: UICollectionView!
    var secondCarouselData: [String] = ["", "", "", ""]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initialize the UIScrollView
        scrollView = UIScrollView()
        scrollView.frame = self.view.bounds
        self.view.addSubview(scrollView)
        
        // Create a content view to hold all the elements
        contentView = UIView()
        contentView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 0) // Initial height 0
        scrollView.addSubview(contentView)

        // Enable scrolling
        scrollView.contentSize = contentView.frame.size

        // Initialize the UIImageView and set its properties
        movieImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 400))
        movieImageView.contentMode = .scaleAspectFill
        movieImageView.clipsToBounds = true
        if let image = UIImage(named: "stree22") {
            movieImageView.image = image
        }
        contentView.addSubview(movieImageView)

        // Initialize the UILabel for the movie title
        movieTitleLabel = UILabel()
        movieTitleLabel.text = "Stree 2"
        movieTitleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        movieTitleLabel.textAlignment = .left
        movieTitleLabel.textColor = .white
        movieTitleLabel.numberOfLines = 1
        movieTitleLabel.frame = CGRect(x: 0, y: movieImageView.frame.maxY + 10, width: self.view.frame.width, height: 40)
        contentView.addSubview(movieTitleLabel)

        // Initialize the UILabel for the movie info
        movieInfoLabel = UILabel()
        movieInfoLabel.text = "2022 • 2h 10m • U/A"
        movieInfoLabel.font = UIFont.systemFont(ofSize: 16)
        movieInfoLabel.textAlignment = .left
        movieInfoLabel.textColor = .gray
        movieInfoLabel.numberOfLines = 1
        movieInfoLabel.frame = CGRect(x: 0, y: movieTitleLabel.frame.maxY + 10, width: self.view.frame.width, height: 30)
        contentView.addSubview(movieInfoLabel)

        // Initialize the UILabel for the genre info
        genreLabel = UILabel()
        genreLabel.text = "Action • Epic • Epic Drama"
        genreLabel.font = UIFont.systemFont(ofSize: 16)
        genreLabel.textAlignment = .left
        genreLabel.textColor = .white
        genreLabel.numberOfLines = 1
        genreLabel.frame = CGRect(x: 0, y: movieInfoLabel.frame.maxY + 10, width: self.view.frame.width, height: 30)
        contentView.addSubview(genreLabel)

        // Initialize the UILabel for the rating
        ratingLabel = UILabel()
        ratingLabel.text = "9.5"
        ratingLabel.font = UIFont.boldSystemFont(ofSize: 30)
        ratingLabel.textAlignment = .left
        ratingLabel.textColor = .yellow
        ratingLabel.frame = CGRect(x: 0, y: genreLabel.frame.maxY + 10, width: 50, height: 40)
        contentView.addSubview(ratingLabel)

        // Initialize the UIImageView for the star icon using SF Symbol
        if let starImage = UIImage(systemName: "star.fill") {
            starImageView = UIImageView(image: starImage)
            starImageView.frame = CGRect(x: ratingLabel.frame.maxX + 10, y: genreLabel.frame.maxY + 10, width: 30, height: 30)
            starImageView.contentMode = .scaleAspectFit
            starImageView.tintColor = .yellow
            contentView.addSubview(starImageView)
        }

        // Initialize the UILabel for "Favourite"
        favouriteLabel = UILabel()
        favouriteLabel.text = "Favourite"
        favouriteLabel.font = UIFont.systemFont(ofSize: 16)
        favouriteLabel.textAlignment = .right
        favouriteLabel.textColor = .white
        favouriteLabel.frame = CGRect(x: self.view.frame.width - 110, y: genreLabel.frame.maxY + 10, width: 100, height: 30)
        contentView.addSubview(favouriteLabel)

        // Initialize the UILabel for the movie description paragraph
        descriptionLabel = UILabel()
        descriptionLabel.text = """
            *Stree 2* is a sequel to the 2018 horror-comedy *Stree*, where the town of Chanderi faces a new supernatural threat. The story follows a group of locals, including the original heroes, as they try to uncover the mystery behind the return of the vengeful spirit.
        """
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.textColor = .gray
        descriptionLabel.numberOfLines = 0
        descriptionLabel.frame = CGRect(x: 20, y: favouriteLabel.frame.maxY + 10, width: self.view.frame.width - 40, height: 120)
        contentView.addSubview(descriptionLabel)

        // Initialize the UIButton for "Add to WatchList"
        addToWatchListButton = UIButton(type: .system)
        addToWatchListButton.setTitle("Add to WatchList", for: .normal)
        addToWatchListButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        addToWatchListButton.frame = CGRect(x: (self.view.frame.width - 370) / 2, y: descriptionLabel.frame.maxY + 20, width: 370, height: 40)
        addToWatchListButton.backgroundColor = .gray
        addToWatchListButton.setTitleColor(.white, for: .normal)
        addToWatchListButton.layer.cornerRadius = 8
        addToWatchListButton.addTarget(self, action: #selector(addToWatchListTapped), for: .touchUpInside)
        contentView.addSubview(addToWatchListButton)

        // Initialize the UIButton for "View Movie Universe"
        viewMovieUniverseButton = UIButton(type: .system)
        viewMovieUniverseButton.setTitle("View Movie Universe", for: .normal)
        viewMovieUniverseButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        viewMovieUniverseButton.frame = CGRect(x: (self.view.frame.width - 370) / 2, y: addToWatchListButton.frame.maxY + 20, width: 370, height: 40)
        viewMovieUniverseButton.backgroundColor = .red
        viewMovieUniverseButton.setTitleColor(.white, for: .normal)
        viewMovieUniverseButton.layer.cornerRadius = 8
        viewMovieUniverseButton.addTarget(self, action: #selector(viewMovieUniverseTapped), for: .touchUpInside)
        contentView.addSubview(viewMovieUniverseButton)

        // Add the first carousel collection view below the red button
            let castTitleLabel = UILabel()
            castTitleLabel.text = "Cast"
            castTitleLabel.font = UIFont.boldSystemFont(ofSize: 24)
            castTitleLabel.textAlignment = .left
            castTitleLabel.textColor = .white
            castTitleLabel.frame = CGRect(x: 20, y: viewMovieUniverseButton.frame.maxY + 20, width: self.view.frame.width - 40, height: 40)
            contentView.addSubview(castTitleLabel)

            // Add the first carousel collection view below the "Cast" label
            let carouselFlowLayout = UICollectionViewFlowLayout()
            carouselFlowLayout.scrollDirection = .horizontal
            carouselCollectionView = UICollectionView(frame: CGRect(x: 0, y: castTitleLabel.frame.maxY + 10, width: self.view.frame.width, height: 200), collectionViewLayout: carouselFlowLayout)
            carouselCollectionView.dataSource = self
            carouselCollectionView.delegate = self
            carouselCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "carouselCell")
            carouselCollectionView.backgroundColor = .clear
            contentView.addSubview(carouselCollectionView)
        // Initialize the UILabel for "More Like This"
        let moreLikeThisLabel = UILabel()
        moreLikeThisLabel.text = "More Like This"
        moreLikeThisLabel.font = UIFont.boldSystemFont(ofSize: 24)
        moreLikeThisLabel.textAlignment = .left
        moreLikeThisLabel.textColor = .white
        moreLikeThisLabel.frame = CGRect(x: 20, y: carouselCollectionView.frame.maxY + 20, width: self.view.frame.width - 40, height: 30)
        contentView.addSubview(moreLikeThisLabel)

        // Add the second carousel collection view below the "More Like This" label
        secondCarouselCollectionView = UICollectionView(frame: CGRect(x: 0, y: moreLikeThisLabel.frame.maxY + 10, width: self.view.frame.width, height: 200), collectionViewLayout: carouselFlowLayout)
        secondCarouselCollectionView.dataSource = self
        secondCarouselCollectionView.delegate = self
        secondCarouselCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "secondCarouselCell")
        secondCarouselCollectionView.backgroundColor = .clear
        contentView.addSubview(secondCarouselCollectionView)

        // Calculate total height and update contentSize
        let totalHeight = secondCarouselCollectionView.frame.maxY + 20
        contentView.frame.size.height = totalHeight
        scrollView.contentSize = contentView.frame.size

        // Optionally, set the background color
        self.view.backgroundColor = .black
    }


    // Action for the "Add to WatchList" button
    @objc func addToWatchListTapped() {
        print("Added to WatchList")
    }

    // Action for the "View Movie Universe" button
    @objc func viewMovieUniverseTapped() {
        let universeVC = UniverseContentViewController()
        navigationController?.pushViewController(universeVC, animated: true)
    }
   

    // MARK: - UICollectionView DataSource and Delegate

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == carouselCollectionView {
            return carouselData.count
        } else if collectionView == secondCarouselCollectionView {
            return secondCarouselData.count
        }
        return 0
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    // Image array for carousel items
    var carouselImages: [String] = ["artist_hrithik","artist_salman","artist_katrina","artist_ranbir" ] // Replace with your image names from assets
    var secondCarouselImages: [String] = ["artist_tom", "glen", "jenni", "kill"] // Replace with second carousel images

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell
        if collectionView == carouselCollectionView {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "carouselCell", for: indexPath)
            configureCell(cell, withImageName: carouselImages[indexPath.item])
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "secondCarouselCell", for: indexPath)
            configureCell(cell, withImageName: secondCarouselImages[indexPath.item])
        }
        return cell
    }
    func configureCell(_ cell: UICollectionViewCell, withImageName imageName: String) {
        let boxView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 150))
        boxView.backgroundColor = .gray
        boxView.layer.cornerRadius = 8
        boxView.clipsToBounds = true
        let imageView = UIImageView(frame: boxView.bounds)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        if let image = UIImage(named: imageName) {
            imageView.image = image
        }
        boxView.addSubview(imageView)
        cell.contentView.addSubview(boxView)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 150)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
