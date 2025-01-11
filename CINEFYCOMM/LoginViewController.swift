import UIKit

class LoginViewController: UIViewController {
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
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .systemBlue
        return button
    }()
    
    private let emailContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.3)
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter Email Address"
        textField.textColor = .white
        textField.backgroundColor = .clear
        textField.autocapitalizationType = .none
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
        return textField
    }()
    
    private let emailIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "envelope.fill")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let passwordContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.3)
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter Password"
        textField.textColor = .white
        textField.backgroundColor = .clear
        textField.isSecureTextEntry = true
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
        return textField
    }()
    
    private let passwordIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "lock.fill")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let rememberMeStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        return stack
    }()
    
    private let rememberMeCheckbox: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "square"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private let rememberMeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Remember me"
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 25
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        return button
    }()
    
    private let createAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("New User? Create Account", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        return button
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        return view
    }()
    
    private let socialLoginStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()
    
    private let appleLoginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Continue with Apple", for: .normal)
        button.setImage(UIImage(systemName: "apple.logo"), for: .normal)
        button.backgroundColor = UIColor.darkGray.withAlphaComponent(0.3)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 25
        button.titleLabel?.font = .systemFont(ofSize: 16)
        return button
    }()
    
    private let googleLoginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Continue with Google", for: .normal)
        button.setImage(UIImage(systemName: "g.circle.fill"), for: .normal)
        button.backgroundColor = UIColor.darkGray.withAlphaComponent(0.3)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 25
        button.titleLabel?.font = .systemFont(ofSize: 16)
       // button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 8)
        return button
    }()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupActions()
    }
    
    // MARK: - Setup Methods
    private func setupUI() {
        view.backgroundColor = .black
        
        // Add subviews
        view.addSubview(backButton)
        view.addSubview(logoLabel)
        view.addSubview(emailContainer)
        emailContainer.addSubview(emailTextField)
        emailContainer.addSubview(emailIcon)
        view.addSubview(passwordContainer)
        passwordContainer.addSubview(passwordTextField)
        passwordContainer.addSubview(passwordIcon)
        
        rememberMeStack.addArrangedSubview(rememberMeCheckbox)
        rememberMeStack.addArrangedSubview(rememberMeLabel)
        view.addSubview(rememberMeStack)
        
        view.addSubview(loginButton)
        view.addSubview(createAccountButton)
        view.addSubview(separatorView)
        
        socialLoginStack.addArrangedSubview(appleLoginButton)
        socialLoginStack.addArrangedSubview(googleLoginButton)
        view.addSubview(socialLoginStack)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            backButton.widthAnchor.constraint(equalToConstant: 44),
            backButton.heightAnchor.constraint(equalToConstant: 44),
            
            logoLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            logoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            emailContainer.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 40),
            emailContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailContainer.heightAnchor.constraint(equalToConstant: 50),
            
            emailTextField.leadingAnchor.constraint(equalTo: emailContainer.leadingAnchor, constant: 40),
            emailTextField.trailingAnchor.constraint(equalTo: emailContainer.trailingAnchor, constant: -16),
            emailTextField.centerYAnchor.constraint(equalTo: emailContainer.centerYAnchor),
            
            emailIcon.leadingAnchor.constraint(equalTo: emailContainer.leadingAnchor, constant: 16),
            emailIcon.centerYAnchor.constraint(equalTo: emailContainer.centerYAnchor),
            emailIcon.widthAnchor.constraint(equalToConstant: 20),
            emailIcon.heightAnchor.constraint(equalToConstant: 20),
            
            passwordContainer.topAnchor.constraint(equalTo: emailContainer.bottomAnchor, constant: 16),
            passwordContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordContainer.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextField.leadingAnchor.constraint(equalTo: passwordContainer.leadingAnchor, constant: 40),
            passwordTextField.trailingAnchor.constraint(equalTo: passwordContainer.trailingAnchor, constant: -16),
            passwordTextField.centerYAnchor.constraint(equalTo: passwordContainer.centerYAnchor),
            
            passwordIcon.leadingAnchor.constraint(equalTo: passwordContainer.leadingAnchor, constant: 16),
            passwordIcon.centerYAnchor.constraint(equalTo: passwordContainer.centerYAnchor),
            passwordIcon.widthAnchor.constraint(equalToConstant: 20),
            passwordIcon.heightAnchor.constraint(equalToConstant: 20),
            
            rememberMeStack.topAnchor.constraint(equalTo: passwordContainer.bottomAnchor, constant: 16),
            rememberMeStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            rememberMeCheckbox.widthAnchor.constraint(equalToConstant: 24),
            rememberMeCheckbox.heightAnchor.constraint(equalToConstant: 24),
            
            loginButton.topAnchor.constraint(equalTo: rememberMeStack.bottomAnchor, constant: 24),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            createAccountButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 16),
            createAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            separatorView.topAnchor.constraint(equalTo: createAccountButton.bottomAnchor, constant: 24),
            separatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            separatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            
            socialLoginStack.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 24),
            socialLoginStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            socialLoginStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            appleLoginButton.heightAnchor.constraint(equalToConstant: 50),
            googleLoginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupActions() {
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(createAccountTapped), for: .touchUpInside)
        rememberMeCheckbox.addTarget(self, action: #selector(rememberMeTapped), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
    }
    
    @objc private func loginTapped() {
        // Validate inputs
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            // Show alert for empty fields
            let alert = UIAlertController(title: "Error", message: "Please enter both email and password.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        
        // Perform login and navigate to MainTabBarController
        let mainTabBarController = MovieGenreSelectionViewController()
        mainTabBarController.modalPresentationStyle = .fullScreen
        present(mainTabBarController, animated: true)
    }

    
    @objc private func createAccountTapped() {
        // Create an instance of the CreateAccountViewController
        let createAccountVC = SignupViewController() // Assume you have this view controller created
        createAccountVC.modalPresentationStyle = .fullScreen
        present(createAccountVC, animated: true, completion: nil)
    }

    
    @objc private func rememberMeTapped() {
        rememberMeCheckbox.isSelected.toggle()
        let imageName = rememberMeCheckbox.isSelected ? "checkmark.square.fill" : "square"
        rememberMeCheckbox.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }
}
