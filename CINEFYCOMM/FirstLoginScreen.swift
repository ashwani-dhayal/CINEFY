import UIKit

class FirstLoginScreen: UIViewController {
    private var isLoggedIn: Bool = false
    
    private let logoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let text = NSMutableAttributedString(string: "C", attributes: [
            .foregroundColor: UIColor.red,
            .font: UIFont.systemFont(ofSize: 40, weight: .bold)
        ])
        text.append(NSAttributedString(string: "inefy", attributes: [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 40, weight: .bold)
        ]))
        label.attributedText = text
        return label
    }()
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        
        // Load background image from assets
        if let image = UIImage(named: "login_background") {
            imageView.image = image
        } else {
            // Fallback background color if image is not found
            imageView.backgroundColor = .darkGray
        }
        
        // Add gradient overlay
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.black.withAlphaComponent(0.3).cgColor,
            UIColor.black.withAlphaComponent(0.7).cgColor
        ]
        gradientLayer.locations = [0.0, 1.0]
        imageView.layer.addSublayer(gradientLayer)
        
        // Update gradient on layout
        imageView.layoutSubviews()
        gradientLayer.frame = imageView.bounds
        
        return imageView
    }()
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fill
        return stackView
    }()
    
    private let taglineLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Your Gateway to the Ultimate Movies\nAnytime, Anywhere!"
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 25
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }()
    
    private let appleLoginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Continue with Apple", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.darkGray
        button.layer.cornerRadius = 25
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)
        let appleImage = UIImage(systemName: "apple.logo", withConfiguration: imageConfig)
        button.setImage(appleImage, for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private let googleLoginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Continue with Google", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.darkGray
        button.layer.cornerRadius = 25
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)
        let googleImage = UIImage(systemName: "g.circle", withConfiguration: imageConfig)
        button.setImage(googleImage, for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private let loginContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    private let profileContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        checkLoginStatus()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let gradientLayer = backgroundImageView.layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.frame = backgroundImageView.bounds
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Add container views
        view.addSubview(loginContainerView)
        view.addSubview(profileContainerView)
        
        // Setup login container
        loginContainerView.addSubview(backgroundImageView)
        loginContainerView.addSubview(logoLabel)
        loginContainerView.addSubview(contentStackView)
        
        // Add items to stack view
        contentStackView.addArrangedSubview(taglineLabel)
        contentStackView.addArrangedSubview(loginButton)
        contentStackView.addArrangedSubview(appleLoginButton)
        contentStackView.addArrangedSubview(googleLoginButton)
        
        // Add button targets
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        appleLoginButton.addTarget(self, action: #selector(appleLoginTapped), for: .touchUpInside)
        googleLoginButton.addTarget(self, action: #selector(googleLoginTapped), for: .touchUpInside)
        
        setupProfileContent()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Container views
            loginContainerView.topAnchor.constraint(equalTo: view.topAnchor),
            loginContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loginContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            profileContainerView.topAnchor.constraint(equalTo: view.topAnchor),
            profileContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // Background image
            backgroundImageView.topAnchor.constraint(equalTo: loginContainerView.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: loginContainerView.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: loginContainerView.trailingAnchor),
            backgroundImageView.heightAnchor.constraint(equalTo: loginContainerView.heightAnchor, multiplier: 0.65),
            
            // Logo
            logoLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            logoLabel.centerXAnchor.constraint(equalTo: loginContainerView.centerXAnchor),
            
            // Content stack view
            contentStackView.leadingAnchor.constraint(equalTo: loginContainerView.leadingAnchor, constant: 20),
            contentStackView.trailingAnchor.constraint(equalTo: loginContainerView.trailingAnchor, constant: -20),
            contentStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    private func setupProfileContent() {
        let welcomeLabel = UILabel()
        welcomeLabel.text = "Welcome to your profile!"
        welcomeLabel.textColor = .white
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        profileContainerView.addSubview(welcomeLabel)
        NSLayoutConstraint.activate([
            welcomeLabel.centerXAnchor.constraint(equalTo: profileContainerView.centerXAnchor),
            welcomeLabel.centerYAnchor.constraint(equalTo: profileContainerView.centerYAnchor)
        ])
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Logout",
            style: .plain,
            target: self,
            action: #selector(logoutTapped)
        )
    }
    
    private func checkLoginStatus() {
        loginContainerView.isHidden = isLoggedIn
        profileContainerView.isHidden = !isLoggedIn
        navigationItem.rightBarButtonItem?.isHidden = !isLoggedIn
    }
    
    @objc private func loginTapped() {
        // Instantiate the LoginViewController
        let loginViewController = LoginViewController()
        
        // Push the LoginViewController onto the navigation stack
        navigationController?.pushViewController(loginViewController, animated: true)
    }
    
    @objc private func appleLoginTapped() {
        // Handle Apple sign in
        isLoggedIn = true
        checkLoginStatus()
    }
    
    @objc private func googleLoginTapped() {
        // Handle Google sign in
        isLoggedIn = true
        checkLoginStatus()
    }
    
    @objc private func logoutTapped() {
        isLoggedIn = false
        checkLoginStatus()
    }
}



