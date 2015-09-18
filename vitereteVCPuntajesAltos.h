//
//  vitereteVCPuntajesAltos.h
//  Barce Memo 2013
//
//  Created by Victor Pinto on 30/07/13.
//  Copyright (c) 2013 Victor Pinto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"

@interface vitereteVCPuntajesAltos : UIViewController <UICollectionViewDataSource,UICollectionViewDelegate>
{
    sqlite3 *db;
}
//@property NSMutableArray *valuesFila;
//@property NSMutableArray *valuesNombre;
//@property NSMutableArray *valuesPuntaje;
@property IBOutlet UIActivityIndicatorView *indicador;
@property (nonatomic,weak) IBOutlet UICollectionView *cv1,*cv2,*cv3;

//base de datos
-(NSString*)path;
-(void)abrir;
-(void)leaderboardCargado;

@end
