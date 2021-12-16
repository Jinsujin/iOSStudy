//: [Previous](@previous)

import Foundation


/// 회원 등급
enum Grade {
    case basic, vip
}

/// 회원 엔티티
class Member {
    let id: UUID
    let name: String
    let grade: Grade
    
    init(name: String, grade: Grade) {
        self.id = UUID()
        self.name = name
        self.grade = grade
    }
}

/// 회원 저장소- interface(역할)
protocol MemberRepository {
    func save(member: Member)
    func findById(memberId: UUID) -> Member
}

// repository 는 저장소 라는 뜻.
/// 회원 저장소 (구현체)
class MemoryMemberRepository: MemberRepository {
    // 테스트용 저장소
    static private var store = [UUID: Member]()
    
    func save(member: Member) {
        Self.store[member.id] = member
    }
    
    func findById(memberId: UUID) -> Member {
        return Self.store[memberId]!
    }
}


/// 회원 서비스(역할)
protocol MemberService {
    func join(member: Member)
    func findMember(memberId: UUID) -> Member
}


// 구현체가 하나만 있을때는 Impl을 붙이는 관례가 있다.
/// 회원 서비스(구현체)
class MemberServiceImpl: MemberService {
    private let memberRepository: MemberRepository = MemoryMemberRepository()
    
    func join(member: Member) {
        memberRepository.save(member: member)
    }
    
    func findMember(memberId: UUID) -> Member {
        return memberRepository.findById(memberId: memberId)
    }
}







/**
 ## 주문과 할인 정책 설계

 - 회원을 상품을 주문할 수 있다.
 - 회원 등급에 따라 할인 정책을 적용할 수 있다.
 - 할인 정책은 모든 VIP 는 1000원 할인해주는 고정 금액 할인을 적용(변경 가능성 있음)
 - 회사의 기본 할인 정책을 아직 정하지 못했다.
    오픈 직전까지 미루고 싶다.
    최악에는 기능이 적용 안될 가능성도 있다.
 */

/// 할인정책(역할)
protocol DiscountPolicy {
    /// 할인 금액 반환
    func discount(member: Member, price: Int) -> Int
}

/// 할인정책 (구현체)
class FixDiscountPolicy: DiscountPolicy {
    // 1000원 할인
    private let discountFixAmout = 1000
    
    func discount(member: Member, price: Int) -> Int {
        if (member.grade == .vip) {
            return discountFixAmout
        } else {
            return 0
        }
    }
}


/// 주문서. 주문이 다 끝났을때 만들어지는 객체
struct Order {
    private let memberId: UUID
    private let itemName: String
    private let itemPrice: Int
    private let discountPrice: Int
    
    init(memberId: UUID, itemName: String, itemPrice: Int, discountPrice: Int) {
        self.memberId = memberId
        self.itemName = itemName
        self.itemPrice = itemPrice
        self.discountPrice = discountPrice
    }
    
    // 비지니스로직(계산로직)
    func calculatePrice() -> Int{
        return itemPrice - discountPrice
    }
}


/// 주문 서비스 (역할)
protocol OrderService {
    func createOrder(memberId: UUID, itemName: String, itemPrice: Int) -> Order
}



/// 주문 서비스 (구현체)
class OrderServiceImpl: OrderService {
    private let memberRepository: MemberRepository = MemoryMemberRepository()
    private let discountPolicy: DiscountPolicy = FixDiscountPolicy()
    
    
    // 주문을 받으면, 회원정보를 조회하고 할인정책을 적용해 주문결과를 반환한다.
    func createOrder(memberId: UUID, itemName: String, itemPrice: Int) -> Order {
        // 할인에 대해서는 DiscountPolicy 가 책임지게 넘긴다.(단일책임원칙)
        // => 할인이 변경되면 할인쪽만 고치면 된다.주문쪽을 손댈 필요 없다.
        let member: Member = memberRepository.findById(memberId: memberId)
        let discountPrice = discountPolicy.discount(member: member, price: itemPrice)
        return Order(memberId: memberId, itemName: itemName, itemPrice: itemPrice, discountPrice: discountPrice)
    }
}


//: [Next](@next)
