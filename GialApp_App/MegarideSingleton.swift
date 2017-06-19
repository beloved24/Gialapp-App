//
//  MegarideSingleton.swift
//  GialApp_App
//
//  Created by Angelo De Angelis on 17/06/2017.
//  Copyright © 2017 Andrew Amato. All rights reserved.
//

import Foundation
import Accelerate


class Megaride {
    
    struct Forze {
        
        class Assale {
            var sinistra: Forza = Forza(x: 0, y: 0, z: 0)
            var destra: Forza = Forza(x: 0, y: 0, z: 0)
        }
        
        struct Forza {
            var x: Double
            var y: Double
            var z: Double
        }
        
        var anteriore: Assale = Assale()
        var posteriore: Assale = Assale()
        
    }
    class Automobile {
        
        let g: Double = 9.81
        let massa: Double = 1150
        let j_zx: Double = 1
        let baricentroAltezza: Double = 0.7
        let passo: Double = 2.630
        
        let semipasso: Semipasso = Semipasso(anteriore: 1.782, posteriore: 1.782)
        
        let carreggiata: Carreggiata = Carreggiata(anteriore: 1.48, posteriore: 1.47)
        var centroDiRollio: CentroDiRollio = CentroDiRollio(anteriore: 0.3, posteriore: 0.4, altezza: nil)
        
        let kFi1:Double = 90000
        let kFi2:Double = 71860
        
        let kFi: Double
        
        let sigma: Sigma
        let gamma: Gamma
        
        let dragForce: Double = 0
        let h_a: Double
        
        struct Semipasso {
            let anteriore: Double
            let posteriore: Double
        }
        
        struct Carreggiata {
            let anteriore: Double
            let posteriore: Double
        }
        
        struct CentroDiRollio {
            let anteriore: Double
            let posteriore: Double

            var altezza: Double?
        }
        
        struct Sigma {
            var sigma1: Double
            let sigma2: Double
        }
        
        struct Gamma {
            let gamma1: Double
            let gamma2: Double
        }
        
        init() {
            
            kFi = kFi1+kFi2
            h_a = baricentroAltezza
            
            centroDiRollio.altezza = (centroDiRollio.anteriore*semipasso.posteriore + centroDiRollio.posteriore*semipasso.anteriore)/passo
            
            
            //sigma1 vuol dire indice assale 1 e indice lato 2
            let denominatoreSigma1 = carreggiata.anteriore*(centroDiRollio.anteriore/passo*carreggiata.posteriore + kFi1/kFi*(baricentroAltezza-centroDiRollio.altezza!))
            
            //sigma2 vuol dire indice assale 2 e indice lato 1
            let denominatoreSigma2 = carreggiata.posteriore*(centroDiRollio.posteriore/passo*carreggiata.anteriore + kFi2/kFi*(baricentroAltezza-centroDiRollio.altezza!))
            
            //gamma1 vuol dire indice assale 1
            let denominatoreGamma1 = carreggiata.anteriore * centroDiRollio.anteriore / passo
            
            //gamma2 vuol dire indice assale 2
            let denominatoreGamma2 = carreggiata.posteriore * centroDiRollio.posteriore / passo
            
            sigma = Sigma(sigma1: 1/denominatoreSigma1, sigma2: 1/denominatoreSigma2)
            gamma = Gamma(gamma1: 1/denominatoreGamma1, gamma2: 1/denominatoreGamma2)
            
        }
        
        
        
        
    }
    class Sensoristica {
        
        var giroscopio: Giroscopio = Giroscopio(primo: 0, secondo: 0, terzo: 0)
        var accelerometro: Accelerometro = Accelerometro(x: 0, y: 0, z: 0)
        
        struct Giroscopio {
            var primo: Double
            var secondo: Double
            var terzo: Double
        }
        
        struct Accelerometro {
            var x: Double
            var y: Double
            var z: Double
        }
        
    }
    
    class FeedSensoristica {
        
        let dati: Sensoristica
        let tempo: Double
        
        init(dati: Sensoristica, tempo: Double) {
            self.dati = dati
            self.tempo = tempo
        }
        
        
    }

    class Output {
     
        var accelerazioneImbardata: Double = 0
        var forze: Forze = Forze()
        var slipRatio: Double = 0
        var slipAngle: Double = 0
        var angoloAssetto: Double = 0
        var angoloSterzo: Double = 0
        var slittamentoPneumatici: Double = 0
        var temperatura: Double = 0
        
        var tempo: Double = 0
        

        
        func derivatoreImbardata() -> Double {
            return 0
        }
        
    }
    
    
    static let istanzaCondivisa = Megaride()

    let automobile = Automobile()
    var feeds: [FeedSensoristica] = []
    var outputs: [Output] = []

    private init() {
        
        
    
    }
    
    

    
    func calcolatore() {
    
        func derivatoreImbardata() -> Double {
            
            var accelerazione: Double = 0
            if let ultimoFeed = feeds.last {
                let penultimoFeed = feeds[feeds.index(before: feeds.endIndex)]
                accelerazione = (ultimoFeed.dati.giroscopio.terzo-penultimoFeed.dati.giroscopio.terzo)/(ultimoFeed.tempo-penultimoFeed.tempo)
            }
            return accelerazione
        }
        
        func risolutoreSistemi(matriceA: [Double], vettoreB: [Double], variabili: UInt) -> [Double] {
            
            let A = la_matrix_from_double_buffer(matriceA, variabili, variabili, variabili, la_hint_t(LA_NO_HINT), la_attribute_t(LA_DEFAULT_ATTRIBUTES))
            
            let B = la_matrix_from_double_buffer(vettoreB, variabili, 1, 1, la_hint_t(LA_NO_HINT), la_attribute_t(LA_DEFAULT_ATTRIBUTES))
            
            let vettoreC = la_solve(A, B)
            
            var C: [Double] = [0, 0, 0, 0]
            
            la_matrix_to_double_buffer(&C, 1, vettoreC)

            return C
        }
        
        func calcolatoreForzaZ(dati: Sensoristica, output: inout Output) {
            
            //trasferimento di carico longitudinale
            let deltaFz = automobile.massa * automobile.baricentroAltezza/automobile.passo*dati.accelerometro.x
            
            //trasferimento di carico laterale
            let deltaZ1 = automobile.sigma.sigma1*automobile.massa*dati.accelerometro.y + automobile.gamma.gamma1*automobile.j_zx*output.accelerazioneImbardata
            let deltaZ2 = automobile.sigma.sigma2*automobile.massa*dati.accelerometro.y + automobile.gamma.gamma2*automobile.j_zx*output.accelerazioneImbardata
            
            //carico statico
            let w1 = automobile.massa*automobile.g*automobile.semipasso.posteriore/automobile.passo - automobile.dragForce*(automobile.h_a - automobile.baricentroAltezza)/automobile.passo
            let w2 = automobile.massa*automobile.g*automobile.semipasso.anteriore/automobile.passo + automobile.dragForce*(automobile.h_a - automobile.baricentroAltezza)/automobile.passo
            
            //somma algebrica
            output.forze.anteriore.sinistra.z = w1/2 - deltaFz/2 - deltaZ1
            output.forze.anteriore.destra.z = w1/2 - deltaFz/2 + deltaZ1
            output.forze.posteriore.sinistra.z = w2/2 + deltaFz/2 - deltaZ2
            output.forze.posteriore.destra.z = w2/2 + deltaFz/2 + deltaZ2
        }
        func calcolatoreForzaX(dati: Sensoristica, output: inout Output) {
            
            let A: [Double] = [1, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 1, 1]
            
            let B: [Double] = [output.forze.anteriore.sinistra.z, output.forze.posteriore.sinistra.z, (output.forze.anteriore.sinistra.z + output.forze.anteriore.destra.z), (output.forze.posteriore.sinistra.z+output.forze.posteriore.destra.z)]
            
            let C = risolutoreSistemi(matriceA: A, vettoreB: B, variabili: 4)
            
            output.forze.anteriore.sinistra.x = C[0]
            output.forze.anteriore.destra.x = C[1]
            output.forze.posteriore.sinistra.x = C[2]
            output.forze.posteriore.destra.x = C[3]
            
        }
        func calcolatoreForzaY(dati: Sensoristica, output: inout Output) {
            
            let A11 = 1-output.forze.anteriore.sinistra.z/(output.forze.anteriore.sinistra.z+output.forze.anteriore.destra.z)
            let A12 = -output.forze.anteriore.sinistra.z/(output.forze.anteriore.sinistra.z+output.forze.anteriore.destra.z)
            let A23 = 1-output.forze.posteriore.sinistra.z/(output.forze.posteriore.sinistra.z+output.forze.posteriore.destra.z)
            let A24 = -output.forze.posteriore.sinistra.z/(output.forze.posteriore.sinistra.z+output.forze.posteriore.destra.z)
            
            let A: [Double] = [A11, A12, 0, 0, 0, 0, A23, A24, 1, 1, 1, 1, automobile.semipasso.anteriore, automobile.semipasso.anteriore, -automobile.semipasso.posteriore, -automobile.semipasso.posteriore]
            
            let B: [Double] = [0, 0, automobile.massa*dati.accelerometro.y, automobile.j_zx*output.accelerazioneImbardata]
            
            let C = risolutoreSistemi(matriceA: A, vettoreB: B, variabili: 4)

            output.forze.anteriore.sinistra.y = C[0]
            output.forze.anteriore.destra.y = C[1]
            output.forze.posteriore.sinistra.y = C[2]
            output.forze.posteriore.destra.y = C[3]
            
        }
        
        let ultimoFeed: FeedSensoristica? = feeds.last
        var output: Output = Output()
        
        output.accelerazioneImbardata = derivatoreImbardata()
        calcolatoreForzaZ(dati: (ultimoFeed?.dati)!, output: &output)
        calcolatoreForzaX(dati: (ultimoFeed?.dati)!, output: &output)
        calcolatoreForzaY(dati: (ultimoFeed?.dati)!, output: &output)
        
    }

}
