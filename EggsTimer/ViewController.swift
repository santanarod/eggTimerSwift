//
//  ViewController.swift
//  EggsTimer
//
//  Created by Aluno on 09/09/22.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var statusCozimento: UIButton!
    @IBOutlet weak var progressoCozimento: UIProgressView!
    @IBOutlet var cozimentos: [UIButton]!
    @IBOutlet weak var display: UILabel!
    
    let tempoCozimento = ["Líquido": 2.0, "Líquido-mole": 4.0, "Mole": 6.0, "Médio": 8.0, "Médio-duro": 10.0, "Duro": 15.0]
    var timer = Timer()
    var progresso = 0.0
    var tempo = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func selecionarCozimento(_ sender: UIButton) {
        selecionarBotaoUI(sender)
        
        reiniciarTimer()
        
        tempo = tempoCozimento[(sender.titleLabel!.text!)]!
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(mostrarProgresso), userInfo: nil, repeats: true)
        
    }
    
    @objc func mostrarProgresso() {
        let contagemRegressiva = Int(tempo - progresso)
        display.text = String(contagemRegressiva)
      
        mostrarImagensCozimento()
        
        if progresso >= tempo {
            timer.invalidate()
            mostrarAlerta()
        }
        
        progresso += 1
        progressoCozimento.progress = Float(progresso / tempo)
    }
    
    func mostrarImagensCozimento() {
        switch progresso {
        case 2..<4: statusCozimento.setImage(UIImage(named: "cozimento1"), for: .normal)
        case 4..<6: statusCozimento.setImage(UIImage(named: "cozimento2"), for: .normal)
        case 6..<8: statusCozimento.setImage(UIImage(named: "cozimento3"), for: .normal)
        case 8..<10: statusCozimento.setImage(UIImage(named: "cozimento4"), for: .normal)
        case 10..<15: statusCozimento.setImage(UIImage(named: "cozimento5"), for: .normal)
        case 15: statusCozimento.setImage(UIImage(named: "cozimento6"), for: .normal)
        default: statusCozimento.setImage(UIImage(named: "cozimento0"), for: .normal)
        }
    }
    
    func mostrarAlerta() {
        let systemSoundID: SystemSoundID = 1312
        AudioServicesPlaySystemSound(systemSoundID)

        
        let alertController = UIAlertController(title: "Pronto!", message: "Tempo de cozimento finalizado", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        self.present(alertController, animated: true)
    }
    
    func reiniciarTimer() {
        progresso = 0
        timer.invalidate()
        statusCozimento.setImage(UIImage(named: "cozimento0"), for: .normal)
        display.text = "\(0)"
    }
    
    // Aplica o efeito de seleção no botão, simulando o efeito de seleção de uma collection view
    func selecionarBotaoUI(_ sender: UIButton) {
        for cozimento in cozimentos {
            cozimento.backgroundColor = .systemIndigo
        }
        
        cozimentos[sender.tag].backgroundColor = UIColor.red
    }
}

