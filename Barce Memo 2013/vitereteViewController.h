//
//  vitereteViewController.h
//  Barce Memo 2013
//
//  Created by Victor Pinto on 25/07/13.
//  Copyright (c) 2013 Victor Pinto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>

@interface vitereteViewController : UIViewController <UIAlertViewDelegate,GKGameCenterControllerDelegate>

@property (nonatomic,weak) IBOutlet UILabel *titulo;

-(IBAction)elegirNivel:(id)sender;
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
-(IBAction)mostrarLogrosController:(id)sender;
-(void)gameCenterViewControllerDidFinish:(GKGameCenterViewController
                                           *)gameCenterViewController;

@end
