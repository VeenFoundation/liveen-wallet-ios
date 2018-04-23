## 설치가이드
#### 1. CocoaPod 설치하기 (설치되어있으면 건너뛰어도 좋음)
> $ sudo gem install cocoapods

#### 2. 패키지 설치하기
> $ cd ./LiveenWallet

> $ pod update

> $ pod install

```
Analyzing dependencies
Downloading dependencies
Using MDFInternationalization (1.0.4)
Using MaterialComponents (54.9.0)
Installing TextFieldEffects (1.4.0)
Generating Pods project
Integrating client project
Sending stats
Pod installation complete! There are 2 dependencies from the Podfile and 3 total pods installed.
```

이렇게 나오면 성공한 겁니다.

그 다음엔 Xcode로 프로젝트 열때 `LiveenWallet.xcworkspace` 파일로 여시면 됩니다.
