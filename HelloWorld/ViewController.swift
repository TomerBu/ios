//
//  ViewController.swift
//  HelloWorld
//
//  Created by Tomer Buzaglo on 09/03/2016.
//  Copyright © 2016 Tomer Buzaglo. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    @IBOutlet weak var homeScore: UILabel!
    @IBOutlet weak var playerScore: UILabel!
    @IBOutlet weak var currentHomeSum: UILabel!
    @IBOutlet weak var currentPlayerSum: UILabel!
    @IBOutlet weak var standTapped: UIButton!
    
    var playerHand = [BlackJackCard]()
    var homeHand = [BlackJackCard]()
 
    
    var deck = BlackJackDeck()
    
    @IBAction func hitTapped(sender: UIButton) {

    }
    @IBAction func StandTapped(sender: UIButton) {
    }
    
    func newGame(){
        playerHand = []
        homeHand = []
        
        deck = BlackJackDeck()
        
        playerHand.append(deck.draw()!)
        homeHand.append(deck.draw()!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension String{
    // Returns a range of characters (e.g. s[0...3])
    subscript (r: Range<Int>) -> String {
        let start = startIndex.advancedBy(r.startIndex)
        let end = startIndex.advancedBy(r.endIndex)
        print(start, end)
        return substringWithRange(Range(start: start, end: end))
    }
    // Returns the nth character (e.g. s[1])
    subscript (i: Int) -> String {
        return self[i...i]
    }
}

extension Array{
    func forEach(task:()->()){
        for _ in self{
            task()
        }
    }
}


extension Int {
    func times(task:()->()) {
        for _ in 0...self{
            task()
        }
    }
}


enum Suit:Int, CustomStringConvertible{
    case Spades = 1, Hearts, Diamonds, Clubs
    var description:String {
        switch self {
        case .Spades:
            return "♠️"
        case .Hearts:
            return "❤️"
        case .Diamonds:
            return "♦️"
        case .Clubs:
            return "♣️"
        }
    }
}

struct Values {
    let first:Int, second:Int?
}

enum Rank: Int, CustomStringConvertible {
    case Ace = 1
    case Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten
    case Jack, Queen, King
    var description:String {
        switch self {
        case .Ace:
            return "Ace"
        case .Jack:
            return "Jack"
        case .Queen:
            return "King"
        case .King:
            return "Queen"
        default:
            return String(self.rawValue)
        }
    }
    //computed property
    var values:Values{
        get{
            switch self{
            case .Ace:
                return Values(first: 11, second: 1)
            case .Jack, .Queen, .King:
                return Values(first: 10, second: nil)
            default:
                return Values(first: self.rawValue, second: nil)
            }
        }
    }
}


struct BlackJackCard:CustomStringConvertible {
    let rank:Rank, suit:Suit
    
    var description:String{
        var output = "\(rank) of \(suit)."
        output += " value is \(rank.values.first)"
        if let second = rank.values.second{
            output += " or \(second)"
        }
        return output
    }
}


struct BlackJackDeck:CustomStringConvertible{
    var cards:[BlackJackCard]
    var history:[BlackJackCard] = []
    init (){
        cards = []
        initDeck()
    }
    
    private mutating func initDeck(){
        for suit in 1...4{
            for rank in 1...13{
                if  let s = Suit(rawValue: suit),
                    let r = Rank(rawValue: rank){
                        let   card = BlackJackCard(rank: r, suit: s)
                        cards.append(card)
                }
            }
        }
    }
    
    mutating func draw()->BlackJackCard?{
        if self.cards.count <= 0 {return nil}
        var rand:Int = 0
        arc4random_buf(&rand, sizeof(Int))
        var y = abs(rand)
        y = y % self.cards.count
        
        history.append(cards.removeAtIndex(y))
        return history.last
    }
    
    
    var description:String{
        return "\(cards)"
    }
}

func +(lhs:BlackJackCard, rhs:BlackJackCard)->Int{
    let l:Int = lhs.rank.values.second ?? lhs.rank.values.first
    let r:Int = rhs.rank.values.second ?? rhs.rank.values.first
    return l + r <= 21 ? l + r : l + rhs.rank.values.first
}


func +(lhs:[BlackJackCard], rhs:BlackJackCard)->Int{
    var aceCount = rhs.rank.values.second ?? 0 // one or zero
    let initialSum = rhs.rank.values.first //11 for aces
    
    
    var sum = lhs.reduce(initialSum) { (total, card) -> Int in
        var val = card.rank.values.second
        if val != nil {aceCount++} else{val = card.rank.values.first}
        return total + val!
    }
    
    while (aceCount > 0 && sum > 21){
        sum -= 10
        aceCount--
    }
    return sum
}

func +(lhs:BlackJackCard, rhs:[BlackJackCard])->Int{
    return rhs + lhs
}

class Person: CustomStringConvertible {
    //MARK: Stored Properties:
    var firstName:String?
    var lastName:String?
    
    //MARK: designated initializers:
    init(firstName:String?, lastName:String?){
        self.firstName = firstName
        self.lastName = lastName
    }
    
    //MARK: convenience initializers:
    convenience init(){
        self.init(firstName: "ploni", lastName: "almoni")
    }
    
    var description:String{
        return fullName
    }
    
    //MARK: Computed Properties:
    var fullName:String{
        get{
            var parts = [String]()
            if let firstName = self.firstName{
                parts += [firstName]
            }
            if let lastName = self.lastName{
                parts += [lastName]
            }
            
            return parts.joinWithSeparator(", ")
        }
    }
}

class User: Person {

    // MARK: stored preoperties
    var password:String?
    // MARK: inits
    /**
    A Convenience init
    */
    convenience  override init(firstName: String?, lastName: String?) {
        self.init(firstName: firstName, lastName: lastName, password:"1234")
    }
    
    /**
     The designated init
     :param: firstName the First Name 😌
     :param: lastName the Last Name 🌼
     :param: password the password 🙈
     :returns: Well. it's an init. so it does not return.
     */
    init(firstName: String?, lastName: String?, password:String?) {
        self.password = password
        super.init(firstName: firstName, lastName: lastName)
    }
    //TODO: get some cheese… and fix this description
    override var description:String{
        return "\(super.description) \(password)"
    }
}