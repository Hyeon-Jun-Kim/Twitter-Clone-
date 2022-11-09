# Twitter Clone Project
> Twitter iOS Clone | Swift 5/Firebase | No Storyboards | MVVM

Swift 5, Firebase 및 MVVM 아키텍처를 사용하여 iOS 13용 Twitter Clone 구축 프로젝트

![background](./background.jpeg)

![GitHub top language](https://img.shields.io/github/languages/top/Hyeon-Jun-Kim/Programmers.svg?color=darkgreen&logo=swift)  ![GitHub last commit](https://img.shields.io/github/last-commit/Hyeon-Jun-Kim/Programmers.svg?color=cc33ff) 

## 프로젝트 소개

Twitter CloneCoading Project 

- 사용 기술 및 라이브러리
    + Swift, iOS
    + FireBase
    + CocoaPod(Active Label, SDWebImage)
    + MVVM Pattern
   
- 구현 기능
    + 로그인 & 회원가입
    + 트윗 작성 & 게시글 좋아요 기능
    + 댓글 & 멘션
    + Tag & HashTag
    + 사용자 검색
    + 프로필 페이지(프로필 정보 수정 & 트윗 필터링)
    + Follow & Unfollow
    + Follow, mention 알림(Notification)
    
- 참여자 : 김현준(iOS Developer) holden.developer@gmail.com(총 1명)

- 진행 기간 : 2022.10.07 - 2022.11.03 (총 4주) 
<br/>

## Foldering
```
TwitterClone
├── AppDelegate
├── ScenDelegate
├── Model
│   ├── User
│   ├── Tweet
│   └── Notification
├── View
│   ├── Profile
│   │    ├── ProfileHeader
│   │    ├── ProfileFIlterView
│   │    ├── ProfileFilterCell
│   │    ├── EditProfileHeader
│   │    ├── EditProfileCell
│   │    └── EditProfileFooter
│   ├── InputTextView
│   ├── TweetCell
│   ├── UserCell
│   ├── TweetHeader
│   ├── ActionSheetCell
│   └── NotificationCell
├── ViewModel
│   ├── TweetViewModel
│   ├── ProfileHeaderViewModel
│   ├── UploadTweetViewModel
│   ├── ActionSheetViewModel
│   ├── NotificationViewModel
│   └── EditProfileViewModel
├── Controller
│   ├── Authentication
│   │    ├── LoginController
│   │    └── RegisteractionController
│   ├── MainTabController
│   ├── FeedController
│   ├── SearchController
│   ├── NotificationsController
│   ├── ConversationsController
│   ├── UploadTweetController
│   ├── ProfileController
│   ├── TweetController
│   └── EditProfileController
├── API
│   ├── AuthService
│   ├── UserService
│   ├── TweerService
│   └── NotificationService
└── Utils
    ├── Extentensions
    ├── Utilities
    ├── Constants
    └── ActionSheetLauncher
```

### UI

<img width="1440" alt="1" src="https://user-images.githubusercontent.com/59905688/200775732-f4787f9b-9e30-423d-89df-beb04c393bd8.png">
<img width="1440" alt="2" src="https://user-images.githubusercontent.com/59905688/200775781-696f8fb6-09e4-4c2b-b60d-08e34f4bcd96.png">

## Learning content. 

- MVVM Design Pattern
    +  Model, View, ViewModel, Controller로 나누어 MVC Pattern의 가장 큰 문제점인 Massive Controller를 방지하고 유지 보수가 용이하도록 구현했습니다.
    
- 로그인 데이터 메모리에 저장
    + Login 페이지에서 로그인 시 로그인 정보를 메모리에 저장하여 App 종료 후 다시 실행되었을 때 로그인 여부를 확인 후 화면을 로드하도록 구현했습니다.
    + Code: `<MainTapController>`
        
        ```swift
        func authenticateUserAndConfugureUI() {
              if Auth.auth().currentUser == nil { // User is Not loggen in
                  DispatchQueue.main.async {
                      let nav = UINavigationController(rootViewController: LoginController())
                      nav.modalPresentationStyle = .fullScreen
                      self.present(nav, animated: true, completion: nil)
                  }
              } else { // User is loggen in
                  configeureViewControllers()
                  configureUI()
                  fetchUser()
              }
        ```
        
- UITapGestureRecognizer
    + UIImageView 와 같은 ActionHandler가 별도로 없는 객체에 제스처가 입력되는것을 감지할 수 있도록 하여 보다 다양한 객체와 사용자가 상호 작용이 가능하도록 구현했습니다.
    + Code: `<TweetHeader>`
        
        ```swift
        private lazy var profileImageView: UIImageView = {
                let iv = UIImageView()
                iv.contentMode = .scaleAspectFit
                iv.clipsToBounds = true
                iv.setDimensions(width: 48, height: 48)
                iv.layer.cornerRadius = 48 / 2
                iv.backgroundColor = .twitterBlue
                
                let tap = UITapGestureRecognizer(target: self, action: #selector(handleProfileImageTapped))
                iv.addGestureRecognizer(tap)
                iv.isUserInteractionEnabled = true
                
                return iv
            }()
        ```

- CustomModal
    + 이전 WaterForCoffee프로젝트를 진행할 때 Custom Modal을 만든 방식은 View 자체의 높이값을 제한하고 이외의 영역에 Tap Gesture가 발생했을 때 이를 감지하고 View를 닫는 방법으로 구현했습니다.
    + 이번 프로젝트에서는 VIew 내부에 검은 화면 영역을 담당하는 blackView 위에 TableView를 포함한 footerView를 더하였습니다. blackView에 `.addGestureRecognizer` 를 통해 View를 닫도록 하여 다양한 방법으로 Custom Modal을 구현할 수 있다는 것을 배웠습니다.
    + Code : `<ActionSheetLauncher>`
        
        ```swift
        private lazy var blackView: UIView = {
                let view = UIView()
                view.alpha = 0
                view.backgroundColor = UIColor(white: 0, alpha: 0.5)
                
                let tap = UITapGestureRecognizer(target: self, action: #selector(handleDismissal))
                view.addGestureRecognizer(tap)
                
                return view
            }()
            
            private lazy var footerView: UIView = {
                let view = UIView()
                
                view.addSubview(cancelButton)
                cancelButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
                cancelButton.anchor(left: view.leftAnchor, right: view.rightAnchor,
                                    paddingLeft: 12, paddingRight: 12)
                cancelButton.centerY(inView: view)
                cancelButton.layer.cornerRadius = 50 / 2
                
                return view
            }()
        ```

- SDWebImage Library
    + FireBase에 업로드한 이미지를 URL을 통해 비동기적으로 받아와 캐싱하여 사용할 수 있도록 하는 Library를 활용하였습니다. 이를 통해 Web에서 이미지를 받아오는 속도를 줄일 수 있었습니다.
    + Code: `<FeedController>`
        
        ```swift
        func configureLeftBarButton() {
                guard let user = user else { return }
                
                let profileImageView = UIImageView()
                profileImageView.setDimensions(width: 32, height: 32)
                profileImageView.layer.cornerRadius = 32 / 2
                profileImageView.layer.masksToBounds = true
                profileImageView.isUserInteractionEnabled = true
                
                let tap = UITapGestureRecognizer(target: self, action: #selector(handleProfileImageTap))
                profileImageView.addGestureRecognizer(tap)
                
                profileImageView.sd_setImage(with: user.profileImageUrl, completed: nil)
                
                navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
            }
        ```

