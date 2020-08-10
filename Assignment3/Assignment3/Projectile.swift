//
//  Projectile.swift
//  Assignment3
//
//  Created by mayilen on 2020-03-20.
//  Copyright © 2020 mayilen. All rights reserved.
//

import Foundation
class Projectile{
    //initial velocity velocity
    var initVelocity=0.0
    var angle=0.0//angle
    
    let gravity = -9.81
    var time=0.0// counter for the time
   
    var height=0.0//height
    
    
    func Theoretical_xPos(angle:Double, time:Double)->Double{
        return (initVelocity)*angle*time//calculates the x position
    }
    
    func Theoretical_yPos(angle:Double, time:Double)->Double{
        return 0.5 * gravity * pow(time,2) + (initVelocity*angle*time) + height//calculates the y position
    }
    
    func eulerX(angle:Double,delta:Double,previousPos: inout Double)->Double{
        let velocity=angle*initVelocity//calculates the xvelocity
        let pos=velocity * delta + previousPos//calculates the xposition for euler
        previousPos=pos //sets the previous position as the current
        return pos//returns the x position
    }
    
    func eulerY(angle:Double,delta:Double,previousPos:inout Double,previousVelocity: inout Double,time:Double)->Double{
        let velocity=previousVelocity + (gravity * delta)//calculates the yvelocity
        previousVelocity=velocity//stores velocity as its previous velocity for the next calculation
        let pos = (previousPos + velocity*delta)//calculates the posistion
        previousPos=pos//stores the previous position as its current
        return pos
    }
    
    func advance(_ deltaT:Double){
        print("theoretical                           Euler approximation")
        print("time      Horizontal      vertical    Horizontal      vertical")//prints the categories
        var eulerXpos=0.0//xposition for euler
        var xprev=0.0//previous x position
        var yprev=height//previous y position
        var xposition=0.0
        var yposition=0.0
        var eulerYpos=0.0
        var prevVelocity=0.0
        var prevTime = 0.0//previous time
        
        let vx=cos((Double.pi*(angle/180)))//angle to calculate xvelocity
        let vy=sin((Double.pi*(angle/180)))//angle to calculate yvelocity
        prevVelocity=initVelocity*vy//previous yvelocity
        
        let flightTime=abs((initVelocity * vy + (pow((initVelocity*vy),2)+(-2*gravity*height)).squareRoot())/gravity)//max time of flight
        
        
        while (time<=flightTime){//while the projectile hasnt reached the max flightTime
            let delta=time-prevTime//deltaT
            xposition=Theoretical_xPos(angle: vx, time: time)//stores the xposition

            yposition=Theoretical_yPos(angle: vy, time: time)//stores the y position
            
            eulerXpos=eulerX(angle: vx, delta: delta, previousPos: &xprev)//stores the eurler x position
            
            eulerYpos=eulerY(angle: vy, delta: delta, previousPos: &yprev, previousVelocity: &prevVelocity,time: time)//stores the euler y position
            print(String(format:"%.3f         %.2f          %.3f |   %.2f          %.3f",time,xposition,yposition,eulerXpos,eulerYpos))//prints in columns
            prevTime=time//previous time is the current time
            time+=deltaT//time gets increased by the interval
            
        }
        if(time != flightTime){//if the deltaT between the flight time and time is less than the interval requested then this condition gets called to display when the y postion is at 0
            xposition=(Theoretical_xPos(angle: vx, time: flightTime))
            yposition=Theoretical_yPos(angle: vy, time: flightTime)
            eulerXpos=eulerX(angle: vx, delta: flightTime-prevTime, previousPos: &eulerXpos)
                           
            eulerYpos=eulerY(angle: vy, delta: flightTime-prevTime, previousPos: &eulerYpos, previousVelocity: &prevVelocity,time:time)
            print(String(format:"%.3f         %.2f          %.3f |   %.2f          %.3f",flightTime,xposition,abs(yposition),eulerXpos,eulerYpos))
        }
    }
    
}
