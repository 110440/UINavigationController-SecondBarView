# UINavigationController-SecondBarView
This category is used for add a custom view below UINavigationController's NavigationBar.Typical a second navibar or progressView

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
