# Water For Coffee
> Brewing water chemistry log Application | Swift 5/CoreData | No Storyboards | MVC

![background](./background.png) 

<img width="1440" alt="AppStore" src="https://user-images.githubusercontent.com/59905688/200632348-2b9642f7-4484-4e08-9b13-4c76824afaa9.png">

![GitHub top language](https://img.shields.io/github/languages/top/Hyeon-Jun-Kim/Programmers.svg?color=darkgreen&logo=swift)  ![GitHub last commit](https://img.shields.io/github/last-commit/Hyeon-Jun-Kim/Programmers.svg?color=cc33ff)

## 프로젝트 소개

WaterForCoffee는 brewing water chemistry log Application 입니다.

사용자가 물의 성분을 입력하면 도표를 통해 분석한 데이터를 시각적으로 보여줍니다.
필터와 부가적인 정보를 함께 저장하여 브루잉에 사용되는 물에 대한 정보를 축적 및 공유하는 기능을 제공합니다.

`Core Data`를 통해 데이터를 관리합니다(CRUD).     
`MVC`를 적용했습니다.
`UIKit`을 활용하여 코드로 오토레이아웃을 구현했습니다.
   
- 참여자 : 김현준(iOS Developer) holden.developer@gmail.com, 박성용(iOS Developer) sungyong.park6@gmail.com, 장인희(UI/UX Designer) inheejang@gmail (총 3명)
         
- 진행 기간 : 2022.08.23 - 2022.09.29 (총 5주)   
<br/>

## Architecture
![Architecture](https://user-images.githubusercontent.com/59905688/200632487-a1900bb0-9efa-47ca-9d0a-15eb2d3c480a.png)

## Foldering
```
TargetWaterForCoffee
├── AppDelegate
├── ScenDelegate
├── Controllers
│   ├── CafeDetailViewController
│   ├── AddDataViewController
│   ├── DataDetailController
│   ├── DataDetailShareController
│   ├── DataDetailUpDelController
│   └── InfoViewController
├── Views
│   ├── DataTableHeaderUIView
│   ├── DataTableViewCell
│   ├── AddDataTableViewCell
│   ├── InfoTableViewCell
│   └── LogoUIView
├── Models
│   ├── CafeDetail+CoreDataClass
│   └── CafeDetail+CoreDataProperties
└── Utils
    ├── Extentensions
    ├── CheckGraphData
    ├── DateManager
    └── CoreDataManager
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

## Feature-2. 데이터 추가화면 구현

### UI
<img width="608" alt="스크린샷 2022-11-09 오전 3 03 02" src="https://user-images.githubusercontent.com/59905688/200641324-54adad09-87b3-413e-8d61-393f90e92faa.png">

### 2️⃣ Trouble Shooting
####  IPhone 8에서 tableView가 전부 보이지 않는 문제
- 문제점 : `Save Button`의 위치값을 고정해두어 Frame의 높이가 상대적으로 낮은 기기에서 TabelVew를 가리는 현상이 발생함
- 해결방법 : Frame의 높이값의 1/4만큼 하단에서 떨어지도록 비율을 구하여 위치시켜 해결함

## Feature-3. 데이터 상세화면 구현

### UI
<img width="971" alt="스크린샷 2022-11-09 오전 3 07 09" src="https://user-images.githubusercontent.com/59905688/200642055-e7abae5d-2e43-4d43-92dd-cc542026cd7a.png">

### Trouble Shooting
#### 정보 수정 시 잦은 화면 전환으로 딜레이가 발생하는 문제
- 문제점 :  초기 UI 설계는 상세 데이터 페이지(`DataDetailController`)에서 정보 수정을 할 때 팝업창이 보여지게 되며 수정 데이터를 입력 후 저장을 하는 방식이었다. 수정된 데이터를 다시 불러와 상세 데이터 페이지에서 보여지도록 하는 과정에서 작은 딜레이가 발생하였고 사용자 편의성이 떨어진다 느껴져 다른 방식을 고민하게 되었다.
- 해결방안 :  새로운 팝업창을 띄우지 않고 상세 데이터 페이지에서 데이터를 보여주는 `UITextView`의 `.isEditable` 속성과 `keyboardWillShow` 함수를 통해 페이지 내에서 즉각적인 정보 수정이 가능하도록 하여 해결하였다.
