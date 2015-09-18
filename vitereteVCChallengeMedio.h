//
//  vitereteVCChallengeMedio.h
//  Barce Memo 2013
//
//  Created by Victor Pinto on 05/08/13.
//  Copyright (c) 2013 Victor Pinto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVAudioPlayer.h>
#import "sqlite3.h"
#import <iAd/iAd.h>

@interface vitereteVCChallengeMedio : UIViewController <AVAudioPlayerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UIAlertViewDelegate,ADBannerViewDelegate>

@property AVAudioPlayer *sonido;
@property NSURL *url;
@property NSTimer *timer;
@property UIAlertView *alerta;
@property (nonatomic,weak) IBOutlet UICollectionView *cv;
@property (nonatomic,strong) IBOutlet UILabel *LBpuntaje;
@property (nonatomic,strong) IBOutlet UILabel *LBturnos;
@property (nonatomic,strong) IBOutlet UILabel *LBtiempo;
@property (nonatomic,strong) IBOutlet UIButton *BTreiniciar;
@property (nonatomic, assign, getter=isWorking) BOOL ad;

-(void)reproducirSonido;
-(IBAction)reiniciar:(id)sender;
-(void)aumentarTiempo;
-(void)shuffle;
-(void)cerrarAlerta;
-(void)esconder;
-(void)reponer:(NSIndexPath*)index;
-(void)checkWin;
-(void)recargar;
-(BOOL)compar:(NSString*)carta1 ar:(NSString*)carta2;

@end
