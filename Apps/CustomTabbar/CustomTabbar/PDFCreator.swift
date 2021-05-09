import UIKit
import PDFKit

class PDFCreator: NSObject {
    let title: String
    let body: String
    let image: UIImage
    let contactInfo: String

    init(title: String, body: String, image: UIImage, contact: String) {
        self.title = title
        self.body = body
        self.image = image
        self.contactInfo = contact
    }

    
    func createFlyer() -> Data {
      // 1. Create Auxiliary Dictionary Keys
      let pdfMetaData = [
        kCGPDFContextCreator: "PDF File",
        kCGPDFContextAuthor: "JIN",
        kCGPDFContextTitle: title
    
      ]
      let format = UIGraphicsPDFRendererFormat()
      format.documentInfo = pdfMetaData as [String: Any]

      // 2. PDF 파일 문서 크기 설정. 인치당 72 포인트의 좌표 시스템을 사용하므로 72를 곱함
      let pageWidth = 8.5 * 72.0 // US 표준 letter size
      let pageHeight = 11 * 72.0
      let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)

      // 3. 치수와, 메타데이터를 이용해서 pdf render 개체 생성
      let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
        
      // 4. 렌더러가 그래픽 컨텍스트를 생성
      let data = renderer.pdfData { (context) in
        context.beginPage() // begin: 새 PDF페이지 시작.

        let titleBottom = addTitle(pageRect: pageRect)
        let imageBottom = addImage(pageRect: pageRect, imageTop: titleBottom + 18.0)
        addBodyText(pageRect: pageRect, textTop: imageBottom + 18.0)

        let context = context.cgContext
        drawTearOffs(context, pageRect: pageRect, tearOffY: pageRect.height * 4.0 / 5.0,
                     numberTabs: 8)
        drawContactLabels(context, pageRect: pageRect, numberTabs: 8)
      }

      return data
    }
    
    /**
     Add Center Title
     - pageRect: pdf 전체 페이지
     */
    func addTitle(pageRect: CGRect) -> CGFloat {
      let titleFont = UIFont.systemFont(ofSize: 18.0, weight: .bold)
      let titleAttributes: [NSAttributedString.Key: Any] =
        [NSAttributedString.Key.font: titleFont]
      let attributedTitle = NSAttributedString(
        string: title,
        attributes: titleAttributes
      )
      let titleStringSize = attributedTitle.size()
        
    // 제목을 센터에 배치하기 위해 좌표 계산
      let titleStringRect = CGRect(
        // 전체 페이지의 넓이에서 문자열 넓이를 빼서 나머지 공간계산후, 2로 나누어 정가운데 베치되도록 함
        x: (pageRect.width - titleStringSize.width) / 2.0,
        y: 36,
        width: titleStringSize.width,
        height: titleStringSize.height
      )
      
        // draw: 문자열을 현재 컨텍스트에 그림
      attributedTitle.draw(in: titleStringRect)
      
        //전체 페이지에서 타이틀이 들어간 하단의 좌표를 반환
      return titleStringRect.origin.y + titleStringRect.size.height
    }

    
    /**
     pdf 에 상세 내용 추가
     - pageRect: 전체 페이지
     - textTop: Y 좌표. 어느지점 부터 그릴건지
     */
    func addBodyText(pageRect: CGRect, textTop: CGFloat) {
      let textFont = UIFont.systemFont(ofSize: 12.0, weight: .regular)
      // NSMutableParagraphStyle: 텍스트 흐름, 줄바꿈 방법 정의 가능
      let paragraphStyle = NSMutableParagraphStyle()
      paragraphStyle.alignment = .natural
      paragraphStyle.lineBreakMode = .byWordWrapping
      
      let textAttributes = [
        NSAttributedString.Key.paragraphStyle: paragraphStyle,
        NSAttributedString.Key.font: textFont
      ]
      let attributedText = NSAttributedString(string: body, attributes: textAttributes)
      //높이: 전체 페이지 높이의 상단에서 하단 1/5까지의 거리
      let textRect = CGRect(x: 10, y: textTop, width: pageRect.width - 20,
                            height: pageRect.height - textTop - pageRect.height / 5.0)
      attributedText.draw(in: textRect)
    }

    
    func addImage(pageRect: CGRect, imageTop: CGFloat) -> CGFloat {
      // 최대 높이, 넓이를 전체페이지의 비율값으로 설정
      let maxHeight = pageRect.height * 0.4
      let maxWidth = pageRect.width * 0.8
        
      // 실제 비율을 계산한 다음, 넓이와 높이 비율중 작은 비율을 이미지 크기 조절 기준 비율로 삼는다
      let aspectWidth = maxWidth / image.size.width
      let aspectHeight = maxHeight / image.size.height
      let aspectRatio = min(aspectWidth, aspectHeight)
      
        // 비율이 적용된 실제 사이즈 계산
      let scaledWidth = image.size.width * aspectRatio
      let scaledHeight = image.size.height * aspectRatio
        
      let imageX = (pageRect.width - scaledWidth) / 2.0 // 이미지의 센터 좌표
      let imageRect = CGRect(x: imageX, y: imageTop,
                             width: scaledWidth, height: scaledHeight)
      
        // 조정한 imageRect 에 맞춰서 이미지를 그린다
      image.draw(in: imageRect)
      return imageRect.origin.y + imageRect.size.height
    }
    
    /**
     라인 그리기
     전단지 처럼 나타내기 위해, 실선와 점선을 그린다
     - drawContext: 그릴 컨텍스트
     - pageRect: 전체 페이지
     - tearOffY: 상단 위치
     - numberTabs: 탭 갯수
     */
    func drawTearOffs(_ drawContext: CGContext, pageRect: CGRect,
                      tearOffY: CGFloat, numberTabs: Int) {
      // 그래픽 컨텍스트의 현재 상태 저장.
      drawContext.saveGState()
        // 라인 너비 설정
      drawContext.setLineWidth(2.0)
      
      // 그릴 위치tearOffY 에서, 왼쪽 -> 오른쪽으로 수평선을 그은 다음 이전에 저장된 상태를 복원
      drawContext.move(to: CGPoint(x: 0, y: tearOffY))
      drawContext.addLine(to: CGPoint(x: pageRect.width, y: tearOffY))
      drawContext.strokePath()
      drawContext.restoreGState()
      
      // 탭 사이에 점선 그리기 시작
      drawContext.saveGState()
      let dashLength = CGFloat(72.0 * 0.2) // 점선 길이 정의
      drawContext.setLineDash(phase: 0, lengths: [dashLength, dashLength])
        
      // 각 탭의 너비 계산
        // 한개의 탭 너비 = 전체 페이지 너비 / 탭 갯수
      let tabWidth = pageRect.width / CGFloat(numberTabs)
      for tearOffIndex in 1..<numberTabs {
        // 위에서 페이지의 가장 아래로 점선을 긋는다
        let tabX = CGFloat(tearOffIndex) * tabWidth
        drawContext.move(to: CGPoint(x: tabX, y: tearOffY))
        drawContext.addLine(to: CGPoint(x: tabX, y: pageRect.height))
        drawContext.strokePath()
      }
        
      // 모든 선을 그은후, 그래픽 상태 복원함
      drawContext.restoreGState()
    }
    
    /**
     탭 안에 들어갈 텍스트 그리기
     
     */
    //-90 회전했을때
    //    +x
    // -y    +y
    //    -x
    //
    //
    //
    func drawContactLabels(_ drawContext: CGContext, pageRect: CGRect, numberTabs: Int) {
      let contactTextFont = UIFont.systemFont(ofSize: 10.0, weight: .regular)
      let paragraphStyle = NSMutableParagraphStyle()
      paragraphStyle.alignment = .natural
      paragraphStyle.lineBreakMode = .byWordWrapping
      let contactBlurbAttributes = [
        NSAttributedString.Key.paragraphStyle: paragraphStyle,
        NSAttributedString.Key.font: contactTextFont
      ]
      let attributedContactText = NSMutableAttributedString(string: contactInfo, attributes: contactBlurbAttributes)
        
      // size() 로 문자열을 그리는데 필요한 최소 크기를 찾음
      let textHeight = attributedContactText.size().height
      let tabWidth = pageRect.width / CGFloat(numberTabs)
      let horizontalOffset = (tabWidth - textHeight) / 2.0
      drawContext.saveGState()
      
        // 시계 반대반향(-)으로 90 도 회전.
      drawContext.rotate(by: -90.0 * CGFloat.pi / 180.0)
      for tearOffIndex in 0...numberTabs {
        let tabX = CGFloat(tearOffIndex) * tabWidth + horizontalOffset
        
        // 회전하게 되며느 좌표계도 같이 회전 하게 됨. -> x, y 값을 반대로 입력해야 함
        attributedContactText.draw(at: CGPoint(x: -pageRect.height + 5.0, y: tabX))
      }
      drawContext.restoreGState()
    }
}
