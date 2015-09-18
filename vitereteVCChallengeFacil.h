//
//  vitereteVCChallengeFacil.h
//  Barce Memo 2013
//
//  Created by Victor Pinto on 01/08/13.
//  Copyright (c) 2013 Victor Pinto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVAudioPlayer.h>
#import <iAd/iAd.h>

@interface vitereteVCChallengeFacil : UIViewController <AVAudioPlayerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UIAlertViewDelegate,ADBannerViewDelegate>

@property AVAudioPlayer *sonido;
@property NSURL *url;
@property NSTimer *timer;
@property UIAlertView *alerta;
@property (nonatomic,weak) IBOutlet UICollectionView *cv;
@property (nonatomic,weak) IBOutlet UILabel *LBpuntaje;
@property (nonatomic,weak) IBOutlet UILabel *LBturnos;
@property (nonatomic,weak) IBOutlet UILabel *LBtiempo;
@property (nonatomic,weak) IBOutlet UIButton *BTreiniciar;
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
