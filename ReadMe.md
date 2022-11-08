# Twitter Clone Project
> Twitter iOS Clone | Swift 5/Firebase | No Storyboards | MVVM

[![NPM Version][npm-image]][npm-url]
[![Build Status][travis-image]][travis-url]
[![Downloads Stats][npm-downloads]][npm-url]

Swift 5, Firebase 및 MVVM 아키텍처를 사용하여 iOS 13용 Twitter Clone 구축 프로젝트

![background](./background.jpeg)

![GitHub top language](https://img.shields.io/github/languages/top/Hyeon-Jun-Kim/Programmers.svg?color=darkgreen&logo=swift)  ![GitHub last commit](https://img.shields.io/github/last-commit/Hyeon-Jun-Kim/Programmers.svg?color=cc33ff) 

## 프로젝트 소개

Twitter CloneCoading Project 

### 사용 기술 및 라이브러리
- Swift, iOS
- FireBase
- CocoaPod(Active Label, SDWebImage)
- MVVM Pattern
   
### 구현 기능
- 로그인 & 회원가입
- 트윗 작성 & 게시글 좋아요 기능
- 댓글 & 멘션
- Tag & HashTag
- 사용자 검색
- 프로필 페이지(프로필 정보 수정 & 트윗 필터링)
- Follow & Unfollow
- Follow, mention 알림(Notification)
    
#### 참여자 : 김현준(iOS Developer) holden.developer@gmail.com(총 1명)

#### 진행 기간 : 2022.10.07 - 2022.11.03 (총 4주) 

<br/>

## Architecture
![Architecture](https://user-images.githubusercontent.com/59905688/200632487-a1900bb0-9efa-47ca-9d0a-15eb2d3c480a.png)

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

## Feature-1. 데이터 목록화면 구현

### UI
![Simulator Screen Shot - iPhone 11 Pro - 2022-11-09 at 02 47 00](https://user-images.githubusercontent.com/59905688/200640701-f844f351-fd9b-4c56-bc2e-9c1e2ca9b755.png)

### Trouble Shooting
#### Table View cell Event 문제
- 문제점 :  특정 행을 선택했을 때 데이터가 그래프상에 어디에 위치하는지 보여주는 기능과 상세 데이터를 볼수 있는 화면으로 이동하는 두가지 기능을 가져야 했습니다. 처음 화면이 로드되었을 때 첫번째 행이 자동으로 활성화 되고 다른 행이 선택되었을 때 accessory가 남아있는 오류가 발생했습니다.
- 해결방안 :  cell이 선택되었을 때 발생하는 이벤트를 내부에서 if문으로 나누어 해당 행의 활성화 유무를 판단하고 비활성 상태였을 경우 첫번째 행을 비활성화 한 뒤 `NotificationCenter` 를 통해 cell에서 호출한 함수가 동작하여 Graph 위에 점을 표시하도록 구현했습니다. 이후 한번 더 선택되었을 때 데이터와 함께 데이터 상세 페이지(`dataDetailController`)를 present 합니다.

#### Cell 값에 따라 Graph 위의 점이 정확하게 표시되지 않는 문제
- 문제점 :  각각의 Cell이 갖는 데이터(Alkalinity, Hardness)가 세가지 표준(SCA, SCAE, ColonaDashwood & Hendon)을 얼마나 충족하는지 시각적으로 그래프 위에 표시되어야 하지만 Auto Layout의 특성상 기기가 달라지면 Graph의 사이즈가 달라져 점의 위치가 정확하게 표시되지 않는 문제가 발생했습니다.
- 해결방안 :  그래프 위에 점이 표시되는 영역의 사이즈를 갖는 View를 추가하고 위치를 고정하였습니다. 또한 최대 입력값의 좌표인 (120, 200)의 위치에 점이 위치할 때의 값을 찾아 각각 나누어 x축과 y축의 한칸의 이동값을 찾아 곱하여 이동시키는 방식으로 문제를 해결하였습니다.
           (* Ver 2.0 에서 비율을 구하여 곱해주는 방식으로 수정 예정입니다.)
