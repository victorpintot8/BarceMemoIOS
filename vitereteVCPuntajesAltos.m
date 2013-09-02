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

@interface vitereteVCPuntajesAltos ()
{
    NSNumber *nFilas;
}

@end

@implementation vitereteVCPuntajesAltos

@synthesize valuesFila,valuesNombre,valuesPuntaje;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    valuesFila=[[NSMutableArray alloc]init];
    valuesNombre=[[NSMutableArray alloc]init];
    valuesPuntaje=[[NSMutableArray alloc]init];
    [self abrir];
    NSString *sql=[NSString stringWithFormat:@"SELECT * FROM Tabla_Jugador ORDER BY puntaje_jugador DESC LIMIT 10"];
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil)==SQLITE_OK){
        while (sqlite3_step(statement)==SQLITE_ROW) {
            char *field1=(char*)sqlite3_column_text(statement,0);
            nFilas=[NSNumber numberWithInt:[nFilas intValue]+1];
            [valuesFila addObject:[NSString stringWithFormat:@"%@",nFilas.stringValue]];
            
            char *field2=(char*)sqlite3_column_text(statement,1);
            [valuesNombre addObject:[NSString stringWithUTF8String:field2]];
            
            char *field3=(char*)sqlite3_column_text(statement,2);
            [valuesPuntaje addObject:[NSString stringWithUTF8String:field3]];
        }
    }
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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
    // Dispose of any resources that can be recreated.
}

-(IBAction)mostrarResultadosTodos:(id)sender{
    
}

-(IBAction)mostrarResultadosYo:(id)sender{
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(collectionView.tag==1){
        viteretePuntajesAltosCell*celda=[collectionView dequeueReusableCellWithReuseIdentifier:@"celdaFila" forIndexPath:indexPath];
        celda.label.text=[NSString stringWithFormat:@"%@",[self.valuesFila objectAtIndex:indexPath.item]];
        return celda;
    }
    else if(collectionView.tag==2){
        vitereteCeldaNombre *celda=[collectionView dequeueReusableCellWithReuseIdentifier:@"celdaNombre" forIndexPath:indexPath];
        celda.label.text=[NSString stringWithFormat:@"%@",[self.valuesNombre objectAtIndex:indexPath.item]];
        return celda;
    }
    else if(collectionView.tag==3){
        vitereteCeldaPuntaje *celda=[collectionView dequeueReusableCellWithReuseIdentifier:@"celdaPuntaje" forIndexPath:indexPath];
        celda.label.text=[NSString stringWithFormat:@"%@",[self.valuesPuntaje objectAtIndex:indexPath.item]];
        return celda;
    }
    else{
        return nil;
    }
  
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(collectionView.tag==1){
        return self.valuesFila.count;
    }
    else if(collectionView.tag==2){
        return self.valuesNombre.count;
    }
    else if(collectionView.tag==3){
        return self.valuesPuntaje.count;
    }
    else{
        return 0;
    }
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

@end
