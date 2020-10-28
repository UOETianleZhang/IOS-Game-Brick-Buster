//
//  Maps.swift
//  Brick Buster
//
//  Created by Zhihao Qin on 10/18/20.
//  Copyright © 2020 tra. All rights reserved.
//

import Foundation

/*
 map size is 8 * 12
 */


let map1 = [[1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
            [1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1],
            [1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1],
            [1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1],
            [1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1],
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]]

let map2 = [[2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2],
            [2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2],
            [2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2],
            [2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2],
            [2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2],
            [2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2],
            [2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2],
            [2, 2, 2, 1, 1, 1, 1, 1, 1, 2, 2, 2]]

let map3 = [[2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2],
            [1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1],
            [1, 1, 2, 1, 1, 1, 1, 1, 1, 2, 1, 1],
            [1, 1, 1, 2, 1, 1, 1, 1, 2, 1, 1, 1],
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]]

let map4 = [[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0],
            [0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 0],
            [0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0],
            [0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0],
            [0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0],
            [0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0]]

let map5 = [[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0],
            [0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 0],
            [0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0],
            [0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0],
            [0, 2, 0, 1, 1, 1, 1, 1, 0, 2, 0, 0],
            [0, 0, 2, 0, 1, 1, 1, 0, 2, 0, 0, 0],
            [0, 0, 0, 2, 0, 1, 0, 2, 0, 0, 0, 0]]

let map6 = [[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
            [1, 1, 1, 1, 2, 0, 0, 2, 1, 1, 1, 1],
            [1, 1, 1, 2, 0, 1, 1, 0, 2, 1, 1, 1],
            [1, 1, 2, 0, 1, 1, 1, 1, 0, 2, 1, 1],
            [1, 2, 0, 1, 1, 1, 1, 1, 1, 0, 2, 1],
            [2, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 2],
            [0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0],
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]]

let map7 = [[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
            [1, 2, 1, 1, 1, 1, 2, 1, 1, 1, 2, 1],
            [2, 2, 2, 1, 1, 2, 2, 2, 1, 2, 2, 2],
            [1, 2, 1, 1, 1, 1, 2, 1, 1, 1, 2, 1],
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]]

let map8 = [[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
            [1, 2, 1, 1, 1, 1, 2, 1, 1, 1, 2, 1],
            [2, 2, 2, 1, 1, 2, 2, 2, 1, 2, 2, 2],
            [1, 2, 1, 1, 1, 1, 2, 1, 1, 1, 2, 1],
            [1, 1, 1, 2, 1, 1, 1, 1, 2, 1, 1, 1],
            [1, 1, 2, 2, 2, 1, 1, 2, 2, 2, 1, 1],
            [1, 1, 1, 2, 1, 1, 1, 1, 2, 1, 1, 1]]

let map9 = [[2, 2, 2, 1, 2, 2, 2, 1, 2, 2, 2, 0],
            [2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 0],
            [2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 0],
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0],
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0],
            [2, 1, 2, 1, 1, 1, 1, 1, 2, 1, 2, 0],
            [2, 1, 2, 1, 1, 1, 1, 1, 2, 1, 2, 0],
            [2, 2, 2, 1, 1, 1, 1, 1, 2, 2, 2, 0]]
