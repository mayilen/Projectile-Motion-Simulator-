//
//  main.swift
//  Assignment3
//
//  Created by mayilen on 2020-03-20.
//  Copyright © 2020 mayilen. All rights reserved.
//

import Foundation

func getInput()->String{
    let keyboard=FileHandle.standardInput
    let inputData=keyboard.availableData
    let strData=String(data: inputData,encoding:String.Encoding.utf8)!
    return strData.trimmingCharacters(in: CharacterSet.newlines)
}
var height=""//input string for the height
var angle=""//input string for the angle
var velocity=""//input string for the velocity
var deltaT=""//input string for the time interval
while(true){
    print("enter initial height")
     height = (getInput())
    if(height == "quit"){//if user enters quit then break
        break
    }
    print("enter angle")
    
     angle = (getInput())
    if(angle == "quit"){
        break
    }
    print("enter initial velocity")
     velocity = (getInput())
    if(velocity == "quit"){
        break
    }
    print("enter number of divisions per second for the simulation to use (e.g. 100)")
     deltaT = (getInput())
    if(deltaT == "quit"){
        break
    }
    let time=1.0/Double(deltaT)!//convert to decimal to get the time invertval
    let projectile: Projectile=Projectile()
    projectile.height=Double(height)!//set the properties
projectile.angle=Double(angle)!
projectile.initVelocity=Double(velocity)!

    projectile.advance((time))//call the function advance with the time interval 
}
