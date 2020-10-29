//
//  DDB.swift
//  Brick Buster
//
//  Created by Tianle Zhang on 2020/10/27.
//  Copyright © 2020 tra. All rights reserved.
//

import Foundation
import DynamoDB

struct DB {
    static let dynamoDB = DynamoDB(accessKeyId: "AKIAV53TS6JBIGOMXAAJ", secretAccessKey: "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", region: .useast1)
    static let tableName = "GameUserData"
    static func createDB() {
        let mirror = Mirror(reflecting: data)
        var attributeDefinitions : [DynamoDB.AttributeDefinition] = []
        for child in mirror.children  {
            if child.label == "first" || child.label == "last" {
                attributeDefinitions.append(DynamoDB.AttributeDefinition(attributeName: child.label!, attributeType: .s))
            }
        }
        let keySchema = [DynamoDB.KeySchemaElement(attributeName: "first", keyType: .hash), DynamoDB.KeySchemaElement(attributeName: "last", keyType: .range)]
        let secondaryIndex = DynamoDB.LocalSecondaryIndex(indexName: "DataIndex", keySchema: keySchema, projection: .init(nonKeyAttributes: nil, projectionType: .keysOnly))
        let createTableInput = DynamoDB.CreateTableInput.init(attributeDefinitions: attributeDefinitions, billingMode: .payPerRequest, keySchema: keySchema, localSecondaryIndexes: [secondaryIndex], tableName: tableName)
        let response = dynamoDB.createTable(createTableInput)
        response.whenSuccess{
            response in
            print(response)
        }
        response.whenFailure{
            response in
            print(response)
        }
    }
    
    static func addOrUpdate(data : DataModel) {
        let mirror = Mirror(reflecting: data)
        var item : [String : DynamoDB.AttributeValue] = [:]
        for child in mirror.children  {
            if "\(child.value)".isEmpty {
                continue
            }
            if child.label == "first" || child.label == "last" {
                item[child.label!] = DynamoDB.AttributeValue(s: child.value as? String)
            } else {
                item[child.label!] = DynamoDB.AttributeValue(n: "\(child.value)")
            }
        }
        
        let input = DynamoDB.PutItemInput(item: item, tableName: tableName)
        dynamoDB.putItem(input).always{
            response in
            print(response)
        }
    }
    
    static func getSortedUserData() -> [DataModel] {
        let input = DynamoDB.ScanInput(tableName: tableName)
        let group = DispatchGroup()
        var ret : [DataModel] = []
        group.enter()
        let response = dynamoDB.scan(input)
        response.whenSuccess{
            result in
            for item in result.items! {
                ret.append(itemToDataModel(item: item))
            }
            ret.sort{ (player1, player2) in return player1.score > player2.score }
            group.leave()
        }
        response.whenFailure{_ in group.leave() }
        group.wait()
        return ret
    }
    
    static func getData(first: String, last : String) -> DataModel? {
        let keys = ["first" : DynamoDB.AttributeValue(s: first),
                     "last" : DynamoDB.AttributeValue(s: last)]
        let input = DynamoDB.GetItemInput(key: keys, tableName: tableName)
        let group = DispatchGroup()
        group.enter()
        var ret : DataModel?
        let response = dynamoDB.getItem(input)
        response.whenSuccess{
            result in
            if let item = result.item {
                ret = itemToDataModel(item: item)
            }
            group.leave()
        }
        response.whenFailure {
            result in
            ret = nil
            group.leave()
        }
        group.wait()
        return ret
    }
    
    static private func itemToDataModel(item : [String: DynamoDB.AttributeValue]) -> DataModel {
        var data = DataModel(first: item["first"]!.s!, last: item["last"]!.s!)
        if let value = item["score"]?.n {data.score = Int64(value)!}
        if let value = item["coins"]?.n {data.coins = Int64(value)!}
        if let value = item["lives"]?.n {data.lives = Int64(value)!}
        if let value = item["bats"]?.n {data.bats = Int64(value)!}
        if let value = item["progress"]?.n {data.progress = Int64(value)!}
        if let value = item["music"]?.n {data.music = Float(value)!}
        if let value = item["sound"]?.n {data.sound = Float(value)!}
        if let value = item["paddleSkin"]?.n {data.paddleSkin = Int64(value)!}
        if let value = item["background"]?.n {data.background = Int64(value)!}
        return data
    }
}

