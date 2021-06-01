//  QueFourViewController.swift



import UIKit

class QueFourViewController: UIViewController {

    

    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var optionOneButton: UIButton!
    @IBOutlet weak var optionTwoButton: UIButton!
    @IBOutlet weak var optionThreeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        
        updateView()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func replayButtonPressed(_ sender: UIBarButtonItem) {
        
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
    

        
        let userAnswer = sender.currentTitle!
        
        if userAnswer == "Hulk"{
            sender.backgroundColor = UIColor.green
            showToast()
        }else {
            sender.backgroundColor = UIColor.red
        }
      
        Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(updateView), userInfo: nil, repeats: false)
        
    }
    
    func showToast() {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.width/2-45, y: self.view.frame.height-580, width: 90, height: 50))
        toastLabel.textAlignment = .center
        toastLabel.backgroundColor = UIColor.white
        toastLabel.textColor = UIColor.black
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 15
        toastLabel.clipsToBounds = true
        toastLabel.text = "Correct"
        self.view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 2.0, delay: 1.0, options: .curveEaseInOut, animations: {
            toastLabel.alpha = 0.0
        }) { (isCompleted) in
            toastLabel.removeFromSuperview()
        }
    }
    
    @objc func updateView() {
        
        questionLabel.text = "Which cartoon character is this?"
        
        optionOneButton.setTitle("Spiderman", for: .normal)
        optionTwoButton.setTitle("Hulk", for: .normal)
        optionThreeButton.setTitle("Ironman", for: .normal)
        
        
        optionOneButton.backgroundColor = UIColor.clear
        optionTwoButton.backgroundColor = UIColor.clear
        optionThreeButton.backgroundColor = UIColor.clear
        
    }
   

}
