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
            let income = (Int(hourlyPay)+raise) * hours
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

  fileprivate var _job : Job? = nil
  open var job : Job? {
    get { }
    set(value) {
    }
  }
  
  fileprivate var _spouse : Person? = nil
  open var spouse : Person? {
    get { }
    set(value) {
    }
  }
  
  public init(firstName : String, lastName: String, age : Int) {
    self.firstName = firstName
    self.lastName = lastName
    self.age = age
  }
  
  open func toString() -> String {
  }
}

////////////////////////////////////
// Family
//
open class Family {
  fileprivate var members : [Person] = []
  
  public init(spouse1: Person, spouse2: Person) {
  }
  
  open func haveChild(_ child: Person) -> Bool {
  }
  
  open func householdIncome() -> Int {
  }
}





