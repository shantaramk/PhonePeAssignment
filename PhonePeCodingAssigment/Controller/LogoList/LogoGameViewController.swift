//
//  ViewController.swift
//  PhonePeCodingAssigment
//
//  Created by "" on 25/01/21.
//

import UIKit

let GAME_TIME_COUNTER = 20

class LogoGameViewController: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet weak var logoImgeView: UIImageView!
    @IBOutlet weak var logoNameTextField: UITextField!
    @IBOutlet weak var hindLabel: UILabel!
    @IBOutlet weak var timeCounterLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var puaseButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!

    //MARK: - Properties
    var logoList = LogoList()
    var activeIndex = 0
    var activeLogo: LogoModel? {
        return logoList[activeIndex]
    }
    var score = 0
    var gameTimer: Timer?
    var timerCount = GAME_TIME_COUNTER {
        didSet {
            if timerCount == 0 {
                showNextLogo()
            }
        }
    }
    var isPause = false
    
    var viewModel: LogoGameViewModel {
        /*LogoGameViewModel(with: self,
                            logoProxy: LogoProxy(LogoJsonRepository())) */
        LogoGameViewModel(attach: self)
    }

    var userEnterLogoName: String {
        return logoNameTextField.text ?? ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.getLogoGameList()
    }
}


//MARK: - Private Method
extension LogoGameViewController {
    
    func isValidAnswer() -> Bool {
        var isValidAnswer = false
        let logo = logoList[activeIndex]
        if logo.name.lowercased().trimmingCharacters(in: .whitespaces) == self.userEnterLogoName.lowercased().trimmingCharacters(in: .whitespaces) {
            isValidAnswer = true
        }
        return isValidAnswer
    }
    
    func showNextLogo() {
        updateScoreIfNeeded()
        if activeIndex >= logoList.count - 1 {
            self.gameTimer?.invalidate()
            if score == activeIndex + 1 {
                print("Congratualtion")
                nextButton.setTitle("Reset", for: .normal)
            } else {
                nextButton.setTitle("Reset", for: .normal)
                print("try again")
            }
        } else {
            resetGameTimer()
            udpateActiveIndex()
            self.updateUI()
            if activeIndex == logoList.count - 1 {
                nextButton.setTitle("Reset", for: .normal)
            }
        }
    }
    
    func resetGameTimer() {
        self.gameTimer?.invalidate()
        self.timerCount = GAME_TIME_COUNTER
    }
    
    func udpateActiveIndex() {
        activeIndex += 1
    }
    
    func updateScoreIfNeeded() {
        if isValidAnswer() {
            score += 1
            self.scoreLabel.text = "Score is: \(score) out of \(self.logoList.count)"
        }
    }
}


//MARK: - Action
extension LogoGameViewController {
    
    @IBAction func nextButtonClick() {
        if let text = nextButton.titleLabel?.text , text == "Reset" {
            scoreLabel.text = "Welcome"
            activeIndex = 0
            resetGameTimer()
            self.updateUI()
        } else {
            gameTimer?.invalidate()
            showNextLogo()
        }

    }
    
    @IBAction func runTimedCode() {
        timerCount -= 1
        self.timeCounterLabel.text = "\(timerCount)"
    }
    
    @IBAction func pauseButtonClick() {
        if isPause {
            startTimer()
            isPause = false
            puaseButton.setTitle("Pause", for: .normal)
        } else {
            gameTimer?.invalidate()
            isPause = true
            puaseButton.setTitle("Resume", for: .normal)
        }
    }
    
    @IBAction func submitButtonClick() {
        if isValidAnswer() {
            gameTimer?.invalidate()
            showNextLogo()
        } else {
            print("try again")
        }

    }
    
}
//MARK: - Init Dependency
extension LogoGameViewController {
    
    func startTimer() {
        gameTimer?.invalidate()
       gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
    }
}
