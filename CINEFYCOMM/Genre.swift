
import UIKit

class GenreDataSource {
    static let shared = GenreDataSource()
    
    var genres: [Genre] = [
        Genre(id: 1, name: "Scific", image: "scifi_genre"),
        Genre(id: 2, name: "Horror", image: "horror_genre"),
        Genre(id: 3, name: "Thriller", image: "thriller_genre"),
        Genre(id: 4, name: "Mystery", image: "mystery_genre"),
        Genre(id: 5, name: "Drama", image: "drama_genre"),
        Genre(id: 6, name: "Action", image: "action_genre"),
        Genre(id: 7, name: "Comedy", image: "comedy_genre")
    ]
}

// GenreCell.swift
class GenreCell: UICollectionViewCell {
    static let identifier = "GenreCell"
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3) // Semi-transparent overlay
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 24, weight: .bold) // Made font bigger
        label.textAlignment = .center // Center text alignment
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
        backgroundColor = .black
        layer.cornerRadius = 12
        clipsToBounds = true
        
        // Add views in order: image, overlay, then label
        contentView.addSubview(imageView)
        contentView.addSubview(overlayView)
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            // Image view constraints
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            // Overlay view constraints (covers entire cell)
            overlayView.topAnchor.constraint(equalTo: contentView.topAnchor),
            overlayView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            overlayView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            // Center label horizontally and vertically
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    func configure(with genre: Genre) {
        titleLabel.text = genre.name
        imageView.image = UIImage(named: genre.image)
        // Add subtle animation when cell is configured
        titleLabel.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        UIView.animate(withDuration: 0.3) {
            self.titleLabel.transform = .identity
        }
    }
}
