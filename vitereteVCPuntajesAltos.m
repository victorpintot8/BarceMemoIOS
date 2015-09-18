//
//  vitereteVCPuntajesAltos.m
//  Barce Memo 2013
//
//  Created by Victor Pinto on 30/07/13.
//  Copyright (c) 2013 Victor Pinto. All rights reserved.
//

#import "vitereteVCPuntajesAltos.h"
#import "viteretePuntajesAltosCell.h"
#import "vitereteCeldaNombre.h"
#import "vitereteCeldaPuntaje.h"
#import "GameCenterManager.h"

@interface vitereteVCPuntajesAltos ()
{
    NSNumber *nFilas;
    NSMutableArray *valuesFila;
    NSMutableArray *valuesNombre;
    NSMutableArray *valuesPuntaje;
}

@end

@implementation vitereteVCPuntajesAltos

@synthesize cv1,cv2,cv3,indicador;

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone)
    {
        self.cv1.backgroundColor = [UIColor clearColor];
        self.cv2.backgroundColor = [UIColor clearColor];
        self.cv3.backgroundColor = [UIColor clearColor];
        self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"fondo4a.png"]];
    }
    else if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        self.cv1.backgroundColor = [UIColor clearColor];
        self.cv2.backgroundColor = [UIColor clearColor];
        self.cv3.backgroundColor = [UIColor clearColor];
        self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"fondo_ipada.png"]];
    }
    __block int i=0;
    valuesFila=[[NSMutableArray alloc]init];
    valuesNombre=[[NSMutableArray alloc]init];
    valuesPuntaje=[[NSMutableArray alloc]init];
    [self.indicador startAnimating];
    GKLeaderboard *lb = [[GKLeaderboard alloc] init];
    if (lb != nil){
        lb.timeScope = GKLeaderboardTimeScopeToday;
        lb.identifier = @"1";
        lb.range = NSMakeRange(1,10);
            [lb loadScoresWithCompletionHandler: ^(NSArray *scores,NSError *error) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                if (error != nil)
                    
                {
                    // Handle the error.
                }
                if (scores != nil)
                {
                    NSArray *ids=[scores valueForKey:@"playerID"];
                    [GKPlayer loadPlayersForIdentifiers:ids withCompletionHandler:^(NSArray *players, NSError *error) {
                        if (error != nil)
                        {
                            // Handle the error.
                        }
                        if (players != nil)
                        {
                            NSLog(@"total de puntajes: %d",scores.count);
                            while (i<scores.count) {
                                
                                [valuesFila addObject:[NSString stringWithFormat:@"%d",i+1]];
                                [valuesNombre addObject:[[players objectAtIndex:i]alias]];
                                [valuesPuntaje addObject:[NSString stringWithFormat:@"%llu",[(GKScore*)[scores objectAtIndex:i]value]]];
                                i++;
                            }
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [self leaderboardCargado];
                            });
                        }
                    }];
                }
                });
            }];
    }
}

-(NSString*)path{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0]stringByAppendingPathComponent:@"bp.sql"];
}

-(void)abrir{
    if(sqlite3_open([[self path]UTF8String], &db) != SQLITE_OK){
        sqlite3_close(db);
        NSAssert(0, @"Fallo al abrir la base de datos");
    }
    else{
        NSLog(@"Se abrio satisfactoriamente la base de datos");
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(collectionView.tag==1){
        viteretePuntajesAltosCell*celda=[collectionView dequeueReusableCellWithReuseIdentifier:@"celdaFila" forIndexPath:indexPath];
        celda.label.text=[NSString stringWithFormat:@"%@",[valuesFila objectAtIndex:indexPath.item]];
        return celda;
    }
    else if(collectionView.tag==2){
        vitereteCeldaNombre *celda=[collectionView dequeueReusableCellWithReuseIdentifier:@"celdaNombre" forIndexPath:indexPath];
        celda.label.text=[NSString stringWithFormat:@"%@",[valuesNombre objectAtIndex:indexPath.item]];
        return celda;
    }
    else if(collectionView.tag==3){
        vitereteCeldaPuntaje *celda=[collectionView dequeueReusableCellWithReuseIdentifier:@"celdaPuntaje" forIndexPath:indexPath];
        celda.label.text=[NSString stringWithFormat:@"%@",[valuesPuntaje objectAtIndex:indexPath.item]];
        
        return celda;
    }
    else{
        return nil;
    }
  
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(collectionView.tag==1){
        return valuesFila.count;
    }
    else if(collectionView.tag==2){
        return valuesNombre.count;
    }
    else if(collectionView.tag==3){
        return valuesPuntaje.count;
    }
    else{
        return 0;
    }
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(void)leaderboardCargado{
    [self.indicador stopAnimating];
    [self.indicador setHidden:YES];
    [self.cv1 reloadData];
    [self.cv2 reloadData];
    [self.cv3 reloadData];
    
}

@end
