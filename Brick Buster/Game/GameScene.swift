//
//  GameScene.swift
//  GameProduct
//
//  Created by Zhihao Qin on 10/14/20.
//  Copyright © 2020 Zhihao Qin. All rights reserved.
//

import SpriteKit
import GameplayKit

let GameMessageName = "gameMessage"

class GameScene: SKScene {
    var contentCreated = false
    var gameViewController:GameViewController?
    lazy var gameState: GKStateMachine = GKStateMachine(states: [
      WaitingForStart(scene: self), PlayingGame(scene: self), GameOver(scene: self)])
    private var remainingBrickNum = 0
    private var remainingBallNum = 1
    private var paddle:Paddle?
    private var balls = [Ball]()
    private var bricks = [Brick]()
    private var brickWidth = 100
    private var brickHeight = 20
    private var ballRadius = 5
    private var map: [[Int]]?
    var isFingerOnPaddle = false
    private var gameWon : Bool = false {
      didSet {
        let gameOver = childNode(withName: GameMessageName) as! SKSpriteNode
        let textureName = gameWon ? "YouWon" : "GameOver"
        let texture = SKTexture(imageNamed: textureName)
        let actionSequence = SKAction.sequence([SKAction.setTexture(texture),
          SKAction.scale(to: 1.0, duration: 0.25)])
        
        gameOver.run(actionSequence)
      }
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        
        self.map = [[]]
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
    }
    
    init(size: CGSize, map: [[Int]]){
        super.init(size: size)
        
        self.map = map;
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
    }
    
    init(size: CGSize, map: [[Int]], gameViewController: GameViewController){
        super.init(size: size)
        
        self.map = map;
        self.gameViewController = gameViewController
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMove(to view: SKView) {
        if !contentCreated {
            createContent()
            contentCreated = true
        }
    }

    func createBall(position : CGPoint) -> Ball {
        //create ball
        let ball = Ball(circleOfRadius: CGFloat(self.ballRadius))
        ball.setShape(radius: self.ballRadius)
        ball.position = position
        
        //animation
        let fireNode = SKNode()
        fireNode.zPosition = 1
        addChild(fireNode)
        let fire = SKEmitterNode(fileNamed: "Fire")!
        fire.targetNode = fireNode
        ball.addChild(fire)
        
        //append ball
        balls.append(ball)
        addChild(ball)
        return ball
    }
    
    private func createContent() {
        let background = SKSpriteNode(imageNamed: "bg1")
        background.zPosition = -1
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        background.size = CGSize(width: self.size.width, height: self.size.height)
        addChild(background)
        
        //create ground
        let ground = SKSpriteNode(color: .gray, size: CGSize(width: size.width, height: size.height/10))
        ground.position = CGPoint(x: size.width / 2, y: 0)
        ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size)
        ground.physicsBody?.isDynamic = false
        ground.physicsBody?.collisionBitMask = BitMask.Ball | BitMask.Prop
        ground.physicsBody?.categoryBitMask = BitMask.Ground
        ground.physicsBody?.contactTestBitMask = BitMask.Ball | BitMask.Prop
        ground.physicsBody?.restitution = 1.0
        ground.physicsBody?.friction = 0.0
        addChild(ground)

        //create wall
        let wall = SKNode()
        wall.position = CGPoint(x: 0, y: 0)
        wall.physicsBody?.restitution = 1.0
        wall.physicsBody?.collisionBitMask = BitMask.Wall
        wall.physicsBody?.categoryBitMask = BitMask.Wall
        wall.physicsBody?.contactTestBitMask = BitMask.Wall
        wall.physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        wall.physicsBody?.friction = 0.0
        addChild(wall)
        
        //create ball
        for _ in 0..<remainingBallNum {
            createBall(position: CGPoint(x: 100, y: 105))
        }
        
        //create brick
        self.createBricks()
        
        //create paddle
        self.paddle = Paddle()
        self.paddle!.position = CGPoint(x: 100, y: 100)
        addChild(paddle!)
        
        //create game message
        let gameMessage = SKSpriteNode(imageNamed: "TapToPlay")
        gameMessage.name = GameMessageName
        gameMessage.position = CGPoint(x: frame.midX, y: frame.midY)
        gameMessage.setScale(0.0)
        addChild(gameMessage)
        
        gameState.enter(WaitingForStart.self)
    }
    
    private func createBricks(){
        if self.map!.count == 0 || self.map![0].count == 0{
            return
        }
        
        let bricksHeightNum = self.map!.count
        let bricksWidthNum = self.map![0].count
        
        let leftBoarder = 50
        let rightBoarder = 20
        let upBoarder = 20
        let downBoarder = 100
        
        
        self.brickWidth = (Int(size.width) - leftBoarder - rightBoarder)/bricksWidthNum
        self.brickHeight = (Int(size.height) - upBoarder - downBoarder)/bricksHeightNum
        if self.brickHeight > 20 {
            self.brickHeight = 20
        }
        
        print("brickWidth:\(self.brickWidth), brickHeight:\(self.brickHeight)")
        
        //create bricks
        for i in 0..<bricksHeightNum {
            let brickList = self.map![i]
            let yPosition = Float(size.height) - Float(upBoarder) - (Float(i) + 0.5)*Float(self.brickHeight)
            for j in 0..<bricksWidthNum{
                if brickList[j] != 0{
                    let xPosition = Float(leftBoarder) + (Float(j) - 0.5)*Float(self.brickWidth)
                                        
                    //create brick
                    let brick = Brick(rectOf: CGSize(width: self.brickWidth, height: self.brickHeight))
                    brick.position = CGPoint(x: Int(xPosition), y: Int(yPosition))

                    //append brick
                    bricks.append(brick)
                    addChild(brick)
                    self.remainingBrickNum += 1
                }
            }
        }
    }
}


extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        //check if ball hit brick
        if contact.bodyA.categoryBitMask == BitMask.Brick && contact.bodyB.categoryBitMask == BitMask.Ball {
            ballHitBrick(contact.bodyA.node)
            return
        }
        if contact.bodyA.categoryBitMask == BitMask.Ball && contact.bodyB.categoryBitMask == BitMask.Brick {
            ballHitBrick(contact.bodyB.node)
            return
        }
        
        //check if ball hit ground
        if contact.bodyA.categoryBitMask == BitMask.Ground && contact.bodyB.categoryBitMask == BitMask.Ball {
            ballHitGround(contact.bodyB.node)
            return
        }
        if contact.bodyA.categoryBitMask == BitMask.Ball && contact.bodyB.categoryBitMask == BitMask.Ground {
            ballHitGround(contact.bodyA.node)
            return
        }
        
        let firstBody: SKPhysicsBody
        let secondBody: SKPhysicsBody

        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }

        // prop hits paddle
        if (firstBody.categoryBitMask == BitMask.Paddle) && (secondBody.categoryBitMask == BitMask.Prop) {
            paddleHitProp(paddle: firstBody.node, prop: secondBody.node)
        }
        
        // prop hits ground
        if (firstBody.categoryBitMask == BitMask.Ground) && (secondBody.categoryBitMask == BitMask.Prop) {
            propHitGround(secondBody.node)
        }
        
    }

//    func didEnd(_ contact: SKPhysicsContact) {
//        print(contact.bodyA.contactTestBitMask)
//        print(contact.bodyB.contactTestBitMask)
//    }
}

extension GameScene {
    private func ballHitBrick(_ node: SKNode?) {        
        guard let brick = node as? Brick else { return }
        
        if brick.physicsBody?.categoryBitMask == BitMask.Brick {
            if brick.hitRemaining == 0{
                if !(gameState.currentState is GameOver){
                    self.breakBlock(node: brick)
                    self.remainingBrickNum -= 1
                    if self.remainingBrickNum == 0{
                        gameState.enter(GameOver.self)
                        gameWon = true
                    }
                }
            }
            // generate a prop and make it drop down in a const speed. This prop can make the paddle longer
            let pos = CGPoint(x: node!.position.x, y: node!.position.y)
            
            let prop : Prop
            let rand =  Int.randomIntNumber(lower: 0, upper: 10)
            switch rand {
                case 0:
                    prop = ProlongProp(position: pos)
                    addChild(prop)
                case 1:
                    prop = ShortenProp(position: pos)
                    addChild(prop)
                case 2:
                    prop = ThreeBallsProp(position: pos)
                    addChild(prop)
                case 3:
                    prop = ExpandProp(position: pos)
                    addChild(prop)
                default:
                    break
            }
        }
    }
    
    private func breakBlock(node: SKNode) {
        let particles = SKEmitterNode(fileNamed: "Break Block")!
        particles.position = node.position
        particles.zPosition = 3
        addChild(particles)
        particles.run(SKAction.sequence([SKAction.wait(forDuration: 1.0),
          SKAction.removeFromParent()]))
        node.removeFromParent()
    }

    
    private func ballHitGround(_ node: SKNode?) {
        guard let ball = node as? Ball else { return }
        
        if ball.physicsBody?.categoryBitMask == BitMask.Ball {
            if !(gameState.currentState is GameOver){
                self.remainingBallNum -= 1
                if self.remainingBallNum == 0{
                    ball.removeFromParent()
                    gameState.enter(GameOver.self)
                    gameWon = false
                }
            }
            ball.removeFromParent()
        }
    }
    
    private func propHitGround(_ node: SKNode?) {
        guard let prop = node as? Prop else { return }
        
        if prop.physicsBody?.categoryBitMask == BitMask.Prop {
            prop.removeFromParent()
        }
    }
    
    private func paddleHitProp(paddle: SKNode?, prop: SKNode?) {
        guard let paddle = paddle as? Paddle else { return }
        guard let prop = prop as? Prop else { return }
        
        if prop.physicsBody?.categoryBitMask == BitMask.Prop {
            prop.conduct(gameScene: self, paddle: paddle, prop: prop)
            prop.removeFromParent()
        }
    }
}

extension GameScene {
    private func shot() {
        for (index, ball) in balls.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1 * Double(index)) {
                ball.physicsBody?.applyForce(CGVector(dx: 200 + CGFloat(index) * 0.1, dy: 300))
            }
        }
    }
    
    func addRemainingBallNum(num: Int){
        self.remainingBallNum += num
    }
}

extension GameScene {
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch gameState.currentState {
            case is WaitingForStart:
                gameState.enter(PlayingGame.self)
                shot()
            case is GameOver:
                if self.gameViewController?.extraLife != 0 {
                    self.restartGame()
                    gameState.enter(PlayingGame.self)
                }else{
                    print("no extra life")
                }
            default:
                break
        }
        isFingerOnPaddle = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      let touch = touches.first
      let touchLocation = touch!.location(in: self)
        
      if let body = physicsWorld.body(at: touchLocation) {
        if body.node!.name == Paddle.name {
          isFingerOnPaddle = true
        }
      }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
      if isFingerOnPaddle {
        let touch = touches.first
        let touchLocation = touch!.location(in: self)
        let previousLocation = touch!.previousLocation(in: self)
        let paddle = childNode(withName: Paddle.name) as! SKSpriteNode
        var paddleX = paddle.position.x + (touchLocation.x - previousLocation.x)
        paddleX = max(paddleX, paddle.size.width/2)
        paddleX = min(paddleX, size.width - paddle.size.width/2)
        paddle.position = CGPoint(x: paddleX, y: paddle.position.y)
      }
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if !(gameState.currentState is WaitingForStart) {
//            guard let location = touches.first?.location(in: self) else { return }
//            paddle?.position = CGPoint(x: location.x, y: (paddle?.position.y)!)
//        }
//    }
}

extension GameScene {
    func paddleMoveRight(){
        if paddle!.position.x + CGFloat(paddle!.width)/2.0 < size.width - 20{
            paddle?.position = CGPoint(x: (paddle?.position.x)! + 10, y: (paddle?.position.y)!)
        }
    }
    
    func paddleMoveLeft(){
        if paddle!.position.x - CGFloat(paddle!.width)/2.0 > 20{
            paddle?.position = CGPoint(x: (paddle?.position.x)! - 10, y: (paddle?.position.y)!)
        }
    }
}

extension GameScene {
    private func restartGame(){
        self.gameViewController?.extraLife! -= 1
        let xPosition = Float((self.paddle?.position.x)!)
        let yPosition = Float((self.paddle?.position.y)!) + Float(self.paddle!.height)/2
        let ball = createBall(position: CGPoint(x: Int(xPosition), y: Int(yPosition)))
        self.remainingBallNum += 1
        ball.shotWithFixedSpeed(angle: 30)
    }
}
