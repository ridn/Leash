@interface SBNotificationCenterViewController
- (void)setSelectedViewController:(id)arg1 animated:(_Bool)arg2;
- (void)handleModeChange:(id)arg1;
- (_Bool)isGrabberLocked;

@end
%hook SBNotificationCenterViewController
int y;
- (struct CGRect)positionContentForTouchAtLocation:(struct CGPoint)arg1
{
    if(self && arg1.y > 0 && arg1.x > 0 && ![self isGrabberLocked]){
        id modeViewController = MSHookIvar<id>(MSHookIvar<id>(self,"_layoutViewController"),"_modeViewController");
        
        double sectionSize = %orig.size.width / [[modeViewController viewControllers]count];
		int index = (arg1.x / sectionSize) ;
		if((arg1.y >= y && arg1.y - y != arg1.y) && ![MSHookIvar<id>(modeViewController,"_selectedViewController") isEqual:[[modeViewController viewControllers]objectAtIndex:index]]){
			[modeViewController setSelectedViewController:[[modeViewController viewControllers]objectAtIndex:index]animated:YES];
			//[modeViewController handleModeChange:0];
		}
    	y = arg1.y;

    }
    return %orig;
}
%end