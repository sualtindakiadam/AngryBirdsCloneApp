//
//  GameScene.swift
//  AngryBirdsCloneApp
//
//  Created by Semih Kalaycı on 25.08.2021.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

    
    //var bird2 = SKSpriteNode()
    
    var bee = SKSpriteNode()
    var box1 = SKSpriteNode()
    var box2 = SKSpriteNode()
    var box3 = SKSpriteNode()
    var box4 = SKSpriteNode()
    var box5 = SKSpriteNode()
    
    var boxesMass = CGFloat(0.2)
    var gameStarted = false
    var originalPasition = CGPoint(x: 0, y: 0)
    
    
    override func didMove(to view: SKView) { // oyun başladığında
        /*
        // ekrana içinde kuş resmi olan bir nesne koyduk . Elle bütün nesneler bu şekilde eklenebilir
        let texture = SKTexture(imageNamed: "redbee")
        bird2 = SKSpriteNode(texture: texture)
        bird2.position = CGPoint(x: 0, y: 0) // self.frame kullanarak yeri de ayarlayabilirsiniz
        bird2.size = CGSize(width: 100, height: 100) // ekran boyutlarına oranlı istersek CGSize(width: self.frame.width / 15, height: self.frame.width / 10) yapabiliriz
        bird2.zPosition = 1
        self.addChild(bird2)
        ////////////////////////////////////////////////////////////////////////////////////////////////////
      */
        // Physics Body
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame) // gameScene yi bir çerçeve halinde dünya olarak oluşturur
        //self.scene?.scaleMode = .aspectFit
        
        //Bee
        bee = childNode(withName: "redbee") as! SKSpriteNode // redbee gameScene deverdiğim isim resim dosyasının adı değil
        let birdTexture = SKTexture(imageNamed: "redbee")
        bee.physicsBody = SKPhysicsBody(circleOfRadius: birdTexture.size().height/12) // kuşun boyutlarına göre temas sınırı
        bee.physicsBody?.affectedByGravity = false // yer çekiminden etkilenecek
        bee.physicsBody?.isDynamic = true // fiziksel etkilerden etkilenecek
        bee.physicsBody?.mass = 0.25 // kg cinsinde kütle verdik
        originalPasition = bee.position
        //Box
        let boxTexture = SKTexture(imageNamed: "bluebrick")
        let size = CGSize(width: 100, height: 100)
        
        box1 = childNode(withName: "box1") as! SKSpriteNode
        box1.physicsBody = SKPhysicsBody(rectangleOf: size)
        box1.physicsBody?.isDynamic = true
        box1.physicsBody?.affectedByGravity = true
        box1.physicsBody?.allowsRotation = true //kutu dönme şeklinde de hareket edebilsin
        box1.physicsBody?.mass = boxesMass
        
        box2 = childNode(withName: "box2") as! SKSpriteNode
        box2.physicsBody = SKPhysicsBody(rectangleOf: size)
        box2.physicsBody?.isDynamic = true
        box2.physicsBody?.affectedByGravity = true
        box2.physicsBody?.allowsRotation = true //kutu dönme şeklinde de hareket edebilsin
        box2.physicsBody?.mass = boxesMass
        
        box3 = childNode(withName: "box3") as! SKSpriteNode
        box3.physicsBody = SKPhysicsBody(rectangleOf: size)
        box3.physicsBody?.isDynamic = true
        box3.physicsBody?.affectedByGravity = true
        box3.physicsBody?.allowsRotation = true //kutu dönme şeklinde de hareket edebilsin
        box3.physicsBody?.mass = boxesMass
        
        box4 = childNode(withName: "box4") as! SKSpriteNode
        box4.physicsBody = SKPhysicsBody(rectangleOf: size)
        box4.physicsBody?.isDynamic = true
        box4.physicsBody?.affectedByGravity = true
        box4.physicsBody?.allowsRotation = true //kutu dönme şeklinde de hareket edebilsin
        box4.physicsBody?.mass = boxesMass
        
        box5 = childNode(withName: "box5") as! SKSpriteNode
        box5.physicsBody = SKPhysicsBody(rectangleOf: size)
        box5.physicsBody?.isDynamic = true
        box5.physicsBody?.affectedByGravity = true
        box5.physicsBody?.allowsRotation = true //kutu dönme şeklinde de hareket edebilsin
        box5.physicsBody?.mass = boxesMass
        
     
        

    }
    
    
    func touchDown(atPoint pos : CGPoint) { // dokunduğu nokta
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    
    }
    
    func touchUp(atPoint pos : CGPoint) {
    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) { // kullanıcı ekrana dokunmaya başladı
       /*
        bee.physicsBody?.applyImpulse(CGVector(dx: 30, dy: 200)) //x ve y eksenşnde bir etki uygularız
        bee.physicsBody?.affectedByGravity = true
         */
        
        moveBee(touches: touches)
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) { // ekranda parmağını hareket ettirdi
        
        moveBee(touches: touches)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) { // ekrana dokunma bitti
        
        
        
        if !gameStarted{
            if let touch = touches.first{
                let touchLocation = touch.location(in: self)
                let touchNode = nodes(at: touchLocation)
                
                if !touchNode.isEmpty{
                    for node in touchNode{
                        
                        if let sprite = node as? SKSpriteNode{ // herhangi bir sk sprite nodun üstündeyse içeri girer
                            
                            if sprite == bee { // buraya girdiyse bir sprite node a dokunmuştur ve bu bizim arımız mı diye kontrol ederiz
                                
                                var dx = -(touchLocation.x - originalPasition.x)*2
                                var dy = -(touchLocation.y - originalPasition.y)*2
                                
                                let impulse = CGVector(dx: dx, dy: dy)
                                bee.physicsBody?.applyImpulse(impulse)
                                bee.physicsBody?.affectedByGravity = true
                                gameStarted = true
                     
                                
                                
                                
                            }
                            
                        }
                        
                    }
                }
                
            }
        }

        
        
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) { // dokunmaktan vazgeçti
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        if bee.physicsBody!.velocity.dx <= 0.1 && bee.physicsBody!.velocity.dy <= 0.1 && bee.physicsBody!.angularVelocity <= 0.1 && gameStarted == true   {
            bee.physicsBody?.affectedByGravity = false
            gameStarted = false
            bee.position = originalPasition
            
        }
    }
    
    
    func moveBee(touches: Set<UITouch>) {
        if !gameStarted{
            if let touch = touches.first{
                let touchLocation = touch.location(in: self)
                let touchNode = nodes(at: touchLocation)
                
                if !touchNode.isEmpty{
                    for node in touchNode{
                        
                        if let sprite = node as? SKSpriteNode{ // herhangi bir sk sprite nodun üstündeyse içeri girer
                            
                            if sprite == bee { // buraya girdiyse bir sprite node a dokunmuştur ve bu bizim arımız mı diye kontrol ederiz
                                bee.position = touchLocation  // eğer öyleyse arıya eşitle ve hareket ettirmiş olalım
                                
                            }
                            
                        }
                        
                    }
                }
                
            }
        }

    }
    
}
