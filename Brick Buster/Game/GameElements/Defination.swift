//
//  Defination.swift
//  Brick Buster
//
//  Created by Zhihao Qin on 10/16/20.
//  Copyright © 2020 tra. All rights reserved.
//

import Foundation

struct BitMask {
    static let Ball = UInt32(0x00001)
    static let Brick = UInt32(0x00001 << 1)
    static let Wall = UInt32(0x00001 << 2)
    static let Ground = UInt32(0x00001 << 3)
    static let Paddle = UInt32(0x00001 << 4)
    static let Prop = UInt32(0x00001 << 5)
}
