//
//  vitereteViewController.h
//  Barce Memo 2013
//
//  Created by Victor Pinto on 25/07/13.
//  Copyright (c) 2013 Victor Pinto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface vitereteViewController : UIViewController <UIAlertViewDelegate>


-(IBAction)elegirNivel:(id)sender;
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end
