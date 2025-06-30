import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var leftButton : LeftButton?
    var rightButton : RightButton?
    var rotationButton : RotationButton?
    var downButton : DownButton?
    var stopButton : StopButton?
    var sounds : Sounds?
    var updateTime = 0.0
    
    override func didMove(to view: SKView) {
        setting()
        
    }
    
    func setting()
    {
        // . 했는데 이후에 내가 원하는거 안나왔을떄는 Command + b 하면 나온다
        Variables.scene = self
        
        // 메인클래스인 이곳에 Background 인스턴스 생성
        _ = BackGround()
        NextBricks().addBrick()
        _ = BrickGenerator()
        
        // 이동버튼
        leftButton = LeftButton()
        rightButton = RightButton()
        rotationButton = RotationButton()
        downButton = DownButton()
        stopButton = StopButton()
        sounds = Sounds()
        lightEffect()
    }
    
    func lightEffect()
    {
        let light = SKLightNode()
        light.position = CGPoint(x: Int(view!.frame.width) / 2, y: -100)
        light.ambientColor = .white
        light.lightColor = .white
        light.categoryBitMask = 0b0001
        addChild(light)
    }
    
    override func update(_ currentTime: TimeInterval)
    {
        // 블럭 자동으로 내려가도록
        if updateTime == 0
        {
            updateTime = currentTime
        }
        
        // 1초단위로 내려가도록 했음
        if currentTime - updateTime > 1
        {
            updateTime = currentTime
            if !Variables.isPouse
            {
                downButton?.brickDown()
            }
        }
    }
    
    // 이동 버튼 눌렀을때 움직이도록
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let location = touch?.location(in: self)
        let node = nodes(at: location!)
        for item in node
        {
            if item.name == "left"
            {
                leftButton?.brickMoveLeft()
                sounds?.buttonSounds(buttonName: "move")
            }
            if item.name == "right"
            {
                rightButton?.brickMoveRight()
                sounds?.buttonSounds(buttonName: "move")
            }
            if item.name == "rotation"
            {
                rotationButton?.brickRotation()
                sounds?.buttonSounds(buttonName: "rotation")
            }
            if item.name == "down"
            {
                while (downButton?.isbrickDownable())!
                {
                    downButton?.brickDown()
                }
                sounds?.buttonSounds(buttonName: "down")
                downButton?.anim()
            }
            if item.name == "stop"
            {
                stopButton?.brickStop()
                if !Variables.isPouse
                {
                    sounds?.soundPlay()
                }
                else
                {
                    sounds?.soundStop()
                }
            }
        }
    }
    
   
}
