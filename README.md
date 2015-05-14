# UINavigationController-SecondBarView
This category is used for add a custom view below UINavigationController's NavigationBar.Typical a navibar or a progressView

## How to use
```
Drag UINavigationContr+SecondBarView to your project
```
```
#import "UINavigationController+SeconBarView.h"
```
```
[self.navigationController setSecondBarViewHeight:40];
```
```
[self.navigationController setSecondBarView:view];
```
```
[self.navigationController showSecondBarView:false];
```

When Second Bar View showed or hided, we also have to method will be called. if you care about that, you should override it in your viewcontroller
```
- (void) secondBarDidShow;
```
````
- (void) secondBarDidHide;
````

###Demo
<img src="https://github.com/Jameson-zxm/UINavigationController-SecondBarView/blob/master/demo.gif" width="400" height="568" />
