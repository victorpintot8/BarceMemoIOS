//
//  vitereteVCPreferencias.h
//  Barce Memo 2013
//
//  Created by Victor Pinto on 28/07/13.
//  Copyright (c) 2013 Victor Pinto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface vitereteVCPreferencias : UIViewController

@property NSMutableArray *listaCanciones;
@property (nonatomic,strong) IBOutlet UIPickerView *pickerV;
@property (nonatomic,strong) IBOutlet UISwitch *swCancion;

-(IBAction)switchSeleccionado:(id)sender;
-(IBAction)acercaDe:(id)sender;
@end
