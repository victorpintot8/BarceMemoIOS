//
//  vitereteResultadoViewController.h
//  Barce Memo 2013
//
//  Created by Victor Pinto on 15/10/13.
//  Copyright (c) 2013 Victor Pinto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface vitereteResultadoViewController : UIViewController

@property (nonatomic,weak) IBOutlet UILabel *turnos;
@property (nonatomic,weak) IBOutlet UILabel *tiempo;
@property (nonatomic,weak) IBOutlet UILabel *puntaje;
@property (nonatomic,weak) IBOutlet UILabel *bonoTurnos;
@property (nonatomic,weak) IBOutlet UILabel *bonoTiempo;
@property (nonatomic,weak) IBOutlet UILabel *puntajeTotal;

@property NSString *Sturnos,*Stiempo,*Spuntaje,*SbonoTurnos,*SbonoTiempo,*SpuntajeTotal;

-(IBAction)compartir:(id)sender;
-(IBAction)atras:(id)sender;
-(IBAction)juegaDeNuevo:(id)sender;
-(UIViewController *)backViewController;

@end
