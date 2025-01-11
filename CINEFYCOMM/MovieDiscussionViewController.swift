import UIKit


// MARK: - View Controller
class MovieDiscussionViewController: UIViewController {
    // MARK: - Properties
    private var movieDiscussion: MovieDiscussion
    
    // MARK: - UI Components
    private lazy var scrollView: UIScrollView = {
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
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let discussionLabel: UILabel = {
        let label = UILabel()
        label.text = "Trending Discussion"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let discussionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let fanTheoriesLabel: UILabel = {
        let label = UILabel()
        label.text = "Fan Theories"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let fanTheoriesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var opinionTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Give Opinion"
        textField.backgroundColor = UIColor(white: 0.2, alpha: 1.0)
        textField.textColor = .white
        textField.layer.cornerRadius = 8
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
        textField.rightView = sendButton
        textField.rightViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        button.tintColor = .systemBlue
     //   button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initialization
    init(movieDiscussion: MovieDiscussion) {
        self.movieDiscussion = movieDiscussion
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureWithData()
    }
    
    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = .black
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [backButton, titleLabel, posterImageView, discussionLabel,
         discussionStackView, fanTheoriesLabel, fanTheoriesStackView,
         opinionTextField].forEach { contentView.addSubview($0) }
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            backButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            backButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 20),
            
            posterImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterImageView.heightAnchor.constraint(equalToConstant: 200),
            
            discussionLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 20),
            discussionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            discussionStackView.topAnchor.constraint(equalTo: discussionLabel.bottomAnchor, constant: 16),
            discussionStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            discussionStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            fanTheoriesLabel.topAnchor.constraint(equalTo: discussionStackView.bottomAnchor, constant: 20),
            fanTheoriesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            fanTheoriesStackView.topAnchor.constraint(equalTo: fanTheoriesLabel.bottomAnchor, constant: 16),
            fanTheoriesStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            fanTheoriesStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            opinionTextField.topAnchor.constraint(equalTo: fanTheoriesStackView.bottomAnchor, constant: 20),
            opinionTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            opinionTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            opinionTextField.heightAnchor.constraint(equalToConstant: 44),
            opinionTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    private func configureWithData() {
        titleLabel.text = movieDiscussion.movieTitle
        posterImageView.image = UIImage(named: movieDiscussion.posterImage)
        
        // Configure discussions
        movieDiscussion.discussions.forEach { discussion in
            let discussionView = createDiscussionView(with: discussion)
            discussionStackView.addArrangedSubview(discussionView)
        }
        
        // Configure fan theories
        movieDiscussion.fanTheories.forEach { theory in
            let theoryView = createTheoryView(with: theory)
            fanTheoriesStackView.addArrangedSubview(theoryView)
        }
    }
    
    private func createDiscussionView(with discussion: Discussion) -> UIView {
        let container = UIView()
        container.backgroundColor = UIColor(white: 0.15, alpha: 1.0)
        container.layer.cornerRadius = 8
        
        let usernameLabel = UILabel()
        usernameLabel.text = discussion.username
        usernameLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        usernameLabel.textColor = .white
        
        let commentLabel = UILabel()
        commentLabel.text = discussion.comment
        commentLabel.font = .systemFont(ofSize: 14)
        commentLabel.textColor = .white
        commentLabel.numberOfLines = 0
        
        [usernameLabel, commentLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            container.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12),
            usernameLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12),
            
            commentLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 8),
            commentLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12),
            commentLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12),
            commentLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -12)
        ])
        
        return container
    }
    
    private func createTheoryView(with theory: FanTheory) -> UIView {
        let container = UIView()
        container.backgroundColor = UIColor(white: 0.15, alpha: 1.0)
        container.layer.cornerRadius = 8
        
        let theoryLabel = UILabel()
        theoryLabel.text = theory.theory
        theoryLabel.font = .systemFont(ofSize: 14)
        theoryLabel.textColor = .white
        theoryLabel.numberOfLines = 0
        theoryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        container.addSubview(theoryLabel)
        
        NSLayoutConstraint.activate([
            theoryLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 12),
            theoryLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12),
            theoryLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12),
            theoryLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -12)
        ])
        
        return container
    }
    
    // MARK: - Actions
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func sendButtonTapped() {
        guard let opinion = opinionTextField.text, !opinion.isEmpty else { return }
        // Handle sending opinion
        opinionTextField.text = ""
    }
}

// MARK: - Sample Data Creation
extension MovieDiscussionViewController {
    static func createSample() -> UIViewController {
        let sampleData = MovieDiscussion(
            movieTitle: "Alien Romulus",
            posterImage: "alien_romulus",
            discussions: [
                Discussion(username: "@Arijit", comment: "The practical effects and sound design are incredible, but the plot leaves much to be desired."),
                Discussion(username: "@Arihant", comment: "A stunning spectacle with great tension buildup, but the ending will haunt your dreams."),
                Discussion(username: "@Agastya", comment: "This could have been the modern Alien film we needed, but it feels more like corporate fanservice.")
            ],
            fanTheories: [
                FanTheory(theory: "The Romulus project might be bridging Ripley's legacy with Weyland-Yutani's experiments."),
                FanTheory(theory: "What if Romulus is the missing link between the original Alien and Amanda Ripley in Isolation?")
            ]
        )
        
        return MovieDiscussionViewController(movieDiscussion: sampleData)
    }
}
