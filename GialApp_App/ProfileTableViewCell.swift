//
//  ProfileTableViewCell.swift
//  GialApp_App
//
//  Created by Antonio Romaniello on 20/06/2017.
//  Copyright © 2017 Andrew Amato. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var nomeSessione: UILabel!
    @IBOutlet weak var maxTempGomme: UILabel!
    @IBOutlet weak var maxGForce: UILabel!
    @IBOutlet weak var maxVelocità: UILabel!
    @IBOutlet weak var durataSessione: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(index: IndexPath) {
        switch index.row {
        case 0:
            nomeSessione.text = "Monza"
            maxTempGomme.text = "75°"
            maxGForce.text = "2.1 G"
            maxVelocità.text = "230 KM\\H"
            durataSessione.text = "56 min"
            break
        case 1:
            nomeSessione.text = "Sarno"
            maxTempGomme.text = "50°"
            maxGForce.text = "1.7 G"
            maxVelocità.text = "170 KM\\H"
            durataSessione.text = "132 min"
            break
        case 2:
            nomeSessione.text = "Nürburgring"
            maxTempGomme.text = "72°"
            maxGForce.text = "1.9 G"
            maxVelocità.text = "240 KM\\H"
            durataSessione.text = "55 min"
            break
        case 3:
            nomeSessione.text = "Sgommate nel garage"
            maxTempGomme.text = "67°"
            maxGForce.text = "1.5 G"
            maxVelocità.text = "190 KM\\H"
            durataSessione.text = "111 min"
            break
        case 4:
            nomeSessione.text = "Castel Volturno"
            maxTempGomme.text = "90°"
            maxGForce.text = "2.4 G"
            maxVelocità.text = "270 KM\\H"
            durataSessione.text = "49 min"
            break
        case 5:
            nomeSessione.text = "Quarto"
            maxTempGomme.text = "85°"
            maxGForce.text = "1.9 G"
            maxVelocità.text = "264 KM\\H"
            durataSessione.text = "53 min"
            break
        default:
            break
        }
    }
    
    func faiUnaLinea(da inizio: CGPoint, a fine: CGPoint) {
        let path = UIBezierPath()
        path.move(to: inizio)
        path.addLine(to: fine)
        let pathLayer = CAShapeLayer()
        pathLayer.path = path.cgPath
        pathLayer.strokeColor = UIColor.red.cgColor
        pathLayer.strokeStart = 0
        pathLayer.strokeEnd = 1
        pathLayer.lineWidth = 3
        
        self.layer.addSublayer(pathLayer)
    }
}
