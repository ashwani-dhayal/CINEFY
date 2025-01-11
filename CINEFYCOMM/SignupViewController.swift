//
//  SignupViewController.swift
//  CINEFYCOMM
//
//  Created by user@71 on 29/12/24.
//

// SignupViewController.swift
import UIKit

class SignupViewController: UIViewController {
    // MARK: - UI Components
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
    
    private let nameContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.3)
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter Your Name"
        textField.textColor = .white
        textField.backgroundColor = .clear
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
        return textField
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
    
    private let confirmPasswordContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.3)
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let confirmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Confirm Password"
        textField.textColor = .white
        textField.backgroundColor = .clear
        textField.isSecureTextEntry = true
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
        return textField
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
    
    private let createAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Create Account", for: .normal)
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 25
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        return button
    }()
    
    // MARK: - Icons
    private let emailIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "envelope.fill")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let nameIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "person.fill")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let passwordIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "lock.fill")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let confirmPasswordIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "lock.fill")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        return imageView
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
        
        view.addSubview(nameContainer)
        nameContainer.addSubview(nameTextField)
        nameContainer.addSubview(nameIcon)
        
        view.addSubview(passwordContainer)
        passwordContainer.addSubview(passwordTextField)
        passwordContainer.addSubview(passwordIcon)
        
        view.addSubview(confirmPasswordContainer)
        confirmPasswordContainer.addSubview(confirmPasswordTextField)
        confirmPasswordContainer.addSubview(confirmPasswordIcon)
        
        rememberMeStack.addArrangedSubview(rememberMeCheckbox)
        rememberMeStack.addArrangedSubview(rememberMeLabel)
        view.addSubview(rememberMeStack)
        
        view.addSubview(createAccountButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            backButton.widthAnchor.constraint(equalToConstant: 44),
            backButton.heightAnchor.constraint(equalToConstant: 44),
            
            logoLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            logoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Email container
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
            
            // Name container
            nameContainer.topAnchor.constraint(equalTo: emailContainer.bottomAnchor, constant: 16),
            nameContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameContainer.heightAnchor.constraint(equalToConstant: 50),
            
            nameTextField.leadingAnchor.constraint(equalTo: nameContainer.leadingAnchor, constant: 40),
            nameTextField.trailingAnchor.constraint(equalTo: nameContainer.trailingAnchor, constant: -16),
            nameTextField.centerYAnchor.constraint(equalTo: nameContainer.centerYAnchor),
            
            nameIcon.leadingAnchor.constraint(equalTo: nameContainer.leadingAnchor, constant: 16),
            nameIcon.centerYAnchor.constraint(equalTo: nameContainer.centerYAnchor),
            nameIcon.widthAnchor.constraint(equalToConstant: 20),
            nameIcon.heightAnchor.constraint(equalToConstant: 20),
            
            // Password container
            passwordContainer.topAnchor.constraint(equalTo: nameContainer.bottomAnchor, constant: 16),
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
            
            // Confirm Password container
            confirmPasswordContainer.topAnchor.constraint(equalTo: passwordContainer.bottomAnchor, constant: 16),
            confirmPasswordContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            confirmPasswordContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            confirmPasswordContainer.heightAnchor.constraint(equalToConstant: 50),
            
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: confirmPasswordContainer.leadingAnchor, constant: 40),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: confirmPasswordContainer.trailingAnchor, constant: -16),
            confirmPasswordTextField.centerYAnchor.constraint(equalTo: confirmPasswordContainer.centerYAnchor),
            
            confirmPasswordIcon.leadingAnchor.constraint(equalTo: confirmPasswordContainer.leadingAnchor, constant: 16),
            confirmPasswordIcon.centerYAnchor.constraint(equalTo: confirmPasswordContainer.centerYAnchor),
            confirmPasswordIcon.widthAnchor.constraint(equalToConstant: 20),
            confirmPasswordIcon.heightAnchor.constraint(equalToConstant: 20),
            
            // Remember me stack
            rememberMeStack.topAnchor.constraint(equalTo: confirmPasswordContainer.bottomAnchor, constant: 16),
            rememberMeStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            rememberMeCheckbox.widthAnchor.constraint(equalToConstant: 24),
            rememberMeCheckbox.heightAnchor.constraint(equalToConstant: 24),
            
            // Create Account button
            createAccountButton.topAnchor.constraint(equalTo: rememberMeStack.bottomAnchor, constant: 24),
            createAccountButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            createAccountButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            createAccountButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    private func setupActions() {
            createAccountButton.addTarget(self, action: #selector(createAccountTapped), for: .touchUpInside)
            rememberMeCheckbox.addTarget(self, action: #selector(rememberMeTapped), for: .touchUpInside)
            backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        }
        
        // MARK: - Action Methods
        @objc private func createAccountTapped() {
            guard let email = emailTextField.text, !email.isEmpty,
                  let name = nameTextField.text, !name.isEmpty,
                  let password = passwordTextField.text, !password.isEmpty,
                  let confirmPassword = confirmPasswordTextField.text, !confirmPassword.isEmpty else {
                showAlert(message: "Please fill in all fields")
                return
            }
            
            // Validate email format
            if !isValidEmail(email) {
                showAlert(message: "Please enter a valid email address")
                return
            }
            
            // Validate password match
            guard password == confirmPassword else {
                showAlert(message: "Passwords do not match")
                return
            }
            
            // Validate password strength
            if !isValidPassword(password) {
                showAlert(message: "Password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, and one number")
                return
            }
            
            // TODO: Implement account creation logic here
            print("Creating account with email: \(email), name: \(name)")
            
            // Show loading indicator
            let loadingIndicator = UIActivityIndicatorView(style: .medium)
            loadingIndicator.color = .white
            createAccountButton.setTitle("", for: .normal)
            createAccountButton.addSubview(loadingIndicator)
            loadingIndicator.center = createAccountButton.center
            loadingIndicator.startAnimating()
            
            // Simulate network request
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
                loadingIndicator.removeFromSuperview()
                self?.createAccountButton.setTitle("Create Account", for: .normal)
                
                // Show success and dismiss
                self?.showAlert(message: "Account created successfully!", completion: {
                    self?.dismiss(animated: true)
                })
            }
        }
        
        @objc private func rememberMeTapped() {
            rememberMeCheckbox.isSelected.toggle()
            let imageName = rememberMeCheckbox.isSelected ? "checkmark.square.fill" : "square"
            rememberMeCheckbox.setImage(UIImage(systemName: imageName), for: .normal)
        }
        
        @objc private func backButtonTapped() {
            dismiss(animated: true)
        }
        
        // MARK: - Helper Methods
        private func isValidEmail(_ email: String) -> Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailPred.evaluate(with: email)
        }
        
        private func isValidPassword(_ password: String) -> Bool {
            let passwordRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$"
            let passwordPred = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
            return passwordPred.evaluate(with: password)
        }
        
        private func showAlert(message: String, completion: (() -> Void)? = nil) {
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                completion?()
            })
            present(alert, animated: true)
        }
    }

    // MARK: - UITextFieldDelegate
    extension SignupViewController: UITextFieldDelegate {
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            switch textField {
            case emailTextField:
                nameTextField.becomeFirstResponder()
            case nameTextField:
                passwordTextField.becomeFirstResponder()
            case passwordTextField:
                confirmPasswordTextField.becomeFirstResponder()
            case confirmPasswordTextField:
                textField.resignFirstResponder()
                createAccountTapped()
            default:
                textField.resignFirstResponder()
            }
            return true
        }
    }
    
 
