# BookShelf

### 책장 앱 :fireworks:
github: https://github.com/eunjiChung/BookShelf.git


## 기능 

첫번째 화면 : 최신 IT관련 도서 페이지
- 최신 IT 관련 도서들이 불린다

두번째 화면 : 검색 페이지
- 원하는 키워드로 책을 검색한다
- 스크롤링, 새로고침 기능 

세번째 화면 : 상세 페이지
- 선택한 책에 대한 상세 정보를 볼 수 있는 화면




## 사용 CocoaPod Library
- AFNetworking : 최신 도서 정보, 검색 도서 정보, 책의 상세 정보를 불러오기 위한 네트워크 라이브러리
- SVPullToRefresh : TableView를 refresh하고 infiniteScrolling을 가능하게 해준다




## 구성

### Design Pattern : MVC 패턴 사용

### View 
- Main.Stroyboard : 3가지 주요 Scene 사용(New, Search, Detail View Controller Scenes)
- BookTableViewCell.xib : New, Search View Controller에서 책을 테이블 뷰로 나타낼 때 공통으로 사용하는 셀  
- ResultInfoTableViewCell.xib : Search View Controller의 테이블 뷰 첫번째 셀에 위치한, 검색 결과를 알려주는 셀
- Detail Cells : DetailViewController에서 쓰는 셀들
> 1. Detail Book Image Table View Cell : 책 이미지를 보여주는 셀
> 2. Detail Book Info Table View Cell : 책 관련 정보를 보여주는 셀
> 3. Detail Book Desc Table View Cell : 간략한 책의 줄거리를 나타내는 셀


### Controller
- BasicViewController : 모든 ViewController의 베이스가 되는 VC. 알림창, 하이퍼링크 전환 기능 포함.
- NewViewController : 최신 도서를 보여주는 ViewController
- SearchViewController : 검색 결과를 보여주는 ViewController
- DetailViewController : 선택한 도서 상세 페이지를 보여주는 ViewController

### Model
- EJHTTPClient : URL path를 가지고, http request를 담당하는 Singleton 라이브러리
- 책 모델
> 1. NewBooks : 새로운 책 리스트에 대한 정보를 매핑하는 클래스 
> 2. SearchBooks : 검색한 책 리스트에 대한 정보를 매핑하는 클래스
> 3. BookModel : 한 권의 책에 대한 상세한 정보를 가진 클래스














