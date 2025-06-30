import Foundation
import AVKit

class Sounds
{
    var bgSound : AVAudioPlayer!
    var buttonSound : AVAudioPlayer!
    
    init()
    {
        if let url = Bundle.main.path(forResource: "bg_sound", ofType: "mp3")
        {
            do
            {
                bgSound = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: url))
            }
            catch
            {
                print("error")
            }
            bgSound.volume = 0.5
            bgSound.numberOfLoops = -1
            bgSound.play()
        }
    }
    
    func buttonSounds(buttonName : String)
    {
        if let url = Bundle.main.path(forResource: buttonName, ofType: "mp3")
        {
            do
            {
                buttonSound = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: url))
            }
            catch
            {
                print("error")
            }
            buttonSound.volume = 1
            buttonSound.numberOfLoops = 0
            buttonSound.play()
        }
    }
    
    func soundStop()
    {
        bgSound.pause()
    }
    
    func soundPlay()
    {
        bgSound.play()
    }
}
