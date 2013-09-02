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

@interface vitereteVCChallengeMedio : UIViewController <AVAudioPlayerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UIAlertViewDelegate>
{
    sqlite3 *db;
}

@property AVAudioPlayer *sonido;
@property NSURL *url;
@property NSTimer *timer;
@property UIAlertView *alerta;
@property (nonatomic,strong) IBOutlet UICollectionView *cv;
@property (nonatomic,strong) IBOutlet UILabel *LBpuntaje;
@property (nonatomic,strong) IBOutlet UILabel *LBturnos;
@property (nonatomic,strong) IBOutlet UILabel *LBtiempo;
@property (nonatomic,strong) IBOutlet UIButton *BTreiniciar;

//base de datos
@property (nonatomic,readonly) NSNumber *clave;
-(NSString*)path;
-(void)abrir;
-(void)crearTabla:(NSString*)nombreTabla conClave:(NSString*)clave conNombre:(NSString*)nombre conPuntaje:(NSString*)puntaje1;
-(void)insertarPuntaje:(NSNumber*)puntajeFinal;

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
-(void)willPresentAlertView:(UIAlertView *)alertView;

@end
