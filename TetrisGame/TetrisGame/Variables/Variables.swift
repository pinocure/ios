// 전역변수들 모아놓는곳
import Foundation
import SpriteKit

struct Variables
{
    static var backarrays = [[Int]]()
    static var scene = SKScene()
    static var brickValue = Brick().bricks()
    
    // 처음 시작하는 위치
    static var dx = 4
    static var dy = 2
    static var gab = 1
    
    static var startPoint = CGPoint()
    static var brickArrays = Array<CGPoint>()
    static var brickNode = Array<SKSpriteNode>()
    
    // 최종적으로 움직이지 못하는 블록들
    static var blockedArrays = Array<SKSpriteNode>()
    
    static var isPouse = false
    static var nodeGroup = [[SKSpriteNode]]()
    
    
    // 새로운 배열
    static var newBrickArrays = [Brick.Bricks]()
    
    // row, col 값 변경할때 사용하도록
    static let row = 10
    static let col = 20
}
