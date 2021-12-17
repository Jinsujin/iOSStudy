import Cocoa
import XCTest

/**
 회원 도메인 개발
 - 회원을 가입하고 조회할 수 있다.
 - 회원등급: 일반, VIP
 - 회원 데이터는 자체 DB를 구축할 수 있고, 외부 시스템과 연동할 수 있다(미확정)
 */

/// 회원 등급
enum Grade {
    case basic, vip
}

/// 회원 엔티티
struct Member {
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

/// 회원 저장소- 구현체
// repository 는 저장소 라는 뜻.
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

//class MemberApp {}
//let memberService: MemberService = MemberServiceImpl()
//let member = Member(name: "memberA", grade: .vip)
//memberService.join(member: member)
//
//let findMember = memberService.findMember(memberId: member.id)
//print(findMember.name)


/**
 Test
 */
class Tests: XCTestCase {
    var memberService: MemberService!
    
    override func setUp() {
        super.setUp()
        memberService = MemberServiceImpl()
    }
    override func tearDown() {
        super.tearDown()
        memberService = nil
    }
    
    func testJoin() {
        // given
        let member = Member(name: "memberA", grade: .vip)
        
        // when
        memberService.join(member: member)
        let findMember = memberService.findMember(memberId: member.id)
        
        // then
        XCTAssertEqual(member.name, findMember.name)
    }
}




/**
 문제점
 - DIP 를 지키고 있지 않다
 의존관계가 인터페이스 뿐만 아니라, 구현까지 모두 의존하는 문제.
 
 class MemberServiceImpl: MemberService {
     private let memberRepository: MemberRepository = MemoryMemberRepository()
 위 코드에서 할당하는 부분이 구현체 MemoryMemberRepository() 를 의존한다.
 이부분이 문제점.
 MemberServiceImpl 은 추상화(MemberRepository) 도 의존하고,
 구체화(MemoryMemberRepository) 도 의존한다.
 
 */

Tests.defaultTestSuite.run()
