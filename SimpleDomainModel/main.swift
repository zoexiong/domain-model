//
//  main.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import Foundation

print("Hello, World!")

public func testMe() -> String {
  return "I have been tested"
}

open class TestMe {
  open func Please() -> String {
    return "I have been tested"
  }
}

////////////////////////////////////
// Money
//
public struct Money {
    public var amount : Int
    public var currency : String
    public func convert(_ to: String) -> Money {
        var value=0
        var amount=0
        var currency=""
        if self.currency == "USD" {
            value = self.amount
        } else if self.currency == "GBP" {
            value = self.amount*2
        } else if self.currency == "EUR" {
            value = self.amount*2/3
        } else if self.currency == "CAN" {
            value = self.amount*4/5
        } else{
            print("Not a valid currency")
        }
        if to == "USD" {
            amount=value
            currency="USD"
        } else if to == "GBP" {
            amount = value/2
            currency="GBP"
        } else if to == "EUR" {
            amount = value*3/2
            currency="EUR"
        } else if to == "CAN" {
            amount = value*5/4
            currency="CAN"
        } else{
            print("Not a valid currency type")
        }
        let output = Money(amount:amount,currency:currency)
        return output
    }
    public func add(_ to: Money) -> Money {
        let temp = self.convert(to.currency)
        let amount = temp.amount + to.amount
        let output = Money(amount:amount,currency: to.currency)
        return output
    }
    public func subtract(_ from: Money) -> Money {
        let temp = self.convert(from.currency)
        let amount = temp.amount - from.amount
        let output = Money(amount:amount,currency: from.currency)
        return output
    }
}

////////////////////////////////////
// Job
//
open class Job {
    var raise = 0
    fileprivate var title : String
    fileprivate var type : JobType
    
    public enum JobType {
        case Hourly(Double)
        case Salary(Int)
    }
    
    public init(title : String, type : JobType) {
        self.title = title
        self.type = type
    }
    open func calculateIncome(_ hours: Int) -> Int {
        switch type{
        case .Hourly(let hourlyPay):
            let income = Int(hourlyPay * Double(hours)) + raise * hours
            return income
        case .Salary(let yearlyPay):
            let income = yearlyPay + raise
            return income
        }
    }
    open func raise(_ amt : Double) {
        raise = raise + Int(amt)
    }
}

////////////////////////////////////
// Person
//
open class Person {
    open var firstName : String = ""
    open var lastName : String = ""
    open var age : Int = 0
    
    
    fileprivate var _job : Job? = nil // this variable could use any name, no need to use _job only
    open var job : Job? {
        get {
            return _job
        }
        set(value) {
            if age < 16{
                print("can't have a job if age < 16")
            } else {
                _job = value
            }
        }
    }
    
    public init(firstName : String, lastName: String, age : Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
    
    
    fileprivate var _spouse : Person? = nil
    open var spouse : Person? {
        get {
            return _spouse
        }
        set(value) {
            if age < 18{
                print("can't have a spouse if age < 18")
            } else {
                _spouse = value
            }
        }
    }
    
    open func toString() -> String {
        return "[Person: firstName:\(firstName) lastName:\(lastName) age:\(age) job:\(job) spouse:\(spouse)]"
    }
}
////////////////////////////////////
// Family
//
open class Family {
    fileprivate var members : [Person] = []
    
    public init(spouse1: Person, spouse2: Person) {
        if spouse1.spouse == nil {
            if spouse2.spouse == nil {
                spouse1.spouse = spouse2
                spouse2.spouse = spouse1
            }
        }
        members.append(spouse1)
        members.append(spouse2)
    }
    
    open func haveChild(_ child: Person) -> Bool {
        members.append(child)
        return true
    }
    
    open func householdIncome() -> Int {
        var income : [Int] = []
        let hours = 2000
        for person in members {
            if person.job != nil {
                let personIncome = person.job!.calculateIncome(hours)
                income.append(personIncome)
            }
        }
        let result = income.reduce(0,+)
        return result
    }
}

///////////////////////////
//////// For Extra Credits
//


//indirect enum Money {
//    case EUR(Double)
//    case GBP(Double)
//    case USD(Double)
//    case CAN(Double)
//    case add(Money,Money)
//    case subtract(Money,Money)
//    case convert(Money,String)
//    case notValid(String)
//}
//
//
////get value of money that converted to USD
//func getValue(_ expression: Money) -> Double?{
//    switch expression {
//    case let .EUR(amount):
//        let value = amount * 2 / 3
//        return value
//    case let .GBP(amount):
//        let value = amount * 2
//        return value
//    case let .USD(amount):
//        let value = amount
//        return value
//    case let .CAN(amount):
//        let value = amount * 4 / 5
//        return value
//    default:
//        return nil
//    }
//}
//
////convert money from USD to other types and add
//func convertAdd(_ amount1:Double, _ expression:Money) -> Double?{
//    switch expression {
//    case let .EUR(amount2):
//        let value = (amount1 * 3 / 2) + amount2
//        return value
//    case let .GBP(amount2):
//        let value = (amount1 / 2) + amount2
//        return value
//    case let .USD(amount2):
//        let value = amount1 + amount2
//        return value
//    case let .CAN(amount2):
//        let value = (amount1 * 5 / 4) + amount2
//        return value
//    default:
//        return nil
//    }
//}
//
////convert money from USD to other types and subtract
//func convertSubtract(_ amount1:Double, _ expression:Money) -> Double?{
//    switch expression {
//    case let .EUR(amount2):
//        let value = (amount1 * 3 / 2) - amount2
//        return value
//    case let .GBP(amount2):
//        let value = (amount1 / 2) - amount2
//        return value
//    case let .USD(amount2):
//        let value = amount1 - amount2
//        return value
//    case let .CAN(amount2):
//        let value = (amount1 * 5 / 4) - amount2
//        return value
//    default:
//        return nil
//    }
//}
//
////operation, add or subtract, then return a money
//func operation(_ expression: Money) -> Money {
//    switch expression {
//    case let .add(money1, money2):
//        let amount1 = getValue(money1)
//        switch money2 {
//        case .EUR(_):
//            let value = convertAdd(amount1!, money2)
//            return Money.EUR(value!)
//        case .GBP(_):
//            let value = convertAdd(amount1!, money2)
//            return Money.GBP(value!)
//        case .USD(_):
//            let value = convertAdd(amount1!, money2)
//            return Money.USD(value!)
//        case .CAN(_):
//            let value = convertAdd(amount1!, money2)
//            return Money.CAN(value!)
//        default:
//            return Money.notValid("not a valid money")        }
//    case let .subtract(money1, money2):
//        let amount1 = getValue(money1)
//        switch money2 {
//        case .EUR(_):
//            let value = convertAdd(amount1!, money2)
//            return Money.EUR(value!)
//        case .GBP(_):
//            let value = convertAdd(amount1!, money2)
//            return Money.GBP(value!)
//        case .USD(_):
//            let value = convertAdd(amount1!, money2)
//            return Money.USD(value!)
//        case .CAN(_):
//            let value = convertAdd(amount1!, money2)
//            return Money.CAN(value!)
//        default:
//            return Money.notValid("not a valid money")
//        }
//    default:
//        return Money.notValid("not a valid money")
//    }
//}

//Could be used to test enum Money
//let five = Money.GBP(5)
//let ten = Money.USD(10)
//let twenty = Money.CAN(20)
//let sum = Money.add(ten, five)
//let sub = Money.subtract(twenty,five)
//print(five)
//print(getValue(five)!)
//print(operation(sum))
//print(operation(sub))
