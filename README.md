# Calculator
- 계산기 특성상 많은 기능을 GIF로 담아낼수 없어 다른 프로젝트와 달리 작동 화면 없음.
- 각각 다른 해상도에도 일정한 화면을 보여주기 위해 각 sub view에 비율을 세팅해 구성한 프로젝트. 

## 🍎 모든 화면에 맞는 Stack View
- 지금까지는 화면에 해상도에 따라 사이즈를 맞추는 stack view를 만들어 본 적이 없었다.
- 이번 프로젝트에서는 어떤 해상도에도 일정한 화면을 보여주는 stack view를 만들어봤다.

## 🍎 Vertical Stack View의 Priority를 낮춰 바뀌는 해상도에 대한 유동적인 대응하기
- UI는 하나의 Vertical Stack View가 5개의 Horizontal Stack View를 감싸고 있는 형태이며, 각각의 Alignment와 Distribution은 다음과 같다.

| vertical | Horizontal|
|:-:|:-:|
| ![](https://i.imgur.com/LVpbKo4.png)| ![](https://i.imgur.com/j86xls9.png)|
- 먼저 Vertical Stack View의 Alignment와 Distribution을 보면 Fill과 Fill로 되어있다. 즉, Vertical Stack view내 sub view들의 가로로 쭈욱 늘리고, 세로로 겹겹이 쌓여있을때 sub view들을 vertical stack view의 높이만큼 꽉 채워주겠다는 의미이다.
- 다음, Horizontal Stack View의 Alignment와 Distribution을 보면 Fill과 Equal Spacing이다. 즉, 아이템들을 세로로 쭈욱 늘리고 아이템이 가로로 겹겹이 쌓여있을때 sub view들을 horizontal stack view의 넓이만큼 늘려주겠다는 의미이다.
![](https://i.imgur.com/QuIX7jf.png)
- 또, **제일 중요한 부분**은 'AC'와 '0'을 제외한 모든 버튼의 Aspect Ratio는 1:1이다. 'AC'는 '9'의 trailing에, '0'은 '2'의 trailing에 맞춰주었다. (사진 참고)
![](https://i.imgur.com/gtSoaUW.png)
- 이제 마지막으로 Vertical Stack View와 해당 vertical stack view의 superview인 UIView 사이에 제약조건 중 Bottom Priority를 1000(Require)에서 750(High)로 낮춰줘 각기 다른 화면 사이즈에서 동일한 비율로 UI를 보여줄 수 있다.

## 🍎 스토리보드에서 간단하게 버튼 속성 조정하기
- UIButton 클래스를 상속하는 커스텀 클래스를 아래와 같이 만들어준다.
![](https://i.imgur.com/OUYEsvY.png)
- 각각의 버튼의 Custom Class를 방금 만들어준 클래스로 지정한다.
![](https://i.imgur.com/83yuTqI.png)
- 이제 attributes inspector에서 선택해주면 끝!
![](https://i.imgur.com/GfXMSnt.png)
- 모든 버튼의 속성을 'On'으로 했을때 결과
![](https://i.imgur.com/iKtQ3Bw.png)
- **발견한점**
- @IBDesignable을 어트리뷰트를 사용하면 스토리보드에서 실시간으로 변하는것을 볼 수 있다고 배웠는데, 많이 기다리지 않아서 그런것인지, 아니면 다른 추가적인 작업이 또 필요한지 모르겠지만 아예 바뀌지 않았다.

## 🍎 계산 결과에 소수점이 있는지 확인하고 없다면 정수로 바꾸기
- 계산기의 로직은 다루지 않으려고 했는데 나중에 사용할 수 있을것 같아 기록!
- 바로 코드를 보자!
```swift
if let result = Double(result), result.truncatingRemainder(dividingBy: 1) == 0 {
    self.result = "\(Int(result))"
}
```
- 먼저 일반적으로 사용했던 나머지 연산자 '%'는 두개의 피연산자 모두 정수여야 가능하다. **즉, 하나라도 실수라면 나머지 연산자(%) 사용 불가.** 둘 중 하나라도 실수인 피연산자가 있다면 truncatingRemainder(dividingBy:) 메서드를 사용하자.
- 위의 코드는 result(실수)를 1로 나누었을 때 나머지가 0과 같다면 'x.0' 이니 일반 정수로 표현할 수 있게 필터링하는 코드이다.
