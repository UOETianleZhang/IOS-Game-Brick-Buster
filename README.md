# **Brick** Buster -- ECE564 Project

Cheng Peng(cp286), Zhihao Qin(zq33), Tianle Zhang(tz94)



## Config

####Setup

All setup is done inside the code. Just clone the repo and build in Xcode and you should be good to go! 😊 (Preparing package dependency could take about two minutes.)

#### Logging in

When starting the game, you need to input you name. **Password is not required.** Brick Buster will fetch your information based on the name you input if you logged before, otherwise a new account will be created for you.

#### Database Access

We use AWS DynamoDB to store our data. Database authentication has been already completed inside the code so **you don't need to config it to play the game**. But if you are curious what it looks like, you can login by the following instructions:

1. Click the website https://407727436354.signin.aws.amazon.com/console
2. Username: `tianleFull`, password `ece564`

3. Access [DynamoDB](https://console.aws.amazon.com/dynamodb/home?region=us-east-1#tables:selected=GameUserData;tab=items).



## Key Features

#### Before the Game

Before starting the game, a user can choose 

- which level she wants to play;
- whether she wants to use extra life or extend the paddle length.

If a user wins the highest level he/she locked, then a new level will be unlocked for her.

####Inside the Game

1. **SpriteKit** for physical effects

   We applied the SpriteKit framework to help us build this 2D game. With SpriteKit, we can easily build the physical world and use all physics effects. For the basic game logic, we use SKSpriteNode to create all of the elements in this game, including balls, bricks, props and stones. Also, we create physicsBodys for all of the nodes, so that we can implement the physics effect, especially the collision effect. We set categoryBitMask for each node, such that when a collision happens, we can tell it happens on which two elements and then apply the proper effects.
   
2. Slide and hold your finger to shoot the first ball. The shooting angle depends on the position you release your finger.


3. Props

   When a ball hits a brick, there is a possibility that a prop will fall down at a fixed speed. There are five kinds of props.

   <img src="https://lh3.googleusercontent.com/Y0ffkGGiOWTEWpgWBMkJCC4l2azJSW-dLlrqBafcIOTWqAUhSdZCo4wBDnLQUHamsb9H8Hp_64b1Gvj43fqbmJ-__LQSYPwjIXCSQ21NYgvLEI2PaRcp4xbuhciMCXn0kras8wnI" alt="img" style="zoom:40%;" />

4. When a ball hits the paddle, **the ball**, instated of simply rebonding, **will** **rebound in a direction based on the position of collision.** For example, if the ball touches the left side of the paddle, it will then go up left  no matter what the input angle is.

5. Animation

   - Fire effects on balls at the game.
   - When breaking bricks at the game, bamboo fragments will sputter.
   - Some leaves fall down on the main scene.

#### Database

We use **AWS DynamoDB** to store our user data. DynamoDB is a cloud-based no-sql database developed by Amazon Web Service. The user data table we created has several attributes, including name, score, coin, current progress, music volume, etc. The first name and the last name are the primary key of the table. In Swift, we have a struct called DataModel to store data in memory and this will keep synchronized to DynamoDB at some time. 

<img src="https://lh6.googleusercontent.com/vHKpDDgtN4oZF-HtoIpg5Dbx1R8vX5DUaEQxrxNPyZ2kw2wdabcUkJOIUUN-M_sGDtUN8exR0qHkW9UErWXZIiqztU8rMdj9qOgdSNbpnceQLXLcjwYFbjdM5mmxjd4ZoLj6DCSJ" alt="img" style="zoom:35%;" />

Use cases:

1. **Logging in:** when the app starts and after the user inputs first name & last name, our app will search on DynamoDB. If this name was used before, the stored data will be transferred back to the phone and translated as DataModel. Otherwise, a new entry in DynamoDB will be created. 
2. **Data update:** when the user sets something or gets new scores in the game, the new information will be sent to DynamoDB and the corresponding entry will be updated.
3. **Rankings:** in the rankings page, all entries in DynamoDB will be fetched and sorted by their scores in descending order.All changes on DynamoDB will be made instantly, so the rankings are updated at the real time.



## Acknowledgement

#### Package Dependency

This app used three external packages.

- DynamoDB: database related package.
- MBProgressHUD: a fancy progress bar. Will appear when waiting for logging in.
- PokerCard: a fancy alert. Will appear when logging in successfully, or buying goods in the store without enough coins.

####Resource

- We read [a Tutorial](https://www.raywenderlich.com/1160-how-to-make-a-breakout-game-with-spritekit-and-swift-part-2) for reference. Some pictures are from here. It contains very fundamental logic of SpriteKit and state machine. The functionality from this resources is not written in the "Key Feature" part in this README.

