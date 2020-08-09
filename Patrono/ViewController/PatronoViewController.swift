import UIKit
import AVFoundation

final class PatronoViewController: UIViewController {
    
    //Constraint
    private var buttonsSetBottomConstraint = NSLayoutConstraint()
    private var topSetBottomConstraint = NSLayoutConstraint()
    
    //Views
    private let startView = PatronoStartView()
    private let buttonsSetView = ButtonsSetView()
    private let resultView = PatronoResultView()
    
    //Controller
    private var controller = PatronoController()
    
    //Player
    private var player = AVPlayer()
    private var playerLayer = AVPlayerLayer()
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        controller.delegate = self
        setupVideo()
    }
    
    // MARK: Intro
    private func setupVideo() {
        view.backgroundColor = .black
        
        if let path = Bundle.main.url(forResource: Constants.splashBackgound, withExtension: "mov") {
            player = AVPlayer(url: path)
            playerLayer = AVPlayerLayer(player: player)
            playerLayer.videoGravity = .resize
            player.actionAtItemEnd = .none
            playerLayer.frame = view.layer.bounds
            view.layer.insertSublayer(playerLayer, at: 0)
            player.play()
            
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(splashDidPlayToEndTime(notification:)),
                                                   name: .AVPlayerItemDidPlayToEndTime,
                                                   object: player.currentItem)
        }
    }
    
    @objc private func splashDidPlayToEndTime(notification: Notification) {
        setupBackgrondVideo()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.setupStarView()
        }
    }
    
    //MARK: Background Video
    private func setupBackgrondVideo() {
        if let path = Bundle.main.url(forResource: Constants.startBackground, withExtension: "mov") {
            player.replaceCurrentItem(with: AVPlayerItem(url: path))
            
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(itemDidPlayToEndTime(notification:)),
                                                   name: .AVPlayerItemDidPlayToEndTime,
                                                   object: player.currentItem)
        }
    }
    
    @objc private func itemDidPlayToEndTime(notification: Notification) {
        let player: AVPlayerItem = notification.object as! AVPlayerItem
        player.seek(to: .zero) { _ in
            self.player.play()
        }
    }
    
    // MARK: StartView
    private func setupStarView() {
        startView.translatesAutoresizingMaskIntoConstraints = false
        startView.button.addTarget(self, action: #selector(didPressStartButton(sender:)), for: .touchUpInside)
        view.addSubview(startView)
        startView.viewModel = PatronoStartModel(label: Constants.startLabelText, buttonLabel: Constants.startButtonLabelText)
        
        NSLayoutConstraint.activate([
            startView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            startView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            startView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            startView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
        ])
    }
    
    @objc private func didPressStartButton(sender: ButtonView) {
        startView.removeFromSuperview()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.setupAnswersView()
        }
    }
    
    // MARK: AnswersView
    private func setupAnswersView() {
        buttonsSetView.translatesAutoresizingMaskIntoConstraints = false
        buttonsSetView.answerOneButton.addTarget(self, action: #selector(didPressAnswerButton(sender:)), for: .touchUpInside)
        buttonsSetView.answerTwoButton.addTarget(self, action: #selector(didPressAnswerButton(sender:)), for: .touchUpInside)
        buttonsSetView.answerThreeButton.addTarget(self, action: #selector(didPressAnswerButton(sender:)), for: .touchUpInside)
        
        view.addSubview(buttonsSetView)
        buttonsSetView.viewModel = controller.getPatronoAnswers()
        
        let buttonsSetBottomConstraint = buttonsSetView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        self.buttonsSetBottomConstraint = buttonsSetBottomConstraint
        
        let topSetBottomConstraint = buttonsSetView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 130)
        self.topSetBottomConstraint = topSetBottomConstraint
        
        NSLayoutConstraint.activate([
            topSetBottomConstraint,
            buttonsSetView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            buttonsSetView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            //buttonsSetBottomConstraint
        ])
    }
    
    @objc private func didPressAnswerButton(sender: ButtonView) {
        if let answer = sender.titleLabel?.text {
            controller.checkPatronoAnswer(answer)
            buttonsSetView.isHidden = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.updateAnswers()
                self.buttonsSetView.isHidden = false
            }
        }
    }
    
    @objc private func updateAnswers() {
        buttonsSetView.viewModel = controller.getPatronoAnswers()
        buttonsSetView.answerThreeButton.isHidden = buttonsSetView.viewModel?.answerThree == ""
        buttonsSetBottomConstraint.constant = buttonsSetView.answerThreeButton.isHidden ? 135 : -100
    }
    
    private func setupResultView(patrono: String, description: String) {        
        resultView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(resultView)
        resultView.viewModel = PatronoResultModel(title: patrono, description: description)
        
        NSLayoutConstraint.activate([
            resultView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            resultView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])
    }
}

extension PatronoViewController: PatronoControllerDelegate {
    func didFindPatronoResult(patrono: String, description: String) {
        buttonsSetView.removeFromSuperview()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.setupResultView(patrono: patrono, description: description)
        }
    }
}

