import UIKit

/**
 
 *클래스 프로퍼티*
 1) 저장프로퍼티(Stored property)
    상수, 변수에 담기는 값
 
 
 2) 연산 프로퍼티(computed property)
    프로퍼티에 값을 설정하거나 가져오는 시점에서,
    어떤 계산이나 로직에 따라 처리된 값.
 
 */

class BankAccount {
    var accountBalance: Float = 0
    var accountNumber: Int = 0
    let fees: Float = 25.00
    
    // 잔액에서 수수료를 빼는 연산 프로퍼티
    var balanceLessFees: Float {
        get {
            return accountBalance - fees
        }
        
        // set 으로 값을 넣기 전에, 수수료를 뺄 수 있다
        set(newBalance) {
            accountBalance = newBalance - fees
        }
    }
    
    init(number: Int, balance: Float) {
        accountNumber = number
        accountBalance = balance
    }
}

var account1 = BankAccount(number: 45000, balance: 400.54)

var balance1 = account1.balanceLessFees
account1.balanceLessFees = 12123.12

