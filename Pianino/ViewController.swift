//
//  ViewController.swift
//  Pianino
//
//  Created by Raul Aghayev on 24/04/2020.
//  Copyright © 2020 Raul Aghayev. All rights reserved.
//

//Importing libraries
import UIKit
import Darwin
import ImageIO
import TinyConstraints
import SwiftGifOrigin
import AVFoundation
//The audio player
var audioPlayer: AVAudioPlayer?
//The flag for continuing the game
//Possible for classic game mode
var flagForcon : Bool?
//The integer for game continuing,if 2 then you can go on
//if more than two you can not go on(only for classic mode)
var intForcon : Int = 0
//The counter for classic game mode's gif and timer
//If one is set, start the timer
var counTer : Int = 0
//Counter for game mode
var countGamemode : Int = 0
//Counter for invalidating
//In case of true, invalidate the timer
var counterInval : Bool?
//Counter for minute timer, in case of 1 start
//Second timer starts
var counterforMintimer : Int = 0
//In case if "counterforMintimer1" is set on 3, the "gameover"
//Window after time mode will appear(of course ather countdown is over)
var counterforMintimer1 : Int = 0

//The helper us used for indicating the game mode and
//In case of time mode, helps invalidate the running timers
//Before starting the next timer
var helper : Int = 1
//The time for timer for time game mode(one minute)
var oneMintimer : Int = 59
//The time for timer for classic game mode(3 seconds)
//Watch video and then continue
var counTera : Int = 3
//The flag for game mode(true or false for time or classic)
var flagForgamemode : Bool?
//The flag for sound effects
var flagforSoundeffects : Bool?

class ViewController: UIViewController {
    //The timer
    weak var countTimer:Timer?

    
    //The label for timer
    @IBOutlet weak var labelFortimer: UILabel!
    //The button(outlet) in main window(game mode)
    @IBOutlet weak var modeChangeoutlet: UIButton!
    //The same button, but "Action" instead of variable
    @IBAction func modeChangebutton(_ sender: UIButton)
    {
        //Change modes in first view
        if(countGamemode == 1)//Counter for game mode
        {
            flagForgamemode = false//Flag that shows which game mode is currently used
            modeChangeoutlet.setTitle("GAME MODE: CLASSIC", for: .normal)//Change the text of the button
            modeChangeoutlet.setTitleColor(#colorLiteral(red: 0.9411764706, green: 0.1882352941, blue: 0.1882352941, alpha: 1), for: .normal)//Change the color text
            countGamemode = 0
            helper = 1
            
        }
        else
        {
            flagForgamemode = true//Same here, set the falg for true, thisfalg will be used below
            modeChangeoutlet.setTitle("GAME MODE: TIME", for: .normal)//Change text in button
            modeChangeoutlet.setTitleColor(UIColor(red: 0/255, green: 255/255, blue: 0/255, alpha: 1.0), for: .normal)//Change color of button
            countGamemode = 1//Set counter
            helper = 33
           
        }
    }
    
    
    
    
    
    
    //All black buttons
    @IBOutlet weak var BlackButton2: UIButton!
    @IBOutlet weak var BlackButton8: UIButton!
    @IBOutlet weak var BlackButton9: UIButton!
    @IBOutlet weak var BlackButton15: UIButton!
    @IBOutlet weak var BlackButton20: UIButton!
    @IBOutlet weak var BlackButton23: UIButton!
    @IBOutlet weak var BlackButton26: UIButton!
    
    //Declaring white buttons
    @IBOutlet weak var WhiteButton1: UIButton!
    @IBOutlet weak var WhiteButton3: UIButton!
    @IBOutlet weak var WhiteButton4: UIButton!
    
    @IBOutlet weak var WhiteButton5: UIButton!
    @IBOutlet weak var WhiteButton6: UIButton!
    @IBOutlet weak var WhiteButton7: UIButton!
    
    @IBOutlet weak var WhiteButton10: UIButton!
    @IBOutlet weak var WhiteButton11: UIButton!
    @IBOutlet weak var WhiteButton12: UIButton!
    
    @IBOutlet weak var WhiteButton13: UIButton!
    @IBOutlet weak var WhiteButton14: UIButton!
    @IBOutlet weak var WhiteButton16: UIButton!
    
    @IBOutlet weak var WhiteButton17: UIButton!
    @IBOutlet weak var WhiteButton18: UIButton!
    @IBOutlet weak var WhiteButton19: UIButton!
    
    @IBOutlet weak var WhiteButton21: UIButton!
    @IBOutlet weak var WhiteButton22: UIButton!
    @IBOutlet weak var WhiteButton24: UIButton!
    
  
    @IBOutlet weak var WhiteButton25: UIButton!
    @IBOutlet weak var WhiteButton27: UIButton!
    @IBOutlet weak var WhiteButton28: UIButton!
    
    //Array to declare the buttons
    var BB = [UIButton]()
    
    //Labels for score and highscore
    @IBOutlet weak var ScoreLabel: UILabel!
    @IBOutlet weak var HighestScore: UILabel!
    
    
    //Button for continuing the game in classic mode(available only once per game)
    @IBOutlet weak var secLifebutton: UIButton!


    //Integers for score and highscore
    var score: Int = 0
    var HighestScoreV : Int = 0
    
    

    //In case of button number 2 were pressed
    @IBAction func Pressed2Black(_ sender: UIButton)
    {
        //In case if the center of first button from bottom
        //Is on 819.5 coordinate, do
        if(BlackButton2.center.y == 819.5)
        {
            //In case of flag for sounds is on, enable sound
            if(flagforSoundeffects == true)
            {
                //The name of sound, connect , and prepare
                let pianoSound = Bundle.main.path(forResource: "secondSound", ofType: "mp3")!
                let url = URL(fileURLWithPath: pianoSound)



                //Catch errors in case of mistakes, otherwise play
                do {
                     audioPlayer = try AVAudioPlayer(contentsOf: url)
                     audioPlayer?.play()
                }
                catch
                {
                    print("Error in audio playing occurred")
                }
            }

            
            
            
            
            
            //Increase the score on every correct button
            score+=1
           
            //Get the score from saved score(below)
            var inputS:Int = (ScoreLabel.text! as NSString).integerValue
            //in case if the score we had is more than 0, increase it and
            //Assign it to "score" variable
            if(inputS > 0)
            {
                inputS += 1
                score = inputS
            }
            //Save the score
            let ScoreSave = score
            //Get the highscore from saved highscore(below)
            let input:Int = (HighestScore.text! as NSString).integerValue
            //If score is bigger than highscore
            //Highscore is now score, otherwise the highscore is saved highscore
            //This is used when the app is reopened(maybe after a few days)
            //This is kind of "saving the data"
            if(score > input)
            {
                HighestScoreV = score
            
            }else
            {
                HighestScoreV = input
            }
            //Saving the highscore
            let HighScoreSave = HighestScoreV
            
            //Declaring the "UserDefautls"
            let userDefaults = Foundation.UserDefaults.standard
            //Saving the score and highscore for keys "Keys" and "Key"
            //Using "UserDefaults"
            userDefaults.set(HighScoreSave, forKey: "Key")
            userDefaults.set(ScoreSave, forKey: "Keys")
            
            //Extracting the values from saved onces
            //If we save and extract it right straight, we will always have
            //The actual value
            let valueS = userDefaults.string(forKey: "Keys")
            let value = userDefaults.string(forKey: "Key")
            
            //Assign them to score label's
            HighestScore.text = value
            ScoreLabel.text = valueS
            //Declare all the buttons
            BB = [BlackButton2, WhiteButton1, WhiteButton3,WhiteButton4,
                  BlackButton8, WhiteButton5, WhiteButton6,WhiteButton7,
                  BlackButton9, WhiteButton10, WhiteButton11, WhiteButton12,
                  BlackButton15, WhiteButton13, WhiteButton14, WhiteButton16,
                  BlackButton20, WhiteButton17, WhiteButton18, WhiteButton19,
                  BlackButton23, WhiteButton21, WhiteButton22, WhiteButton24,
                  BlackButton26, WhiteButton25, WhiteButton27, WhiteButton28
                 
            ]
            //For scores in the array above, we move all of the button on 149
            //We more the height
            //This works like this:
            //We press the button, and if the button is correct, all of the
            //Buttons are moved down on 149 points(the effect of real moving)
            for score in BB
            {
                score.center = CGPoint (x:score.center.x, y:score.center.y + 149)
            }
        
            //The buttons for understanding the code
            //Or debugging
//            print(BlackButton2.center.y)
//            print(BlackButton8.center.y)
//            print(BlackButton9.center.y)
//            print(BlackButton15.center.y)
//            print(BlackButton20.center.y)
//            print(BlackButton23.center.y)
//            print(BlackButton26.center.y)
            //Now if the pressed button were button number 2
            //Don't forget that me moved the "Y"s' of all buttons on 149
            if(BlackButton2.center.y >= 968.5)
            {
                let number : Int = Int(arc4random()) % 4
                //And now create the new buttons, using the random
                //Depending on the number,create diffrent buttons
                //And place them on the top of the screen
                switch number {
                case 0:
                    BlackButton2.center = CGPoint(x:51, y: -74.5)//1
                    WhiteButton1.center = CGPoint(x:155, y: -74.5)//2
                    WhiteButton3.center = CGPoint(x:259, y: -74.5)//3
                    WhiteButton4.center = CGPoint(x:363, y: -74.5)//4
                    break
                case 1:
                    BlackButton2.center = CGPoint(x:155, y: -74.5)
                    WhiteButton1.center = CGPoint(x:51, y: -74.5)
                    WhiteButton3.center = CGPoint(x:259, y: -74.5)
                    WhiteButton4.center = CGPoint(x:363, y: -74.5)
                    break
                case 2:
                    BlackButton2.center = CGPoint(x:259, y: -74.5)
                    WhiteButton1.center = CGPoint(x:155, y: -74.5)
                    WhiteButton3.center = CGPoint(x:51, y: -74.5)
                    WhiteButton4.center = CGPoint(x:363, y: -74.5)
                    break
                case 3:
                    BlackButton2.center = CGPoint(x:363, y: -74.5)
                    WhiteButton1.center = CGPoint(x:155, y: -74.5)
                    WhiteButton3.center = CGPoint(x:51, y: -74.5)
                    WhiteButton4.center = CGPoint(x:259, y: -74.5)
                    break
                default:
                        break
                }
                
            }
            //The sane for this case,
            //The only diffrence is the button pressed
            if(BlackButton8.center.y >= 968.5)
            {
                let number : Int = Int(arc4random()) % 4
                switch number {
                case 0:
                    BlackButton8.center = CGPoint(x:51, y: -74.5)
                    WhiteButton5.center = CGPoint(x:155, y: -74.5)
                    WhiteButton6.center = CGPoint(x:259, y: -74.5)
                    WhiteButton7.center = CGPoint(x:363, y: -74.5)
                    break
                case 1:
                    BlackButton8.center = CGPoint(x:155, y: -74.5)
                    WhiteButton5.center = CGPoint(x:51, y: -74.5)
                    WhiteButton6.center = CGPoint(x:259, y: -74.5)
                    WhiteButton7.center = CGPoint(x:363, y: -74.5)
                    break
                case 2:
                    BlackButton8.center = CGPoint(x:259, y: -74.5)
                    WhiteButton5.center = CGPoint(x:155, y: -74.5)
                    WhiteButton6.center = CGPoint(x:51, y: -74.5)
                    WhiteButton7.center = CGPoint(x:363, y: -74.5)
                    break
                case 3:
                    BlackButton8.center = CGPoint(x:363, y: -74.5)
                    WhiteButton5.center = CGPoint(x:155, y: -74.5)
                    WhiteButton6.center = CGPoint(x:51, y: -74.5)
                    WhiteButton7.center = CGPoint(x:259, y: -74.5)
                    break
                default:
                        break
                }
            }
            
            if(BlackButton9.center.y >= 968.5)
            {
                let number : Int = Int(arc4random()) % 4
                switch number {
                case 0:
                    BlackButton9.center = CGPoint(x:51, y: -74.5)
                    WhiteButton10.center = CGPoint(x:155, y: -74.5)
                    WhiteButton11.center = CGPoint(x:259, y: -74.5)
                    WhiteButton12.center = CGPoint(x:363, y: -74.5)
                    break
                case 1:
                    BlackButton9.center = CGPoint(x:155, y: -74.5)
                    WhiteButton10.center = CGPoint(x:51, y: -74.5)
                    WhiteButton11.center = CGPoint(x:259, y: -74.5)
                    WhiteButton12.center = CGPoint(x:363, y: -74.5)
                    break
                case 2:
                    BlackButton9.center = CGPoint(x:259, y: -74.5)
                    WhiteButton10.center = CGPoint(x:155, y: -74.5)
                    WhiteButton11.center = CGPoint(x:51, y: -74.5)
                    WhiteButton12.center = CGPoint(x:363, y: -74.5)
                    break
                case 3:
                    BlackButton9.center = CGPoint(x:363, y: -74.5)
                    WhiteButton10.center = CGPoint(x:155, y: -74.5)
                    WhiteButton11.center = CGPoint(x:51, y: -74.5)
                    WhiteButton12.center = CGPoint(x:259, y: -74.5)
                    break
                default:
                        break
                }
            }
            
            if(BlackButton15.center.y >= 968.5)
            {
                let number : Int = Int(arc4random()) % 4
                switch number {
                case 0:
                    BlackButton15.center = CGPoint(x:51, y: -74.5)
                    WhiteButton13.center = CGPoint(x:155, y: -74.5)
                    WhiteButton14.center = CGPoint(x:259, y: -74.5)
                    WhiteButton16.center = CGPoint(x:363, y: -74.5)
                    break
                case 1:
                    BlackButton15.center = CGPoint(x:155, y: -74.5)
                    WhiteButton13.center = CGPoint(x:51, y: -74.5)
                    WhiteButton14.center = CGPoint(x:259, y: -74.5)
                    WhiteButton16.center = CGPoint(x:363, y: -74.5)
                    break
                case 2:
                    BlackButton15.center = CGPoint(x:259, y: -74.5)
                    WhiteButton13.center = CGPoint(x:155, y: -74.5)
                    WhiteButton14.center = CGPoint(x:51, y: -74.5)
                    WhiteButton16.center = CGPoint(x:363, y: -74.5)
                    break
                case 3:
                    BlackButton15.center = CGPoint(x:363, y: -74.5)
                    WhiteButton13.center = CGPoint(x:155, y: -74.5)
                    WhiteButton14.center = CGPoint(x:51, y: -74.5)
                    WhiteButton16.center = CGPoint(x:259, y: -74.5)
                    break
                default:
                        break
                }
            }
            
            if(BlackButton20.center.y >= 968.5)
            {
                let number : Int = Int(arc4random()) % 4
                switch number {
                case 0:
                    BlackButton20.center = CGPoint(x:51, y: -74.5)
                    WhiteButton17.center = CGPoint(x:155, y: -74.5)
                    WhiteButton18.center = CGPoint(x:259, y: -74.5)
                    WhiteButton19.center = CGPoint(x:363, y: -74.5)
                    break
                case 1:
                    BlackButton20.center = CGPoint(x:155, y: -74.5)
                    WhiteButton17.center = CGPoint(x:51, y: -74.5)
                    WhiteButton18.center = CGPoint(x:259, y: -74.5)
                    WhiteButton19.center = CGPoint(x:363, y: -74.5)
                    break
                case 2:
                    BlackButton20.center = CGPoint(x:259, y: -74.5)
                    WhiteButton17.center = CGPoint(x:155, y: -74.5)
                    WhiteButton18.center = CGPoint(x:51, y: -74.5)
                    WhiteButton19.center = CGPoint(x:363, y: -74.5)
                    break
                case 3:
                    BlackButton20.center = CGPoint(x:363, y: -74.5)
                    WhiteButton17.center = CGPoint(x:155, y: -74.5)
                    WhiteButton18.center = CGPoint(x:51, y: -74.5)
                    WhiteButton19.center = CGPoint(x:259, y: -74.5)
                    break
                default:
                        break
                }
            }
            
            if(BlackButton23.center.y >= 968.5)
            {
                let number : Int = Int(arc4random()) % 4
                switch number {
                case 0:
                    BlackButton23.center = CGPoint(x:51, y: -74.5)
                    WhiteButton21.center = CGPoint(x:155, y: -74.5)
                    WhiteButton22.center = CGPoint(x:259, y: -74.5)
                    WhiteButton24.center = CGPoint(x:363, y: -74.5)
                    break
                case 1:
                    BlackButton23.center = CGPoint(x:155, y: -74.5)
                    WhiteButton21.center = CGPoint(x:51, y: -74.5)
                    WhiteButton22.center = CGPoint(x:259, y: -74.5)
                    WhiteButton24.center = CGPoint(x:363, y: -74.5)
                    break
                case 2:
                    BlackButton23.center = CGPoint(x:259, y: -74.5)
                    WhiteButton21.center = CGPoint(x:155, y: -74.5)
                    WhiteButton22.center = CGPoint(x:51, y: -74.5)
                    WhiteButton24.center = CGPoint(x:363, y: -74.5)
                    break
                case 3:
                    BlackButton23.center = CGPoint(x:363, y: -74.5)
                    WhiteButton21.center = CGPoint(x:155, y: -74.5)
                    WhiteButton22.center = CGPoint(x:51, y: -74.5)
                    WhiteButton24.center = CGPoint(x:259, y: -74.5)
                default:
                        break
                }
            }
            if(BlackButton26.center.y >= 968.5)
            {
                let number : Int = Int(arc4random()) % 4
                switch number {
                case 0:
                    BlackButton26.center = CGPoint(x:51, y: -74.5)
                    WhiteButton25.center = CGPoint(x:155, y: -74.5)
                    WhiteButton27.center = CGPoint(x:259, y: -74.5)
                    WhiteButton28.center = CGPoint(x:363, y: -74.5)
                    break
                case 1:
                    BlackButton26.center = CGPoint(x:155, y: -74.5)
                    WhiteButton25.center = CGPoint(x:51, y: -74.5)
                    WhiteButton27.center = CGPoint(x:259, y: -74.5)
                    WhiteButton28.center = CGPoint(x:363, y: -74.5)
                    break
                case 2:
                    BlackButton26.center = CGPoint(x:259, y: -74.5)
                    WhiteButton25.center = CGPoint(x:155, y: -74.5)
                    WhiteButton27.center = CGPoint(x:51, y: -74.5)
                    WhiteButton28.center = CGPoint(x:363, y: -74.5)
                    break
                case 3:
                    BlackButton26.center = CGPoint(x:363, y: -74.5)
                    WhiteButton25.center = CGPoint(x:155, y: -74.5)
                    WhiteButton27.center = CGPoint(x:51, y: -74.5)
                    WhiteButton28.center = CGPoint(x:259, y: -74.5)
                    break
                default:
                        break
                }
            }

            
        }

    }
    
    @IBAction func Black26Pressed(_ sender: UIButton)
    {

         if(BlackButton26.center.y == 819.5)
         {
            
            if(flagforSoundeffects == true)
            {
                let pianoSound = Bundle.main.path(forResource: "thirdSound", ofType: "wav")!
                let url = URL(fileURLWithPath: pianoSound)




                do {
                     audioPlayer = try AVAudioPlayer(contentsOf: url)
                     audioPlayer?.play()
                } catch {
                    print("Error in audio playing occurred")
                }
            }
            
            
            
            score+=1
            let input:Int = (HighestScore.text! as NSString).integerValue
            if(score > input)
            {
                HighestScoreV = score
            
            }else{
                  HighestScoreV = input
              }
            
            let HighScoreSave = HighestScoreV
            let userDefaults = Foundation.UserDefaults.standard
            userDefaults.set(HighScoreSave, forKey: "Key")
            
//          let userDefaults = Foundation.UserDefaults.standard
            let value = userDefaults.string(forKey: "Key")
            HighestScore.text = value

            ScoreLabel.text = String(score)
            
             BB = [BlackButton2, WhiteButton1, WhiteButton3,WhiteButton4,
                   BlackButton8, WhiteButton5, WhiteButton6,WhiteButton7,
                   BlackButton9, WhiteButton10, WhiteButton11, WhiteButton12,
                   BlackButton15, WhiteButton13, WhiteButton14, WhiteButton16,
                   BlackButton20, WhiteButton17, WhiteButton18, WhiteButton19,
                   BlackButton23, WhiteButton21, WhiteButton22, WhiteButton24,
                   BlackButton26, WhiteButton25, WhiteButton27, WhiteButton28
             ]
             for score in BB
             {
                 //print(score)
                 score.center = CGPoint (x:score.center.x, y:score.center.y + 149)
             }
            
         
             if(BlackButton2.center.y >= 968.5)
             {
                 let number : Int = Int(arc4random()) % 4
                 switch number {
                 case 0:
                     BlackButton2.center = CGPoint(x:51, y: -74.5)
                     WhiteButton1.center = CGPoint(x:155, y: -74.5)
                     WhiteButton3.center = CGPoint(x:259, y: -74.5)
                     WhiteButton4.center = CGPoint(x:363, y: -74.5)
                    break
                 case 1:
                     BlackButton2.center = CGPoint(x:155, y: -74.5)
                     WhiteButton1.center = CGPoint(x:51, y: -74.5)
                     WhiteButton3.center = CGPoint(x:259, y: -74.5)
                     WhiteButton4.center = CGPoint(x:363, y: -74.5)
                    break
                 case 2:
                     BlackButton2.center = CGPoint(x:259, y: -74.5)
                     WhiteButton1.center = CGPoint(x:155, y: -74.5)
                     WhiteButton3.center = CGPoint(x:51, y: -74.5)
                     WhiteButton4.center = CGPoint(x:363, y: -74.5)
                    break
                 case 3:
                     BlackButton2.center = CGPoint(x:363, y: -74.5)
                     WhiteButton1.center = CGPoint(x:155, y: -74.5)
                     WhiteButton3.center = CGPoint(x:51, y: -74.5)
                     WhiteButton4.center = CGPoint(x:259, y: -74.5)
                    break
                 default:
                         break
                 }
                 
             }
             if(BlackButton8.center.y >= 968.5)
             {
                ScoreLabel.text = String(score)
                 let number : Int = Int(arc4random()) % 4
                 switch number {
                 case 0:
                     BlackButton8.center = CGPoint(x:51, y: -74.5)
                     WhiteButton5.center = CGPoint(x:155, y: -74.5)
                     WhiteButton6.center = CGPoint(x:259, y: -74.5)
                     WhiteButton7.center = CGPoint(x:363, y: -74.5)
                    break
                 case 1:
                     BlackButton8.center = CGPoint(x:155, y: -74.5)
                     WhiteButton5.center = CGPoint(x:51, y: -74.5)
                     WhiteButton6.center = CGPoint(x:259, y: -74.5)
                     WhiteButton7.center = CGPoint(x:363, y: -74.5)
                    break
                 case 2:
                     BlackButton8.center = CGPoint(x:259, y: -74.5)
                     WhiteButton5.center = CGPoint(x:155, y: -74.5)
                     WhiteButton6.center = CGPoint(x:51, y: -74.5)
                     WhiteButton7.center = CGPoint(x:363, y: -74.5)
                    break
                 case 3:
                     BlackButton8.center = CGPoint(x:363, y: -74.5)
                     WhiteButton5.center = CGPoint(x:155, y: -74.5)
                     WhiteButton6.center = CGPoint(x:51, y: -74.5)
                     WhiteButton7.center = CGPoint(x:259, y: -74.5)
                    break
                 default:
                         break
                 }
             }
             
             if(BlackButton9.center.y >= 968.5)
             {
                 let number : Int = Int(arc4random()) % 4
                 switch number {
                 case 0:
                     BlackButton9.center = CGPoint(x:51, y: -74.5)
                     WhiteButton10.center = CGPoint(x:155, y: -74.5)
                     WhiteButton11.center = CGPoint(x:259, y: -74.5)
                     WhiteButton12.center = CGPoint(x:363, y: -74.5)
                    break
                 case 1:
                     BlackButton9.center = CGPoint(x:155, y: -74.5)
                     WhiteButton10.center = CGPoint(x:51, y: -74.5)
                     WhiteButton11.center = CGPoint(x:259, y: -74.5)
                     WhiteButton12.center = CGPoint(x:363, y: -74.5)
                    break
                 case 2:
                     BlackButton9.center = CGPoint(x:259, y: -74.5)
                     WhiteButton10.center = CGPoint(x:155, y: -74.5)
                     WhiteButton11.center = CGPoint(x:51, y: -74.5)
                     WhiteButton12.center = CGPoint(x:363, y: -74.5)
                    break
                 case 3:
                     BlackButton9.center = CGPoint(x:363, y: -74.5)
                     WhiteButton10.center = CGPoint(x:155, y: -74.5)
                     WhiteButton11.center = CGPoint(x:51, y: -74.5)
                     WhiteButton12.center = CGPoint(x:259, y: -74.5)
                    break
                 default:
                         break
                 }
             }
             
             if(BlackButton15.center.y >= 968.5)
             {
                 let number : Int = Int(arc4random()) % 4
                 switch number {
                 case 0:
                     BlackButton15.center = CGPoint(x:51, y: -74.5)
                     WhiteButton13.center = CGPoint(x:155, y: -74.5)
                     WhiteButton14.center = CGPoint(x:259, y: -74.5)
                     WhiteButton16.center = CGPoint(x:363, y: -74.5)
                    break
                 case 1:
                     BlackButton15.center = CGPoint(x:155, y: -74.5)
                     WhiteButton13.center = CGPoint(x:51, y: -74.5)
                     WhiteButton14.center = CGPoint(x:259, y: -74.5)
                     WhiteButton16.center = CGPoint(x:363, y: -74.5)
                    break
                 case 2:
                     BlackButton15.center = CGPoint(x:259, y: -74.5)
                     WhiteButton13.center = CGPoint(x:155, y: -74.5)
                     WhiteButton14.center = CGPoint(x:51, y: -74.5)
                     WhiteButton16.center = CGPoint(x:363, y: -74.5)
                    break
                 case 3:
                     BlackButton15.center = CGPoint(x:363, y: -74.5)
                     WhiteButton13.center = CGPoint(x:155, y: -74.5)
                     WhiteButton14.center = CGPoint(x:51, y: -74.5)
                     WhiteButton16.center = CGPoint(x:259, y: -74.5)
                    break
                 default:
                         break
                 }
             }
             
             if(BlackButton20.center.y >= 968.5)
             {
                 let number : Int = Int(arc4random()) % 4
                 switch number {
                 case 0:
                     BlackButton20.center = CGPoint(x:51, y: -74.5)
                     WhiteButton17.center = CGPoint(x:155, y: -74.5)
                     WhiteButton18.center = CGPoint(x:259, y: -74.5)
                     WhiteButton19.center = CGPoint(x:363, y: -74.5)
                    break
                 case 1:
                     BlackButton20.center = CGPoint(x:155, y: -74.5)
                     WhiteButton17.center = CGPoint(x:51, y: -74.5)
                     WhiteButton18.center = CGPoint(x:259, y: -74.5)
                     WhiteButton19.center = CGPoint(x:363, y: -74.5)
                    break
                 case 2:
                     BlackButton20.center = CGPoint(x:259, y: -74.5)
                     WhiteButton17.center = CGPoint(x:155, y: -74.5)
                     WhiteButton18.center = CGPoint(x:51, y: -74.5)
                     WhiteButton19.center = CGPoint(x:363, y: -74.5)
                    break
                 case 3:
                     BlackButton20.center = CGPoint(x:363, y: -74.5)
                     WhiteButton17.center = CGPoint(x:155, y: -74.5)
                     WhiteButton18.center = CGPoint(x:51, y: -74.5)
                     WhiteButton19.center = CGPoint(x:259, y: -74.5)
                    break
                 default:
                         break
                 }
             }
             
             if(BlackButton23.center.y >= 968.5)
             {
                 let number : Int = Int(arc4random()) % 4
                 switch number {
                 case 0:
                     BlackButton23.center = CGPoint(x:51, y: -74.5)
                     WhiteButton21.center = CGPoint(x:155, y: -74.5)
                     WhiteButton22.center = CGPoint(x:259, y: -74.5)
                     WhiteButton24.center = CGPoint(x:363, y: -74.5)
                    break
                 case 1:
                     BlackButton23.center = CGPoint(x:155, y: -74.5)
                     WhiteButton21.center = CGPoint(x:51, y: -74.5)
                     WhiteButton22.center = CGPoint(x:259, y: -74.5)
                     WhiteButton24.center = CGPoint(x:363, y: -74.5)
                    break
                 case 2:
                     BlackButton23.center = CGPoint(x:259, y: -74.5)
                     WhiteButton21.center = CGPoint(x:155, y: -74.5)
                     WhiteButton22.center = CGPoint(x:51, y: -74.5)
                     WhiteButton24.center = CGPoint(x:363, y: -74.5)
                    break
                 case 3:
                     BlackButton23.center = CGPoint(x:363, y: -74.5)
                     WhiteButton21.center = CGPoint(x:155, y: -74.5)
                     WhiteButton22.center = CGPoint(x:51, y: -74.5)
                     WhiteButton24.center = CGPoint(x:259, y: -74.5)
                    break
                 default:
                         break
                 }
             }
             if(BlackButton26.center.y >= 968.5)
             {
                 let number : Int = Int(arc4random()) % 4
                 switch number {
                 case 0:
                     BlackButton26.center = CGPoint(x:51, y: -74.5)
                     WhiteButton25.center = CGPoint(x:155, y: -74.5)
                     WhiteButton27.center = CGPoint(x:259, y: -74.5)
                     WhiteButton28.center = CGPoint(x:363, y: -74.5)
                    break
                 case 1:
                     BlackButton26.center = CGPoint(x:155, y: -74.5)
                     WhiteButton25.center = CGPoint(x:51, y: -74.5)
                     WhiteButton27.center = CGPoint(x:259, y: -74.5)
                     WhiteButton28.center = CGPoint(x:363, y: -74.5)
                    break
                 case 2:
                     BlackButton26.center = CGPoint(x:259, y: -74.5)
                     WhiteButton25.center = CGPoint(x:155, y: -74.5)
                     WhiteButton27.center = CGPoint(x:51, y: -74.5)
                     WhiteButton28.center = CGPoint(x:363, y: -74.5)
                    break
                 case 3:
                     BlackButton26.center = CGPoint(x:363, y: -74.5)
                     WhiteButton25.center = CGPoint(x:155, y: -74.5)
                     WhiteButton27.center = CGPoint(x:51, y: -74.5)
                     WhiteButton28.center = CGPoint(x:259, y: -74.5)
                    break
                 default:
                         break
                 }
             }
             
         }

     }
    
    
    
    //Absolutely the same code is here, the diffrence is the button
    //Above the button number 2 were pressed, whereas here we have the
    //Button number 8
    @IBAction func Pressed8Black(_ sender: UIButton)
    {
            
          if(BlackButton8.center.y == 819.5)
          {
            
            if(flagforSoundeffects == true)
            {
                let pianoSound = Bundle.main.path(forResource: "fourthSound", ofType: "wav")!
                let url = URL(fileURLWithPath: pianoSound)




                do {
                     audioPlayer = try AVAudioPlayer(contentsOf: url)
                     audioPlayer?.play()
                } catch {
                    print("Error in audio playing occurred")
                }
            }
            
            
            
            score+=1
            let input:Int = (HighestScore.text! as NSString).integerValue
            if(score > input)
            {
                HighestScoreV = score
            
            }else{
                HighestScoreV = input
            }
            
            let HighScoreSave = HighestScoreV
            let ScoreSave = score
            
            let userDefaults = Foundation.UserDefaults.standard
            userDefaults.set(HighScoreSave, forKey: "Key")
            userDefaults.set(ScoreSave, forKey: "Keys")
            
            let valueS = userDefaults.string(forKey: "Keys")
            let value = userDefaults.string(forKey: "Key")
            
            HighestScore.text = value
            ScoreLabel.text = valueS
            BB = [BlackButton2, WhiteButton1, WhiteButton3,WhiteButton4,
                    BlackButton8, WhiteButton5, WhiteButton6,WhiteButton7,
                    BlackButton9, WhiteButton10, WhiteButton11, WhiteButton12,
                    BlackButton15, WhiteButton13, WhiteButton14, WhiteButton16,
                    BlackButton20, WhiteButton17, WhiteButton18, WhiteButton19,
                    BlackButton23, WhiteButton21, WhiteButton22, WhiteButton24,
                    BlackButton26, WhiteButton25, WhiteButton27, WhiteButton28
                   
              ]
              for score in BB
              {
                  //print(score)
                  score.center = CGPoint (x:score.center.x, y:score.center.y + 149)
              }
             
          
              if(BlackButton2.center.y >= 968.5)
              {
                  let number : Int = Int(arc4random()) % 4
                  switch number {
                  case 0:
                      BlackButton2.center = CGPoint(x:51, y: -74.5)
                      WhiteButton1.center = CGPoint(x:155, y: -74.5)
                      WhiteButton3.center = CGPoint(x:259, y: -74.5)
                      WhiteButton4.center = CGPoint(x:363, y: -74.5)
                    break
                  case 1:
                      BlackButton2.center = CGPoint(x:155, y: -74.5)
                      WhiteButton1.center = CGPoint(x:51, y: -74.5)
                      WhiteButton3.center = CGPoint(x:259, y: -74.5)
                      WhiteButton4.center = CGPoint(x:363, y: -74.5)
                    break
                  case 2:
                      BlackButton2.center = CGPoint(x:259, y: -74.5)
                      WhiteButton1.center = CGPoint(x:155, y: -74.5)
                      WhiteButton3.center = CGPoint(x:51, y: -74.5)
                      WhiteButton4.center = CGPoint(x:363, y: -74.5)
                    break
                  case 3:
                      BlackButton2.center = CGPoint(x:363, y: -74.5)
                      WhiteButton1.center = CGPoint(x:155, y: -74.5)
                      WhiteButton3.center = CGPoint(x:51, y: -74.5)
                      WhiteButton4.center = CGPoint(x:259, y: -74.5)
                    break
                  default:
                          break
                  }
                  
              }
              if(BlackButton8.center.y >= 968.5)
              {
                  let number : Int = Int(arc4random()) % 4
                  switch number {
                  case 0:
                      BlackButton8.center = CGPoint(x:51, y: -74.5)
                      WhiteButton5.center = CGPoint(x:155, y: -74.5)
                      WhiteButton6.center = CGPoint(x:259, y: -74.5)
                      WhiteButton7.center = CGPoint(x:363, y: -74.5)
                    break
                  case 1:
                      BlackButton8.center = CGPoint(x:155, y: -74.5)
                      WhiteButton5.center = CGPoint(x:51, y: -74.5)
                      WhiteButton6.center = CGPoint(x:259, y: -74.5)
                      WhiteButton7.center = CGPoint(x:363, y: -74.5)
                    break
                  case 2:
                      BlackButton8.center = CGPoint(x:259, y: -74.5)
                      WhiteButton5.center = CGPoint(x:155, y: -74.5)
                      WhiteButton6.center = CGPoint(x:51, y: -74.5)
                      WhiteButton7.center = CGPoint(x:363, y: -74.5)
                    break
                  case 3:
                      BlackButton8.center = CGPoint(x:363, y: -74.5)
                      WhiteButton5.center = CGPoint(x:155, y: -74.5)
                      WhiteButton6.center = CGPoint(x:51, y: -74.5)
                      WhiteButton7.center = CGPoint(x:259, y: -74.5)
                    break
                  default:
                          break
                  }
              }
              
              if(BlackButton9.center.y >= 968.5)
              {
                  let number : Int = Int(arc4random()) % 4
                  switch number {
                  case 0:
                      BlackButton9.center = CGPoint(x:51, y: -74.5)
                      WhiteButton10.center = CGPoint(x:155, y: -74.5)
                      WhiteButton11.center = CGPoint(x:259, y: -74.5)
                      WhiteButton12.center = CGPoint(x:363, y: -74.5)
                    break
                  case 1:
                      BlackButton9.center = CGPoint(x:155, y: -74.5)
                      WhiteButton10.center = CGPoint(x:51, y: -74.5)
                      WhiteButton11.center = CGPoint(x:259, y: -74.5)
                      WhiteButton12.center = CGPoint(x:363, y: -74.5)
                    break
                  case 2:
                      BlackButton9.center = CGPoint(x:259, y: -74.5)
                      WhiteButton10.center = CGPoint(x:155, y: -74.5)
                      WhiteButton11.center = CGPoint(x:51, y: -74.5)
                      WhiteButton12.center = CGPoint(x:363, y: -74.5)
                    break
                  case 3:
                      BlackButton9.center = CGPoint(x:363, y: -74.5)
                      WhiteButton10.center = CGPoint(x:155, y: -74.5)
                      WhiteButton11.center = CGPoint(x:51, y: -74.5)
                      WhiteButton12.center = CGPoint(x:259, y: -74.5)
                    break
                  default:
                          break
                  }
              }
              
              if(BlackButton15.center.y >= 968.5)
              {
                  let number : Int = Int(arc4random()) % 4
                  switch number {
                  case 0:
                      BlackButton15.center = CGPoint(x:51, y: -74.5)
                      WhiteButton13.center = CGPoint(x:155, y: -74.5)
                      WhiteButton14.center = CGPoint(x:259, y: -74.5)
                      WhiteButton16.center = CGPoint(x:363, y: -74.5)
                    break
                  case 1:
                      BlackButton15.center = CGPoint(x:155, y: -74.5)
                      WhiteButton13.center = CGPoint(x:51, y: -74.5)
                      WhiteButton14.center = CGPoint(x:259, y: -74.5)
                      WhiteButton16.center = CGPoint(x:363, y: -74.5)
                    break
                  case 2:
                      BlackButton15.center = CGPoint(x:259, y: -74.5)
                      WhiteButton13.center = CGPoint(x:155, y: -74.5)
                      WhiteButton14.center = CGPoint(x:51, y: -74.5)
                      WhiteButton16.center = CGPoint(x:363, y: -74.5)
                    break
                  case 3:
                      BlackButton15.center = CGPoint(x:363, y: -74.5)
                      WhiteButton13.center = CGPoint(x:155, y: -74.5)
                      WhiteButton14.center = CGPoint(x:51, y: -74.5)
                      WhiteButton16.center = CGPoint(x:259, y: -74.5)
                    break
                  default:
                          break
                  }
              }
              
              if(BlackButton20.center.y >= 968.5)
              {
                  let number : Int = Int(arc4random()) % 4
                  switch number {
                  case 0:
                      BlackButton20.center = CGPoint(x:51, y: -74.5)
                      WhiteButton17.center = CGPoint(x:155, y: -74.5)
                      WhiteButton18.center = CGPoint(x:259, y: -74.5)
                      WhiteButton19.center = CGPoint(x:363, y: -74.5)
                    break
                  case 1:
                      BlackButton20.center = CGPoint(x:155, y: -74.5)
                      WhiteButton17.center = CGPoint(x:51, y: -74.5)
                      WhiteButton18.center = CGPoint(x:259, y: -74.5)
                      WhiteButton19.center = CGPoint(x:363, y: -74.5)
                    break
                  case 2:
                      BlackButton20.center = CGPoint(x:259, y: -74.5)
                      WhiteButton17.center = CGPoint(x:155, y: -74.5)
                      WhiteButton18.center = CGPoint(x:51, y: -74.5)
                      WhiteButton19.center = CGPoint(x:363, y: -74.5)
                    break
                  case 3:
                      BlackButton20.center = CGPoint(x:363, y: -74.5)
                      WhiteButton17.center = CGPoint(x:155, y: -74.5)
                      WhiteButton18.center = CGPoint(x:51, y: -74.5)
                      WhiteButton19.center = CGPoint(x:259, y: -74.5)
                    break
                  default:
                          break
                  }
              }
              
              if(BlackButton23.center.y >= 968.5)
              {
                  let number : Int = Int(arc4random()) % 4
                  switch number {
                  case 0:
                      BlackButton23.center = CGPoint(x:51, y: -74.5)
                      WhiteButton21.center = CGPoint(x:155, y: -74.5)
                      WhiteButton22.center = CGPoint(x:259, y: -74.5)
                      WhiteButton24.center = CGPoint(x:363, y: -74.5)
                    break
                  case 1:
                      BlackButton23.center = CGPoint(x:155, y: -74.5)
                      WhiteButton21.center = CGPoint(x:51, y: -74.5)
                      WhiteButton22.center = CGPoint(x:259, y: -74.5)
                      WhiteButton24.center = CGPoint(x:363, y: -74.5)
                    break
                  case 2:
                      BlackButton23.center = CGPoint(x:259, y: -74.5)
                      WhiteButton21.center = CGPoint(x:155, y: -74.5)
                      WhiteButton22.center = CGPoint(x:51, y: -74.5)
                      WhiteButton24.center = CGPoint(x:363, y: -74.5)
                    break
                  case 3:
                      BlackButton23.center = CGPoint(x:363, y: -74.5)
                      WhiteButton21.center = CGPoint(x:155, y: -74.5)
                      WhiteButton22.center = CGPoint(x:51, y: -74.5)
                      WhiteButton24.center = CGPoint(x:259, y: -74.5)
                    break
                  default:
                          break
                  }
              }
                if(BlackButton26.center.y >= 968.5)
                {
                    let number : Int = Int(arc4random()) % 4
                    switch number {
                    case 0:
                        BlackButton26.center = CGPoint(x:51, y: -74.5)
                        WhiteButton25.center = CGPoint(x:155, y: -74.5)
                        WhiteButton27.center = CGPoint(x:259, y: -74.5)
                        WhiteButton28.center = CGPoint(x:363, y: -74.5)
                        break
                    case 1:
                        BlackButton26.center = CGPoint(x:155, y: -74.5)
                        WhiteButton25.center = CGPoint(x:51, y: -74.5)
                        WhiteButton27.center = CGPoint(x:259, y: -74.5)
                        WhiteButton28.center = CGPoint(x:363, y: -74.5)
                        break
                    case 2:
                        BlackButton26.center = CGPoint(x:259, y: -74.5)
                        WhiteButton25.center = CGPoint(x:155, y: -74.5)
                        WhiteButton27.center = CGPoint(x:51, y: -74.5)
                        WhiteButton28.center = CGPoint(x:363, y: -74.5)
                        break
                    case 3:
                        BlackButton26.center = CGPoint(x:363, y: -74.5)
                        WhiteButton25.center = CGPoint(x:155, y: -74.5)
                        WhiteButton27.center = CGPoint(x:51, y: -74.5)
                        WhiteButton28.center = CGPoint(x:259, y: -74.5)
                        break
                    default:
                            break
                    }
                }
              
          }

      }
    @IBAction func Pressed9Black(_ sender: UIButton)
    {

          if(BlackButton9.center.y == 819.5)
          {
            
            if(flagforSoundeffects == true)
            {
            
                let pianoSound = Bundle.main.path(forResource: "fifthSound", ofType: "wav")!
                let url = URL(fileURLWithPath: pianoSound)




                do {
                     audioPlayer = try AVAudioPlayer(contentsOf: url)
                     audioPlayer?.play()
                } catch {
                    print("Error in audio playing occurred")
                }
            }
            
            
            score+=1
            let input:Int = (HighestScore.text! as NSString).integerValue
            if(score > input)
            {
                HighestScoreV = score
            
            }else{
                HighestScoreV = input
            }
            
            let HighScoreSave = HighestScoreV
            let ScoreSave = score
            
            let userDefaults = Foundation.UserDefaults.standard
            userDefaults.set(HighScoreSave, forKey: "Key")
            userDefaults.set(ScoreSave, forKey: "Keys")
            
            let valueS = userDefaults.string(forKey: "Keys")
            let value = userDefaults.string(forKey: "Key")
            
            HighestScore.text = value
            ScoreLabel.text = valueS
            BB = [BlackButton2, WhiteButton1, WhiteButton3,WhiteButton4,
                    BlackButton8, WhiteButton5, WhiteButton6,WhiteButton7,
                    BlackButton9, WhiteButton10, WhiteButton11, WhiteButton12,
                    BlackButton15, WhiteButton13, WhiteButton14, WhiteButton16,
                    BlackButton20, WhiteButton17, WhiteButton18, WhiteButton19,
                    BlackButton23, WhiteButton21, WhiteButton22, WhiteButton24,
                    BlackButton26, WhiteButton25, WhiteButton27, WhiteButton28
                   
              ]
              for score in BB
              {
                  //print(score)
                  score.center = CGPoint (x:score.center.x, y:score.center.y + 149)
              }
             
          
              if(BlackButton2.center.y >= 968.5)
              {
                  let number : Int = Int(arc4random()) % 4
                  switch number {
                  case 0:
                      BlackButton2.center = CGPoint(x:51, y: -74.5)
                      WhiteButton1.center = CGPoint(x:155, y: -74.5)
                      WhiteButton3.center = CGPoint(x:259, y: -74.5)
                      WhiteButton4.center = CGPoint(x:363, y: -74.5)
                    break
                  case 1:
                      BlackButton2.center = CGPoint(x:155, y: -74.5)
                      WhiteButton1.center = CGPoint(x:51, y: -74.5)
                      WhiteButton3.center = CGPoint(x:259, y: -74.5)
                      WhiteButton4.center = CGPoint(x:363, y: -74.5)
                    break
                  case 2:
                      BlackButton2.center = CGPoint(x:259, y: -74.5)
                      WhiteButton1.center = CGPoint(x:155, y: -74.5)
                      WhiteButton3.center = CGPoint(x:51, y: -74.5)
                      WhiteButton4.center = CGPoint(x:363, y: -74.5)
                    break
                  case 3:
                      BlackButton2.center = CGPoint(x:363, y: -74.5)
                      WhiteButton1.center = CGPoint(x:155, y: -74.5)
                      WhiteButton3.center = CGPoint(x:51, y: -74.5)
                      WhiteButton4.center = CGPoint(x:259, y: -74.5)
                    break
                  default:
                          break
                  }
                  
              }
              if(BlackButton8.center.y >= 968.5)
              {
                  let number : Int = Int(arc4random()) % 4
                  switch number {
                  case 0:
                      BlackButton8.center = CGPoint(x:51, y: -74.5)
                      WhiteButton5.center = CGPoint(x:155, y: -74.5)
                      WhiteButton6.center = CGPoint(x:259, y: -74.5)
                      WhiteButton7.center = CGPoint(x:363, y: -74.5)
                    break
                  case 1:
                      BlackButton8.center = CGPoint(x:155, y: -74.5)
                      WhiteButton5.center = CGPoint(x:51, y: -74.5)
                      WhiteButton6.center = CGPoint(x:259, y: -74.5)
                      WhiteButton7.center = CGPoint(x:363, y: -74.5)
                    break
                  case 2:
                      BlackButton8.center = CGPoint(x:259, y: -74.5)
                      WhiteButton5.center = CGPoint(x:155, y: -74.5)
                      WhiteButton6.center = CGPoint(x:51, y: -74.5)
                      WhiteButton7.center = CGPoint(x:363, y: -74.5)
                    break
                  case 3:
                      BlackButton8.center = CGPoint(x:363, y: -74.5)
                      WhiteButton5.center = CGPoint(x:155, y: -74.5)
                      WhiteButton6.center = CGPoint(x:51, y: -74.5)
                      WhiteButton7.center = CGPoint(x:259, y: -74.5)
                    break
                  default:
                          break
                  }
              }
              
              if(BlackButton9.center.y >= 968.5)
              {
                  let number : Int = Int(arc4random()) % 4
                  switch number {
                  case 0:
                      BlackButton9.center = CGPoint(x:51, y: -74.5)
                      WhiteButton10.center = CGPoint(x:155, y: -74.5)
                      WhiteButton11.center = CGPoint(x:259, y: -74.5)
                      WhiteButton12.center = CGPoint(x:363, y: -74.5)
                    break
                  case 1:
                      BlackButton9.center = CGPoint(x:155, y: -74.5)
                      WhiteButton10.center = CGPoint(x:51, y: -74.5)
                      WhiteButton11.center = CGPoint(x:259, y: -74.5)
                      WhiteButton12.center = CGPoint(x:363, y: -74.5)
                    break
                  case 2:
                      BlackButton9.center = CGPoint(x:259, y: -74.5)
                      WhiteButton10.center = CGPoint(x:155, y: -74.5)
                      WhiteButton11.center = CGPoint(x:51, y: -74.5)
                      WhiteButton12.center = CGPoint(x:363, y: -74.5)
                    break
                  case 3:
                      BlackButton9.center = CGPoint(x:363, y: -74.5)
                      WhiteButton10.center = CGPoint(x:155, y: -74.5)
                      WhiteButton11.center = CGPoint(x:51, y: -74.5)
                      WhiteButton12.center = CGPoint(x:259, y: -74.5)
                    break
                  default:
                          break
                  }
              }
              
              if(BlackButton15.center.y >= 968.5)
              {
                  let number : Int = Int(arc4random()) % 4
                  switch number {
                  case 0:
                      BlackButton15.center = CGPoint(x:51, y: -74.5)
                      WhiteButton13.center = CGPoint(x:155, y: -74.5)
                      WhiteButton14.center = CGPoint(x:259, y: -74.5)
                      WhiteButton16.center = CGPoint(x:363, y: -74.5)
                    break
                  case 1:
                      BlackButton15.center = CGPoint(x:155, y: -74.5)
                      WhiteButton13.center = CGPoint(x:51, y: -74.5)
                      WhiteButton14.center = CGPoint(x:259, y: -74.5)
                      WhiteButton16.center = CGPoint(x:363, y: -74.5)
                    break
                  case 2:
                      BlackButton15.center = CGPoint(x:259, y: -74.5)
                      WhiteButton13.center = CGPoint(x:155, y: -74.5)
                      WhiteButton14.center = CGPoint(x:51, y: -74.5)
                      WhiteButton16.center = CGPoint(x:363, y: -74.5)
                    break
                  case 3:
                      BlackButton15.center = CGPoint(x:363, y: -74.5)
                      WhiteButton13.center = CGPoint(x:155, y: -74.5)
                      WhiteButton14.center = CGPoint(x:51, y: -74.5)
                      WhiteButton16.center = CGPoint(x:259, y: -74.5)
                    break
                  default:
                          break
                  }
              }
              
              if(BlackButton20.center.y >= 968.5)
              {
                  let number : Int = Int(arc4random()) % 4
                  switch number {
                  case 0:
                      BlackButton20.center = CGPoint(x:51, y: -74.5)
                      WhiteButton17.center = CGPoint(x:155, y: -74.5)
                      WhiteButton18.center = CGPoint(x:259, y: -74.5)
                      WhiteButton19.center = CGPoint(x:363, y: -74.5)
                    break
                  case 1:
                      BlackButton20.center = CGPoint(x:155, y: -74.5)
                      WhiteButton17.center = CGPoint(x:51, y: -74.5)
                      WhiteButton18.center = CGPoint(x:259, y: -74.5)
                      WhiteButton19.center = CGPoint(x:363, y: -74.5)
                    break
                  case 2:
                      BlackButton20.center = CGPoint(x:259, y: -74.5)
                      WhiteButton17.center = CGPoint(x:155, y: -74.5)
                      WhiteButton18.center = CGPoint(x:51, y: -74.5)
                      WhiteButton19.center = CGPoint(x:363, y: -74.5)
                    break
                  case 3:
                      BlackButton20.center = CGPoint(x:363, y: -74.5)
                      WhiteButton17.center = CGPoint(x:155, y: -74.5)
                      WhiteButton18.center = CGPoint(x:51, y: -74.5)
                      WhiteButton19.center = CGPoint(x:259, y: -74.5)
                    break
                  default:
                          break
                  }
              }
              
              if(BlackButton23.center.y >= 968.5)
              {
                  let number : Int = Int(arc4random()) % 4
                  switch number {
                  case 0:
                      BlackButton23.center = CGPoint(x:51, y: -74.5)
                      WhiteButton21.center = CGPoint(x:155, y: -74.5)
                      WhiteButton22.center = CGPoint(x:259, y: -74.5)
                      WhiteButton24.center = CGPoint(x:363, y: -74.5)
                    break
                  case 1:
                      BlackButton23.center = CGPoint(x:155, y: -74.5)
                      WhiteButton21.center = CGPoint(x:51, y: -74.5)
                      WhiteButton22.center = CGPoint(x:259, y: -74.5)
                      WhiteButton24.center = CGPoint(x:363, y: -74.5)
                    break
                  case 2:
                      BlackButton23.center = CGPoint(x:259, y: -74.5)
                      WhiteButton21.center = CGPoint(x:155, y: -74.5)
                      WhiteButton22.center = CGPoint(x:51, y: -74.5)
                      WhiteButton24.center = CGPoint(x:363, y: -74.5)
                    break
                  case 3:
                      BlackButton23.center = CGPoint(x:363, y: -74.5)
                      WhiteButton21.center = CGPoint(x:155, y: -74.5)
                      WhiteButton22.center = CGPoint(x:51, y: -74.5)
                      WhiteButton24.center = CGPoint(x:259, y: -74.5)
                    break
                  default:
                          break
                  }
              }
            if(BlackButton26.center.y >= 968.5)
            {
                let number : Int = Int(arc4random()) % 4
                switch number {
                case 0:
                    BlackButton26.center = CGPoint(x:51, y: -74.5)
                    WhiteButton25.center = CGPoint(x:155, y: -74.5)
                    WhiteButton27.center = CGPoint(x:259, y: -74.5)
                    WhiteButton28.center = CGPoint(x:363, y: -74.5)
                    break
                case 1:
                    BlackButton26.center = CGPoint(x:155, y: -74.5)
                    WhiteButton25.center = CGPoint(x:51, y: -74.5)
                    WhiteButton27.center = CGPoint(x:259, y: -74.5)
                    WhiteButton28.center = CGPoint(x:363, y: -74.5)
                    break
                case 2:
                    BlackButton26.center = CGPoint(x:259, y: -74.5)
                    WhiteButton25.center = CGPoint(x:155, y: -74.5)
                    WhiteButton27.center = CGPoint(x:51, y: -74.5)
                    WhiteButton28.center = CGPoint(x:363, y: -74.5)
                    break
                case 3:
                    BlackButton26.center = CGPoint(x:363, y: -74.5)
                    WhiteButton25.center = CGPoint(x:155, y: -74.5)
                    WhiteButton27.center = CGPoint(x:51, y: -74.5)
                    WhiteButton28.center = CGPoint(x:259, y: -74.5)
                    break
                default:
                        break
                }
            }
              
          }

      }
    @IBAction func Pressed15Black(_ sender: UIButton)
    {

          if(BlackButton15.center.y == 819.5)
          {
            
            if(flagforSoundeffects == true)
            {
                let pianoSound = Bundle.main.path(forResource: "sixthSound", ofType: "wav")!
                let url = URL(fileURLWithPath: pianoSound)




                do {
                     audioPlayer = try AVAudioPlayer(contentsOf: url)
                     audioPlayer?.play()
                } catch {
                    print("Error in audio playing occurred")
                }
            }
            
            score+=1
            let input:Int = (HighestScore.text! as NSString).integerValue
            if(score > input)
            {
                HighestScoreV = score
            
            }else{
                HighestScoreV = input
            }
            
            let HighScoreSave = HighestScoreV
            let ScoreSave = score
            
            let userDefaults = Foundation.UserDefaults.standard
            userDefaults.set(HighScoreSave, forKey: "Key")
            userDefaults.set(ScoreSave, forKey: "Keys")
            
            let valueS = userDefaults.string(forKey: "Keys")
            let value = userDefaults.string(forKey: "Key")
            
            HighestScore.text = value
            ScoreLabel.text = valueS
            BB = [BlackButton2, WhiteButton1, WhiteButton3,WhiteButton4,
                    BlackButton8, WhiteButton5, WhiteButton6,WhiteButton7,
                    BlackButton9, WhiteButton10, WhiteButton11, WhiteButton12,
                    BlackButton15, WhiteButton13, WhiteButton14, WhiteButton16,
                    BlackButton20, WhiteButton17, WhiteButton18, WhiteButton19,
                    BlackButton23, WhiteButton21, WhiteButton22, WhiteButton24,
                    BlackButton26, WhiteButton25, WhiteButton27, WhiteButton28
                   
              ]
              for score in BB
              {
                  //print(score)
                  score.center = CGPoint (x:score.center.x, y:score.center.y + 149)
              }
             
          
              if(BlackButton2.center.y >= 968.5)
              {
                  let number : Int = Int(arc4random()) % 4
                  switch number {
                  case 0:
                      BlackButton2.center = CGPoint(x:51, y: -74.5)
                      WhiteButton1.center = CGPoint(x:155, y: -74.5)
                      WhiteButton3.center = CGPoint(x:259, y: -74.5)
                      WhiteButton4.center = CGPoint(x:363, y: -74.5)
                    break
                  case 1:
                      BlackButton2.center = CGPoint(x:155, y: -74.5)
                      WhiteButton1.center = CGPoint(x:51, y: -74.5)
                      WhiteButton3.center = CGPoint(x:259, y: -74.5)
                      WhiteButton4.center = CGPoint(x:363, y: -74.5)
                    break
                  case 2:
                      BlackButton2.center = CGPoint(x:259, y: -74.5)
                      WhiteButton1.center = CGPoint(x:155, y: -74.5)
                      WhiteButton3.center = CGPoint(x:51, y: -74.5)
                      WhiteButton4.center = CGPoint(x:363, y: -74.5)
                    break
                  case 3:
                      BlackButton2.center = CGPoint(x:363, y: -74.5)
                      WhiteButton1.center = CGPoint(x:155, y: -74.5)
                      WhiteButton3.center = CGPoint(x:51, y: -74.5)
                      WhiteButton4.center = CGPoint(x:259, y: -74.5)
                    break
                  default:
                          break
                  }
                  
              }
              if(BlackButton8.center.y >= 968.5)
              {
                  let number : Int = Int(arc4random()) % 4
                  switch number {
                  case 0:
                      BlackButton8.center = CGPoint(x:51, y: -74.5)
                      WhiteButton5.center = CGPoint(x:155, y: -74.5)
                      WhiteButton6.center = CGPoint(x:259, y: -74.5)
                      WhiteButton7.center = CGPoint(x:363, y: -74.5)
                    break
                  case 1:
                      BlackButton8.center = CGPoint(x:155, y: -74.5)
                      WhiteButton5.center = CGPoint(x:51, y: -74.5)
                      WhiteButton6.center = CGPoint(x:259, y: -74.5)
                      WhiteButton7.center = CGPoint(x:363, y: -74.5)
                    break
                  case 2:
                      BlackButton8.center = CGPoint(x:259, y: -74.5)
                      WhiteButton5.center = CGPoint(x:155, y: -74.5)
                      WhiteButton6.center = CGPoint(x:51, y: -74.5)
                      WhiteButton7.center = CGPoint(x:363, y: -74.5)
                    break
                  case 3:
                      BlackButton8.center = CGPoint(x:363, y: -74.5)
                      WhiteButton5.center = CGPoint(x:155, y: -74.5)
                      WhiteButton6.center = CGPoint(x:51, y: -74.5)
                      WhiteButton7.center = CGPoint(x:259, y: -74.5)
                    break
                  default:
                          break
                  }
              }
              
              if(BlackButton9.center.y >= 968.5)
              {
                  let number : Int = Int(arc4random()) % 4
                  switch number {
                  case 0:
                      BlackButton9.center = CGPoint(x:51, y: -74.5)
                      WhiteButton10.center = CGPoint(x:155, y: -74.5)
                      WhiteButton11.center = CGPoint(x:259, y: -74.5)
                      WhiteButton12.center = CGPoint(x:363, y: -74.5)
                    break
                  case 1:
                      BlackButton9.center = CGPoint(x:155, y: -74.5)
                      WhiteButton10.center = CGPoint(x:51, y: -74.5)
                      WhiteButton11.center = CGPoint(x:259, y: -74.5)
                      WhiteButton12.center = CGPoint(x:363, y: -74.5)
                    break
                  case 2:
                      BlackButton9.center = CGPoint(x:259, y: -74.5)
                      WhiteButton10.center = CGPoint(x:155, y: -74.5)
                      WhiteButton11.center = CGPoint(x:51, y: -74.5)
                      WhiteButton12.center = CGPoint(x:363, y: -74.5)
                    break
                  case 3:
                      BlackButton9.center = CGPoint(x:363, y: -74.5)
                      WhiteButton10.center = CGPoint(x:155, y: -74.5)
                      WhiteButton11.center = CGPoint(x:51, y: -74.5)
                      WhiteButton12.center = CGPoint(x:259, y: -74.5)
                    break
                  default:
                          break
                  }
              }
              
              if(BlackButton15.center.y >= 968.5)
              {
                  let number : Int = Int(arc4random()) % 4
                  switch number {
                  case 0:
                      BlackButton15.center = CGPoint(x:51, y: -74.5)
                      WhiteButton13.center = CGPoint(x:155, y: -74.5)
                      WhiteButton14.center = CGPoint(x:259, y: -74.5)
                      WhiteButton16.center = CGPoint(x:363, y: -74.5)
                    break
                  case 1:
                      BlackButton15.center = CGPoint(x:155, y: -74.5)
                      WhiteButton13.center = CGPoint(x:51, y: -74.5)
                      WhiteButton14.center = CGPoint(x:259, y: -74.5)
                      WhiteButton16.center = CGPoint(x:363, y: -74.5)
                    break
                  case 2:
                      BlackButton15.center = CGPoint(x:259, y: -74.5)
                      WhiteButton13.center = CGPoint(x:155, y: -74.5)
                      WhiteButton14.center = CGPoint(x:51, y: -74.5)
                      WhiteButton16.center = CGPoint(x:363, y: -74.5)
                    break
                  case 3:
                      BlackButton15.center = CGPoint(x:363, y: -74.5)
                      WhiteButton13.center = CGPoint(x:155, y: -74.5)
                      WhiteButton14.center = CGPoint(x:51, y: -74.5)
                      WhiteButton16.center = CGPoint(x:259, y: -74.5)
                    break
                  default:
                          break
                  }
              }
              
              if(BlackButton20.center.y >= 968.5)
              {
                  let number : Int = Int(arc4random()) % 4
                  switch number {
                  case 0:
                      BlackButton20.center = CGPoint(x:51, y: -74.5)
                      WhiteButton17.center = CGPoint(x:155, y: -74.5)
                      WhiteButton18.center = CGPoint(x:259, y: -74.5)
                      WhiteButton19.center = CGPoint(x:363, y: -74.5)
                    break
                  case 1:
                      BlackButton20.center = CGPoint(x:155, y: -74.5)
                      WhiteButton17.center = CGPoint(x:51, y: -74.5)
                      WhiteButton18.center = CGPoint(x:259, y: -74.5)
                      WhiteButton19.center = CGPoint(x:363, y: -74.5)
                    break
                  case 2:
                      BlackButton20.center = CGPoint(x:259, y: -74.5)
                      WhiteButton17.center = CGPoint(x:155, y: -74.5)
                      WhiteButton18.center = CGPoint(x:51, y: -74.5)
                      WhiteButton19.center = CGPoint(x:363, y: -74.5)
                    break
                  case 3:
                      BlackButton20.center = CGPoint(x:363, y: -74.5)
                      WhiteButton17.center = CGPoint(x:155, y: -74.5)
                      WhiteButton18.center = CGPoint(x:51, y: -74.5)
                      WhiteButton19.center = CGPoint(x:259, y: -74.5)
                    break
                  default:
                          break
                  }
              }
              
              if(BlackButton23.center.y >= 968.5)
              {
                  let number : Int = Int(arc4random()) % 4
                  switch number {
                  case 0:
                      BlackButton23.center = CGPoint(x:51, y: -74.5)
                      WhiteButton21.center = CGPoint(x:155, y: -74.5)
                      WhiteButton22.center = CGPoint(x:259, y: -74.5)
                      WhiteButton24.center = CGPoint(x:363, y: -74.5)
                    break
                  case 1:
                      BlackButton23.center = CGPoint(x:155, y: -74.5)
                      WhiteButton21.center = CGPoint(x:51, y: -74.5)
                      WhiteButton22.center = CGPoint(x:259, y: -74.5)
                      WhiteButton24.center = CGPoint(x:363, y: -74.5)
                    break
                  case 2:
                      BlackButton23.center = CGPoint(x:259, y: -74.5)
                      WhiteButton21.center = CGPoint(x:155, y: -74.5)
                      WhiteButton22.center = CGPoint(x:51, y: -74.5)
                      WhiteButton24.center = CGPoint(x:363, y: -74.5)
                    break
                  case 3:
                      BlackButton23.center = CGPoint(x:363, y: -74.5)
                      WhiteButton21.center = CGPoint(x:155, y: -74.5)
                      WhiteButton22.center = CGPoint(x:51, y: -74.5)
                      WhiteButton24.center = CGPoint(x:259, y: -74.5)
                    break
                  default:
                          break
                  }
              }
            if(BlackButton26.center.y >= 968.5)
            {
                let number : Int = Int(arc4random()) % 4
                switch number {
                case 0:
                    BlackButton26.center = CGPoint(x:51, y: -74.5)
                    WhiteButton25.center = CGPoint(x:155, y: -74.5)
                    WhiteButton27.center = CGPoint(x:259, y: -74.5)
                    WhiteButton28.center = CGPoint(x:363, y: -74.5)
                    break
                case 1:
                    BlackButton26.center = CGPoint(x:155, y: -74.5)
                    WhiteButton25.center = CGPoint(x:51, y: -74.5)
                    WhiteButton27.center = CGPoint(x:259, y: -74.5)
                    WhiteButton28.center = CGPoint(x:363, y: -74.5)
                    break
                case 2:
                    BlackButton26.center = CGPoint(x:259, y: -74.5)
                    WhiteButton25.center = CGPoint(x:155, y: -74.5)
                    WhiteButton27.center = CGPoint(x:51, y: -74.5)
                    WhiteButton28.center = CGPoint(x:363, y: -74.5)
                    break
                case 3:
                    BlackButton26.center = CGPoint(x:363, y: -74.5)
                    WhiteButton25.center = CGPoint(x:155, y: -74.5)
                    WhiteButton27.center = CGPoint(x:51, y: -74.5)
                    WhiteButton28.center = CGPoint(x:259, y: -74.5)
                    break
                default:
                        break
                }
            }
              
          }

      }
    @IBAction func Pressed20Black(_ sender: UIButton)
    {

        
          if(BlackButton20.center.y == 819.5)
          {
           
            if(flagforSoundeffects == true)
            {
                let pianoSound = Bundle.main.path(forResource: "thirdSound", ofType: "wav")!
                let url = URL(fileURLWithPath: pianoSound)




                do {
                     audioPlayer = try AVAudioPlayer(contentsOf: url)
                     audioPlayer?.play()
                } catch {
                    print("Error in audio playing occurred")
                }
            }
            
            
            score+=1
            let input:Int = (HighestScore.text! as NSString).integerValue
            if(score > input)
            {
                HighestScoreV = score
            
            }else{
                HighestScoreV = input
            }
            
            let HighScoreSave = HighestScoreV
            let ScoreSave = score
            
            let userDefaults = Foundation.UserDefaults.standard
            userDefaults.set(HighScoreSave, forKey: "Key")
            userDefaults.set(ScoreSave, forKey: "Keys")
            
            let valueS = userDefaults.string(forKey: "Keys")
            let value = userDefaults.string(forKey: "Key")
            
            HighestScore.text = value
            ScoreLabel.text = valueS
            BB = [BlackButton2, WhiteButton1, WhiteButton3,WhiteButton4,
                    BlackButton8, WhiteButton5, WhiteButton6,WhiteButton7,
                    BlackButton9, WhiteButton10, WhiteButton11, WhiteButton12,
                    BlackButton15, WhiteButton13, WhiteButton14, WhiteButton16,
                    BlackButton20, WhiteButton17, WhiteButton18, WhiteButton19,
                    BlackButton23, WhiteButton21, WhiteButton22, WhiteButton24,
                    BlackButton26, WhiteButton25, WhiteButton27, WhiteButton28
                   
              ]
              for score in BB
              {
                  //print(score)
                  score.center = CGPoint (x:score.center.x, y:score.center.y + 149)
              }
             
          
              if(BlackButton2.center.y >= 968.5)
              {
                  let number : Int = Int(arc4random()) % 4
                  switch number {
                  case 0:
                      BlackButton2.center = CGPoint(x:51, y: -74.5)
                      WhiteButton1.center = CGPoint(x:155, y: -74.5)
                      WhiteButton3.center = CGPoint(x:259, y: -74.5)
                      WhiteButton4.center = CGPoint(x:363, y: -74.5)
                    break
                  case 1:
                      BlackButton2.center = CGPoint(x:155, y: -74.5)
                      WhiteButton1.center = CGPoint(x:51, y: -74.5)
                      WhiteButton3.center = CGPoint(x:259, y: -74.5)
                      WhiteButton4.center = CGPoint(x:363, y: -74.5)
                    break
                  case 2:
                      BlackButton2.center = CGPoint(x:259, y: -74.5)
                      WhiteButton1.center = CGPoint(x:155, y: -74.5)
                      WhiteButton3.center = CGPoint(x:51, y: -74.5)
                      WhiteButton4.center = CGPoint(x:363, y: -74.5)
                    break
                  case 3:
                      BlackButton2.center = CGPoint(x:363, y: -74.5)
                      WhiteButton1.center = CGPoint(x:155, y: -74.5)
                      WhiteButton3.center = CGPoint(x:51, y: -74.5)
                      WhiteButton4.center = CGPoint(x:259, y: -74.5)
                    break
                  default:
                          break
                  }
                  
              }
              if(BlackButton8.center.y >= 968.5)
              {
                  let number : Int = Int(arc4random()) % 4
                  switch number {
                  case 0:
                      BlackButton8.center = CGPoint(x:51, y: -74.5)
                      WhiteButton5.center = CGPoint(x:155, y: -74.5)
                      WhiteButton6.center = CGPoint(x:259, y: -74.5)
                      WhiteButton7.center = CGPoint(x:363, y: -74.5)
                    break
                  case 1:
                      BlackButton8.center = CGPoint(x:155, y: -74.5)
                      WhiteButton5.center = CGPoint(x:51, y: -74.5)
                      WhiteButton6.center = CGPoint(x:259, y: -74.5)
                      WhiteButton7.center = CGPoint(x:363, y: -74.5)
                    break
                  case 2:
                      BlackButton8.center = CGPoint(x:259, y: -74.5)
                      WhiteButton5.center = CGPoint(x:155, y: -74.5)
                      WhiteButton6.center = CGPoint(x:51, y: -74.5)
                      WhiteButton7.center = CGPoint(x:363, y: -74.5)
                    break
                  case 3:
                      BlackButton8.center = CGPoint(x:363, y: -74.5)
                      WhiteButton5.center = CGPoint(x:155, y: -74.5)
                      WhiteButton6.center = CGPoint(x:51, y: -74.5)
                      WhiteButton7.center = CGPoint(x:259, y: -74.5)
                    break
                  default:
                          break
                  }
              }
              
              if(BlackButton9.center.y >= 968.5)
              {
                  let number : Int = Int(arc4random()) % 4
                  switch number {
                  case 0:
                      BlackButton9.center = CGPoint(x:51, y: -74.5)
                      WhiteButton10.center = CGPoint(x:155, y: -74.5)
                      WhiteButton11.center = CGPoint(x:259, y: -74.5)
                      WhiteButton12.center = CGPoint(x:363, y: -74.5)
                    break
                  case 1:
                      BlackButton9.center = CGPoint(x:155, y: -74.5)
                      WhiteButton10.center = CGPoint(x:51, y: -74.5)
                      WhiteButton11.center = CGPoint(x:259, y: -74.5)
                      WhiteButton12.center = CGPoint(x:363, y: -74.5)
                    break
                  case 2:
                      BlackButton9.center = CGPoint(x:259, y: -74.5)
                      WhiteButton10.center = CGPoint(x:155, y: -74.5)
                      WhiteButton11.center = CGPoint(x:51, y: -74.5)
                      WhiteButton12.center = CGPoint(x:363, y: -74.5)
                    break
                  case 3:
                      BlackButton9.center = CGPoint(x:363, y: -74.5)
                      WhiteButton10.center = CGPoint(x:155, y: -74.5)
                      WhiteButton11.center = CGPoint(x:51, y: -74.5)
                      WhiteButton12.center = CGPoint(x:259, y: -74.5)
                    break
                  default:
                          break
                  }
              }
              
              if(BlackButton15.center.y >= 968.5)
              {
                  let number : Int = Int(arc4random()) % 4
                  switch number {
                  case 0:
                      BlackButton15.center = CGPoint(x:51, y: -74.5)
                      WhiteButton13.center = CGPoint(x:155, y: -74.5)
                      WhiteButton14.center = CGPoint(x:259, y: -74.5)
                      WhiteButton16.center = CGPoint(x:363, y: -74.5)
                    break
                  case 1:
                      BlackButton15.center = CGPoint(x:155, y: -74.5)
                      WhiteButton13.center = CGPoint(x:51, y: -74.5)
                      WhiteButton14.center = CGPoint(x:259, y: -74.5)
                      WhiteButton16.center = CGPoint(x:363, y: -74.5)
                    break
                  case 2:
                      BlackButton15.center = CGPoint(x:259, y: -74.5)
                      WhiteButton13.center = CGPoint(x:155, y: -74.5)
                      WhiteButton14.center = CGPoint(x:51, y: -74.5)
                      WhiteButton16.center = CGPoint(x:363, y: -74.5)
                    break
                  case 3:
                      BlackButton15.center = CGPoint(x:363, y: -74.5)
                      WhiteButton13.center = CGPoint(x:155, y: -74.5)
                      WhiteButton14.center = CGPoint(x:51, y: -74.5)
                      WhiteButton16.center = CGPoint(x:259, y: -74.5)
                    break
                  default:
                          break
                  }
              }
              
              if(BlackButton20.center.y >= 968.5)
              {
                  let number : Int = Int(arc4random()) % 4
                  switch number {
                  case 0:
                      BlackButton20.center = CGPoint(x:51, y: -74.5)
                      WhiteButton17.center = CGPoint(x:155, y: -74.5)
                      WhiteButton18.center = CGPoint(x:259, y: -74.5)
                      WhiteButton19.center = CGPoint(x:363, y: -74.5)
                    break
                  case 1:
                      BlackButton20.center = CGPoint(x:155, y: -74.5)
                      WhiteButton17.center = CGPoint(x:51, y: -74.5)
                      WhiteButton18.center = CGPoint(x:259, y: -74.5)
                      WhiteButton19.center = CGPoint(x:363, y: -74.5)
                    break
                  case 2:
                      BlackButton20.center = CGPoint(x:259, y: -74.5)
                      WhiteButton17.center = CGPoint(x:155, y: -74.5)
                      WhiteButton18.center = CGPoint(x:51, y: -74.5)
                      WhiteButton19.center = CGPoint(x:363, y: -74.5)
                    break
                  case 3:
                      BlackButton20.center = CGPoint(x:363, y: -74.5)
                      WhiteButton17.center = CGPoint(x:155, y: -74.5)
                      WhiteButton18.center = CGPoint(x:51, y: -74.5)
                      WhiteButton19.center = CGPoint(x:259, y: -74.5)
                    break
                  default:
                          break
                  }
              }
              
              if(BlackButton23.center.y >= 968.5)
              {
                  let number : Int = Int(arc4random()) % 4
                  switch number {
                  case 0:
                      BlackButton23.center = CGPoint(x:51, y: -74.5)
                      WhiteButton21.center = CGPoint(x:155, y: -74.5)
                      WhiteButton22.center = CGPoint(x:259, y: -74.5)
                      WhiteButton24.center = CGPoint(x:363, y: -74.5)
                    break
                  case 1:
                      BlackButton23.center = CGPoint(x:155, y: -74.5)
                      WhiteButton21.center = CGPoint(x:51, y: -74.5)
                      WhiteButton22.center = CGPoint(x:259, y: -74.5)
                      WhiteButton24.center = CGPoint(x:363, y: -74.5)
                    break
                  case 2:
                      BlackButton23.center = CGPoint(x:259, y: -74.5)
                      WhiteButton21.center = CGPoint(x:155, y: -74.5)
                      WhiteButton22.center = CGPoint(x:51, y: -74.5)
                      WhiteButton24.center = CGPoint(x:363, y: -74.5)
                    break
                  case 3:
                      BlackButton23.center = CGPoint(x:363, y: -74.5)
                      WhiteButton21.center = CGPoint(x:155, y: -74.5)
                      WhiteButton22.center = CGPoint(x:51, y: -74.5)
                      WhiteButton24.center = CGPoint(x:259, y: -74.5)
                    break
                  default:
                          break
                  }
              }
            if(BlackButton26.center.y >= 968.5)
            {
                let number : Int = Int(arc4random()) % 4
                switch number {
                case 0:
                    BlackButton26.center = CGPoint(x:51, y: -74.5)
                    WhiteButton25.center = CGPoint(x:155, y: -74.5)
                    WhiteButton27.center = CGPoint(x:259, y: -74.5)
                    WhiteButton28.center = CGPoint(x:363, y: -74.5)
                    break
                case 1:
                    BlackButton26.center = CGPoint(x:155, y: -74.5)
                    WhiteButton25.center = CGPoint(x:51, y: -74.5)
                    WhiteButton27.center = CGPoint(x:259, y: -74.5)
                    WhiteButton28.center = CGPoint(x:363, y: -74.5)
                    break
                case 2:
                    BlackButton26.center = CGPoint(x:259, y: -74.5)
                    WhiteButton25.center = CGPoint(x:155, y: -74.5)
                    WhiteButton27.center = CGPoint(x:51, y: -74.5)
                    WhiteButton28.center = CGPoint(x:363, y: -74.5)
                    break
                case 3:
                    BlackButton26.center = CGPoint(x:363, y: -74.5)
                    WhiteButton25.center = CGPoint(x:155, y: -74.5)
                    WhiteButton27.center = CGPoint(x:51, y: -74.5)
                    WhiteButton28.center = CGPoint(x:259, y: -74.5)
                    break
                default:
                        break
                }
            }
              
          }

      }
    @IBAction func Pressed23Black(_ sender: UIButton) 
    {

          if(BlackButton23.center.y == 819.5)
          {
            if(flagforSoundeffects == true)
            {
                let pianoSound = Bundle.main.path(forResource: "seventhSound", ofType: "wav")!
                let url = URL(fileURLWithPath: pianoSound)




                do {
                     audioPlayer = try AVAudioPlayer(contentsOf: url)
                     audioPlayer?.play()
                } catch {
                    print("Error in audio playing occurred")
                }
            }
            
            
            score+=1
            let input:Int = (HighestScore.text! as NSString).integerValue
            if(score > input)
            {
                HighestScoreV = score
            
            }else{
                HighestScoreV = input
            }
            
            let HighScoreSave = HighestScoreV
            let ScoreSave = score
            
            let userDefaults = Foundation.UserDefaults.standard
            userDefaults.set(HighScoreSave, forKey: "Key")
            userDefaults.set(ScoreSave, forKey: "Keys")
            
            let valueS = userDefaults.string(forKey: "Keys")
            let value = userDefaults.string(forKey: "Key")
            
            HighestScore.text = value
            ScoreLabel.text = valueS
            BB = [BlackButton2, WhiteButton1, WhiteButton3,WhiteButton4,
                    BlackButton8, WhiteButton5, WhiteButton6,WhiteButton7,
                    BlackButton9, WhiteButton10, WhiteButton11, WhiteButton12,
                    BlackButton15, WhiteButton13, WhiteButton14, WhiteButton16,
                    BlackButton20, WhiteButton17, WhiteButton18, WhiteButton19,
                    BlackButton23, WhiteButton21, WhiteButton22, WhiteButton24,
                    BlackButton26, WhiteButton25, WhiteButton27, WhiteButton28
                   
              ]
              for score in BB
              {
                  //print(score)
                  score.center = CGPoint (x:score.center.x, y:score.center.y + 149)
              }
             
          
              if(BlackButton2.center.y >= 968.5)
              {
                  let number : Int = Int(arc4random()) % 4
                  switch number {
                  case 0:
                      BlackButton2.center = CGPoint(x:51, y: -74.5)
                      WhiteButton1.center = CGPoint(x:155, y: -74.5)
                      WhiteButton3.center = CGPoint(x:259, y: -74.5)
                      WhiteButton4.center = CGPoint(x:363, y: -74.5)
                    break
                  case 1:
                      BlackButton2.center = CGPoint(x:155, y: -74.5)
                      WhiteButton1.center = CGPoint(x:51, y: -74.5)
                      WhiteButton3.center = CGPoint(x:259, y: -74.5)
                      WhiteButton4.center = CGPoint(x:363, y: -74.5)
                    break
                  case 2:
                      BlackButton2.center = CGPoint(x:259, y: -74.5)
                      WhiteButton1.center = CGPoint(x:155, y: -74.5)
                      WhiteButton3.center = CGPoint(x:51, y: -74.5)
                      WhiteButton4.center = CGPoint(x:363, y: -74.5)
                    break
                  case 3:
                      BlackButton2.center = CGPoint(x:363, y: -74.5)
                      WhiteButton1.center = CGPoint(x:155, y: -74.5)
                      WhiteButton3.center = CGPoint(x:51, y: -74.5)
                      WhiteButton4.center = CGPoint(x:259, y: -74.5)
                    break
                  default:
                          break
                  }
                  
              }
              if(BlackButton8.center.y >= 968.5)
              {
                  let number : Int = Int(arc4random()) % 4
                  switch number {
                  case 0:
                      BlackButton8.center = CGPoint(x:51, y: -74.5)
                      WhiteButton5.center = CGPoint(x:155, y: -74.5)
                      WhiteButton6.center = CGPoint(x:259, y: -74.5)
                      WhiteButton7.center = CGPoint(x:363, y: -74.5)
                    break
                  case 1:
                      BlackButton8.center = CGPoint(x:155, y: -74.5)
                      WhiteButton5.center = CGPoint(x:51, y: -74.5)
                      WhiteButton6.center = CGPoint(x:259, y: -74.5)
                      WhiteButton7.center = CGPoint(x:363, y: -74.5)
                    break
                  case 2:
                      BlackButton8.center = CGPoint(x:259, y: -74.5)
                      WhiteButton5.center = CGPoint(x:155, y: -74.5)
                      WhiteButton6.center = CGPoint(x:51, y: -74.5)
                      WhiteButton7.center = CGPoint(x:363, y: -74.5)
                    break
                  case 3:
                      BlackButton8.center = CGPoint(x:363, y: -74.5)
                      WhiteButton5.center = CGPoint(x:155, y: -74.5)
                      WhiteButton6.center = CGPoint(x:51, y: -74.5)
                      WhiteButton7.center = CGPoint(x:259, y: -74.5)
                    break
                  default:
                          break
                  }
              }
              
              if(BlackButton9.center.y >= 968.5)
              {
                  let number : Int = Int(arc4random()) % 4
                  switch number {
                  case 0:
                      BlackButton9.center = CGPoint(x:51, y: -74.5)
                      WhiteButton10.center = CGPoint(x:155, y: -74.5)
                      WhiteButton11.center = CGPoint(x:259, y: -74.5)
                      WhiteButton12.center = CGPoint(x:363, y: -74.5)
                    break
                  case 1:
                      BlackButton9.center = CGPoint(x:155, y: -74.5)
                      WhiteButton10.center = CGPoint(x:51, y: -74.5)
                      WhiteButton11.center = CGPoint(x:259, y: -74.5)
                      WhiteButton12.center = CGPoint(x:363, y: -74.5)
                    break
                  case 2:
                      BlackButton9.center = CGPoint(x:259, y: -74.5)
                      WhiteButton10.center = CGPoint(x:155, y: -74.5)
                      WhiteButton11.center = CGPoint(x:51, y: -74.5)
                      WhiteButton12.center = CGPoint(x:363, y: -74.5)
                    break
                  case 3:
                      BlackButton9.center = CGPoint(x:363, y: -74.5)
                      WhiteButton10.center = CGPoint(x:155, y: -74.5)
                      WhiteButton11.center = CGPoint(x:51, y: -74.5)
                      WhiteButton12.center = CGPoint(x:259, y: -74.5)
                    break
                  default:
                          break
                  }
              }
              
              if(BlackButton15.center.y >= 968.5)
              {
                  let number : Int = Int(arc4random()) % 4
                  switch number {
                  case 0:
                      BlackButton15.center = CGPoint(x:51, y: -74.5)
                      WhiteButton13.center = CGPoint(x:155, y: -74.5)
                      WhiteButton14.center = CGPoint(x:259, y: -74.5)
                      WhiteButton16.center = CGPoint(x:363, y: -74.5)
                    break
                  case 1:
                      BlackButton15.center = CGPoint(x:155, y: -74.5)
                      WhiteButton13.center = CGPoint(x:51, y: -74.5)
                      WhiteButton14.center = CGPoint(x:259, y: -74.5)
                      WhiteButton16.center = CGPoint(x:363, y: -74.5)
                    break
                  case 2:
                      BlackButton15.center = CGPoint(x:259, y: -74.5)
                      WhiteButton13.center = CGPoint(x:155, y: -74.5)
                      WhiteButton14.center = CGPoint(x:51, y: -74.5)
                      WhiteButton16.center = CGPoint(x:363, y: -74.5)
                    break
                  case 3:
                      BlackButton15.center = CGPoint(x:363, y: -74.5)
                      WhiteButton13.center = CGPoint(x:155, y: -74.5)
                      WhiteButton14.center = CGPoint(x:51, y: -74.5)
                      WhiteButton16.center = CGPoint(x:259, y: -74.5)
                    break
                  default:
                          break
                  }
              }
              
              if(BlackButton20.center.y >= 968.5)
              {
                  let number : Int = Int(arc4random()) % 4
                  switch number {
                  case 0:
                      BlackButton20.center = CGPoint(x:51, y: -74.5)
                      WhiteButton17.center = CGPoint(x:155, y: -74.5)
                      WhiteButton18.center = CGPoint(x:259, y: -74.5)
                      WhiteButton19.center = CGPoint(x:363, y: -74.5)
                    break
                  case 1:
                      BlackButton20.center = CGPoint(x:155, y: -74.5)
                      WhiteButton17.center = CGPoint(x:51, y: -74.5)
                      WhiteButton18.center = CGPoint(x:259, y: -74.5)
                      WhiteButton19.center = CGPoint(x:363, y: -74.5)
                    break
                  case 2:
                      BlackButton20.center = CGPoint(x:259, y: -74.5)
                      WhiteButton17.center = CGPoint(x:155, y: -74.5)
                      WhiteButton18.center = CGPoint(x:51, y: -74.5)
                      WhiteButton19.center = CGPoint(x:363, y: -74.5)
                    break
                  case 3:
                      BlackButton20.center = CGPoint(x:363, y: -74.5)
                      WhiteButton17.center = CGPoint(x:155, y: -74.5)
                      WhiteButton18.center = CGPoint(x:51, y: -74.5)
                      WhiteButton19.center = CGPoint(x:259, y: -74.5)
                    break
                  default:
                          break
                  }
              }
              
              if(BlackButton23.center.y >= 968.5)
              {
                  let number : Int = Int(arc4random()) % 4
                  switch number {
                  case 0:
                      BlackButton23.center = CGPoint(x:51, y: -74.5)
                      WhiteButton21.center = CGPoint(x:155, y: -74.5)
                      WhiteButton22.center = CGPoint(x:259, y: -74.5)
                      WhiteButton24.center = CGPoint(x:363, y: -74.5)
                    break
                  case 1:
                      BlackButton23.center = CGPoint(x:155, y: -74.5)
                      WhiteButton21.center = CGPoint(x:51, y: -74.5)
                      WhiteButton22.center = CGPoint(x:259, y: -74.5)
                      WhiteButton24.center = CGPoint(x:363, y: -74.5)
                    break
                  case 2:
                      BlackButton23.center = CGPoint(x:259, y: -74.5)
                      WhiteButton21.center = CGPoint(x:155, y: -74.5)
                      WhiteButton22.center = CGPoint(x:51, y: -74.5)
                      WhiteButton24.center = CGPoint(x:363, y: -74.5)
                    break
                  case 3:
                      BlackButton23.center = CGPoint(x:363, y: -74.5)
                      WhiteButton21.center = CGPoint(x:155, y: -74.5)
                      WhiteButton22.center = CGPoint(x:51, y: -74.5)
                      WhiteButton24.center = CGPoint(x:259, y: -74.5)
                    break
                  default:
                          break
                  }
              }
            if(BlackButton26.center.y >= 968.5)
            {
                let number : Int = Int(arc4random()) % 4
                switch number {
                case 0:
                    BlackButton26.center = CGPoint(x:51, y: -74.5)
                    WhiteButton25.center = CGPoint(x:155, y: -74.5)
                    WhiteButton27.center = CGPoint(x:259, y: -74.5)
                    WhiteButton28.center = CGPoint(x:363, y: -74.5)
                    break
                case 1:
                    BlackButton26.center = CGPoint(x:155, y: -74.5)
                    WhiteButton25.center = CGPoint(x:51, y: -74.5)
                    WhiteButton27.center = CGPoint(x:259, y: -74.5)
                    WhiteButton28.center = CGPoint(x:363, y: -74.5)
                    break
                case 2:
                    BlackButton26.center = CGPoint(x:259, y: -74.5)
                    WhiteButton25.center = CGPoint(x:155, y: -74.5)
                    WhiteButton27.center = CGPoint(x:51, y: -74.5)
                    WhiteButton28.center = CGPoint(x:363, y: -74.5)
                    break
                case 3:
                    BlackButton26.center = CGPoint(x:363, y: -74.5)
                    WhiteButton25.center = CGPoint(x:155, y: -74.5)
                    WhiteButton27.center = CGPoint(x:51, y: -74.5)
                    WhiteButton28.center = CGPoint(x:259, y: -74.5)
                    break
                default:
                        break
                }
            }
              
          }

         
      }
    
    @IBOutlet weak var SecondButtomInModal: UIButton!//Second button in modal
    
    //In case if we press the continue, we set the flag on true
    //And increase the counter on 2(if it is 2 or more, no continues will
    //be available
    @IBAction func ContinueButton(_ sender: UIButton) {
        flagForcon = true
        intForcon += 2
   

    }
    //The restart button will set to default variables
    //All of the values the description of which
    //We can find above
    //This restart button is available from the "game over"
    //Window of classic game mode
    @IBAction func RestartButton(_ sender: UIButton) {
        counterforMintimer = 0
        counterInval = true
        intForcon = 0
        counterforMintimer1 = 0
        counTera = 0
        counTer = 3
    }
    //The diffrences  is the variable "counterforMintimer",
    //1 or 0 will influence on timers
    
    //The restart button will set to default variables
    //All of the values the description of which
    //We can find above
    //This restart button is available from the "game over"
    //Window of classic game mode
    @IBAction func restartButton2(_ sender: UIButton) {
        counterforMintimer = 1
        counterInval = true
        intForcon = 0
        counterforMintimer1 = 0
        counTera = 0
        counTer = 3
    }
    //The GIF image view
    @IBOutlet weak var GifImageView: UIImageView!
  
    
    
    //Show the lose with gif(last view)
    @IBAction func ShowGif(_ sender: Any) {
        //If time mode is on
        if(flagForgamemode == true)
        {
            //In case if we lose in timer mode,
            //Open the appropriate window
            if(counterforMintimer1 == 3)
            {
                //Invalidate timers
                self.countTimer?.invalidate()
                self.countTimer = nil
                //Set counter to 0 and open a window(view)
                //Named "ViewfromTimemode"
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let secondVC = storyboard.instantiateViewController(identifier: "ViewfromTimemode")
                secondVC.modalPresentationStyle = .fullScreen
                secondVC.modalTransitionStyle = .crossDissolve
                counTer = 0
                show(secondVC, sender: self)
            }

        }
        else
        {
            //If classic mode is on
            //In case if we played only once,
            //The option for continuing will appear
            if(intForcon == 0)
            {
                counTer = 1
            }
            //Set watch video counter to 3
            counTera = 3
            //Set the flag for continuing is false
            counterInval = false

        }

    }
    //This function were created for second timer
    @IBAction func changeModebutton(_ sender: UIButton) {
        counterforMintimer = 1
    }

    
    @IBOutlet weak var WaitForButtonButton: UIButton!//First button in modal view(for continuing)
    
    @IBAction func WaitForButton(_ sender: UIButton) {//First button in modal view(for continuing)

        
                
    }
    
    //The timer function
    @objc func changeTitle()
    {
            //In case of any running timers,
            //Invalidate them
            if(counterInval == true)
            {
            
                 self.countTimer?.invalidate()
                 self.countTimer = nil
                 counterInval = false
                 //Set the appropriate counters and flags
                 counTera = 3//(seconds)
                 counTer = 1
    
            }
            //If timer is not 0, do countdown
            if counTera != 0
            {
                WaitForButtonButton?.setTitle("\(counTera)", for: .normal)
                counTera -= 1
                
            }
            //When timer is finished
            else
            {
                 //Invalidate and set the labels of timer
                 //somewhere away, instead of that button(which
                 //was not clickable)place the clickable button.
                 //That button will continue the game
                 self.countTimer?.invalidate()//20 183
                 WaitForButtonButton?.center = CGPoint(x: -200, y : -183)//First button in modal view
                 SecondButtomInModal?.center = CGPoint(x: 205, y : 305)//Second view in modal
                 WaitForButtonButton?.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.1882352941, blue: 0.1882352941, alpha: 1)
                 self.countTimer = nil
            }

        //}
        
    
    }
    //Absolutely the same is done here,
    //The diffrence is the time(59 seconds instead of 3)
    //Also when the timer is over, the new window will apear
    //("game over" window for time mode)
    @objc func change1minTitle()
    {

           if(counterInval == true)
           {
          
               self.countTimer?.invalidate()
               self.countTimer = nil
               counterInval = false
               oneMintimer = 59
          
           }
            if(oneMintimer != 0)
            {
                
                counterforMintimer = 3
                timercountDownlabel?.text = "\(oneMintimer)"
                oneMintimer -= 1
               

               
     
            }
            else
            {
                   self.countTimer?.invalidate()
                   self.countTimer = nil
                   let storyboard = UIStoryboard(name: "Main", bundle: nil)
                   let secondVC = storyboard.instantiateViewController(identifier: "ViewfromTimemode")
                   secondVC.modalPresentationStyle = .fullScreen
                   secondVC.modalTransitionStyle = .crossDissolve
                   show(secondVC, sender: self)
            }
       // }
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //Getting the switch actual state
        let defaults = UserDefaults.standard
        if(defaults.object(forKey: "SwitchState") != nil)
        {
            titletoSaveswitcherstate?.isOn = defaults.bool(forKey: "SwitchState")
            flagforSoundeffects = defaults.bool(forKey: "SwitchState")
        }

        //Invalidate timer in case if we have some
        self.countTimer?.invalidate()
        //Set counter for null
        self.countTimer = nil
        
        //In case if we have some timers running now
        //Invalidate them and set appropriate counters
        //To appropriate values
        if(counterInval == true && helper == 1)
         {
             self.countTimer?.invalidate()
             self.countTimer = nil
             counTera = 3
             counterInval = false
       
            
         }
        if(counTer == 1 && helper == 1)
        {
           
             //Setting the gif
             GifImageView?.image = UIImage.gif(name: "ca_vut")
             counTer = 0
            

            

             //Start the timer
             //Timer is uses the function that is
             //Written next to "#selector(self"
             self.countTimer = Timer.scheduledTimer(timeInterval: 1 ,
                                                          target: self,
                                                          selector: #selector(self.changeTitle),
                                                          userInfo: nil,
                                                          repeats: true)
            




        }
        if(counterInval == true && helper == 33)
         {
             //In case if any timers run now
             //Invalidate it
             self.countTimer?.invalidate()
             //Set the counter timer for null
             self.countTimer = nil
             //Set time for 59 seconds
             oneMintimer = 59
             //Set counter identifer for false(don't init
             //The same timer twice)
             counterInval = false
             //Set counter for 1(init timer in lines below)
             counterforMintimer = 1
             
            
         }
        if(counterforMintimer == 1 && helper == 33)
        {
            //Set the timer time for 59 seconds
            oneMintimer = 59
            //Set the counter for 0(don't init the same timer twice)
            counterforMintimer = 0
            //Set the second timer counter for 3(show the "game over" for time mode
            counterforMintimer1 = 3
            //Init the timer
            self.countTimer = Timer.scheduledTimer(timeInterval: 1 ,
                                                         target: self,
                                                         selector: #selector(self.change1minTitle),
                                                         userInfo: nil,
                                                         repeats: true)
            
        }

    }
    
    //The helper random float number generator
    //For the function below(will help to generate number color
    func randomCGFloat() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
    
    //The function that is generating random colors
    //Will be used to generate random color for main
    //page's highscore
    func randomColor() -> UIColor {
        let r = randomCGFloat()
        let g = randomCGFloat()
        let b = randomCGFloat()

        // If you wanted a random alpha, just create another
        // random number for that too.
        return UIColor(red: r, green: g, blue: b, alpha: 1)
    }

    //This button from settings will try to send mail,on author's email(MINE)
    @IBAction func openEmailbutton(_ sender: UIButton) {
        let email = "rulik-a@mail.ru"//My email
        if let url = URL(string: "mailto:\(email)") {
          if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
          } else {
            UIApplication.shared.openURL(url)
          }
        }
    }
    
    
    //Label to Save switcher state
    @IBOutlet weak var titletoSaveswitcherstate: UISwitch!
    //This function will turn on or off all of the sound effects in the game
    @IBAction func turnOffthesoundeffects(_ sender: UISwitch) {
        //Declaring "UserDefaults" for saving the state of switch
        let defaults = UserDefaults.standard
        //If switch is on, save the state and set the flag that will
        //indicate whether the sounds should heard on true
        if(titletoSaveswitcherstate.isOn)
        {
            flagforSoundeffects = true
            defaults.set(true, forKey: "SwitchState")
        }
        //Same processes here in case of switch is turned off
        else
        {
             flagforSoundeffects = false
             defaults.set(false, forKey: "SwitchState")
        }

        
        

              
          
    }
    @IBOutlet weak var InitHighScoreButton: UIButton!
    
    //This function will change the color of the
    //highscore's button on the main page(on click)
    @IBAction func InitButtonHighScore(_ sender: UIButton) {
        InitHighScoreButton?.setTitleColor(randomColor(), for: .normal)
    }
    
    //Label for timer countndown(second modal view,button 22)
    @IBOutlet weak var timercountDownlabel: UILabel!
    
   
    //The button for reseting high score
    @IBAction func ResetHighscore(_ sender: UIButton) {
        //Set high score to 0
        let HighScoreSave = 0
        //Declare "userDefaults" for saving the highscore for future
        let userDefaults = Foundation.UserDefaults.standard
        //Save the new highscore
        userDefaults.set(HighScoreSave, forKey: "Key")
        //Set the title in the main menu on 0
        InitHighScoreButton?.setTitle("0", for: .normal)
        
    }
    override func viewWillAppear(_ animated: Bool) {




        //Set timer on 22 button
        if(flagForgamemode == true)// according to selected game mode
        {
            //Flag for one minute counter is set on 0
            counterforMintimer = 1
            //The countdown timer is now on button 22
            timercountDownlabel?.center = CGPoint(x: 156, y: 85.5)
            //The label for countdown is on button 22
            labelFortimer?.center = CGPoint(x: 142, y: 11)
            //Set the text of button to mode(time mode)
            modeChangeoutlet?.setTitle("GAME MODE: TIME", for: .normal)
            //Set the color of button on green
            modeChangeoutlet?.setTitleColor(UIColor(red: 0/255, green: 255/255, blue: 0/255, alpha: 1.0), for: .normal)



        }
        else
        {
            //Flag for one minute counter is set on 0
            counterforMintimer = 0
            //Move countdown label(illusion of vanishing)
            timercountDownlabel?.center = CGPoint(x: -142, y: -11)
            //Move timer label(same illusion)
            labelFortimer?.center = CGPoint(x: -110, y: -50)
            //Set game mode for classic(text)
            modeChangeoutlet?.setTitle("GAME MODE: CLASSIC", for: .normal)
            //The color of "CLASSIC MODE" will be red
            modeChangeoutlet?.setTitleColor(#colorLiteral(red: 0.9411764706, green: 0.1882352941, blue: 0.1882352941, alpha: 1) ,for: .normal)
        }
        
        //Get values from saved values for highscore
        //Change the text font for diffrent number(big font
        //for 1 number, smaller for 5 numbers)
        let userDefaults = Foundation.UserDefaults.standard
        let value = userDefaults.string(forKey: "Key")
        if let value = value{
            if(value.count == 1)
            {
                InitHighScoreButton?.titleLabel?.font = UIFont.boldSystemFont(ofSize: 245)
            }
            if(value.count == 2)
            {
                InitHighScoreButton?.titleLabel?.font = UIFont.boldSystemFont(ofSize: 245)
            }
            if(value.count == 3)
            {
                InitHighScoreButton?.titleLabel?.font = UIFont.boldSystemFont(ofSize: 200)
            }
            if(value.count == 4)
            {
                InitHighScoreButton?.titleLabel?.font = UIFont.boldSystemFont(ofSize: 150)
            }
            if(value.count == 5)
            {
                InitHighScoreButton?.titleLabel?.font = UIFont.boldSystemFont(ofSize: 118)
            }
            else//In case of 99999 score, score is set to 0
            {
                InitHighScoreButton?.setTitle("0", for: .normal)
            }
        }
        InitHighScoreButton?.setTitle(value, for: .normal)

        HighestScore?.text = value
        
        //If the amount of repetitions, were more than 1
        //change the location of gifs and buttons for repetition
        //(for both modes(0 repetition in time mode, 1 repetition for classic mode)
        if(intForcon >= 2)
        {
            WaitForButtonButton?.center = CGPoint(x: -200, y:-200)
            GifImageView?.center = CGPoint(x: -200, y: -200)
            secLifebutton?.center = CGPoint(x: -200, y: -200)
        }
        //In case if flag for continuing is set,
        //save the score(for classic mode)
        if(flagForcon == true)
        {
            let valueS = userDefaults.string(forKey: "Keys")
            ScoreLabel.text = valueS
            flagForcon = false
        }
  
        
    }

}
