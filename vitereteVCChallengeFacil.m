//
//  vitereteVCChallengeFacil.m
//  Barce Memo 2013
//
//  Created by Victor Pinto on 01/08/13.
//  Copyright (c) 2013 Victor Pinto. All rights reserved.
//

#import "vitereteVCChallengeFacil.h"
#import "vitereteVCPreferencias.h"
#import "vitereteFacilCell.h"
#import "vitereteCarta.h"
#import "vitereteViewController.h"

@interface vitereteVCChallengeFacil ()
{
    NSMutableArray *imagenes,*imagenesTemp;
    NSNumber *cont,*contInicio,*contwinner,*v1pos,*turnos,*puntaje,*segundos,*minutos,*bonoturnos,*bonotiempo,*puntajef;
    vitereteFacilCell *primeraCelda,*segundaCelda;
    vitereteCarta *primeraCarta,*segundaCarta;
}

@end

@implementation vitereteVCChallengeFacil

@synthesize sonido,url,BTreiniciar,timer,LBpuntaje,LBtiempo,LBturnos,cv;

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
    [self abrir];
    [self crearTabla:@"Tabla_Jugador" conClave:@"_id" conNombre:@"nombre_jugador" conPuntaje:@"puntaje_jugador"];
    [super viewDidLoad];
    [self reproducirSonido];
    [self reiniciar:self];
    
	// Do any additional setup after loading the view.
}
-(void)viewWillDisappear:(BOOL)animated{
    [self.sonido stop];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(void)crearTabla:(NSString *)nombreTabla conClave:(NSString *)clave conNombre:(NSString *)nombre conPuntaje:(NSString *)puntaje1{
    char *err;
    NSString *sql=[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ('%@' " "INTEGER PRIMARY KEY AUTOINCREMENT, '%@' TEXT, '%@' INTEGER);",nombreTabla,clave,nombre,puntaje1];
    if(sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err)!=SQLITE_OK){
        sqlite3_close(db);
        NSAssert(0, @"Error al crear la tabla");
    }
    else{
        NSLog(@"La tabla se creo satisfactoriamente");
    }
    
}

-(void)reproducirSonido{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults boolForKey:@"repCancion"] && ([defaults integerForKey:@"numeroCancion"]==0)){
        self.url=[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"unsoloidolo" ofType:@"mp3"]];
        self.sonido=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
        self.sonido.delegate=self;
        [self.sonido setNumberOfLoops:-1];
        [self.sonido play];
    }
    else if([defaults boolForKey:@"repCancion"] && ([defaults integerForKey:@"numeroCancion"]==1)){
        self.url=[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"sisi" ofType:@"mp3"]];
        self.sonido=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
        self.sonido.delegate=self;
        [self.sonido setNumberOfLoops:-1];
        [self.sonido play];
    }
    else if([defaults boolForKey:@"repCancion"] && ([defaults integerForKey:@"numeroCancion"]==2)){
        self.url=[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"amarilloesmicolor" ofType:@"mp3"]];
        self.sonido=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
        self.sonido.delegate=self;
        [self.sonido setNumberOfLoops:-1];
        [self.sonido play];
    }
    else{
        
    }
    
}

-(IBAction)reiniciar:(id)sender{
    self.cv.userInteractionEnabled=NO;
    self.LBtiempo.text=@"0";
    segundos=0;
    minutos=0;
    self.LBpuntaje.text=@"0";
    puntaje=0;
    self.LBturnos.text=@"0";
    turnos=0;
    cont=0;
    contInicio=0;
    contwinner=0;
    bonotiempo=0;
    bonoturnos=0;
    puntajef=0;
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone)
    {
        imagenesTemp=[NSMutableArray arrayWithObjects:@"bsc14.jpg",@"bsc14.jpg",@"bsc14.jpg",@"bsc14.jpg",@"bsc14.jpg",@"bsc14.jpg",@"bsc14.jpg",@"bsc14.jpg",@"bsc14.jpg",@"bsc14.jpg",@"bsc14.jpg",@"bsc14.jpg", nil];
        imagenes=[NSMutableArray arrayWithObjects:@"card1.jpg", @"card2.jpg", @"card3.jpg", @"card4.jpg", @"card5.jpg", @"card6.jpg",@"card1.jpg", @"card2.jpg", @"card3.jpg", @"card4.jpg", @"card5.jpg", @"card6.jpg", nil];
        
    }
    else if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        imagenesTemp=[NSMutableArray arrayWithObjects:@"bsc14b.jpg",@"bsc14b.jpg",@"bsc14b.jpg",@"bsc14b.jpg",@"bsc14b.jpg",@"bsc14b.jpg",@"bsc14b.jpg",@"bsc14b.jpg",@"bsc14b.jpg",@"bsc14b.jpg",@"bsc14b.jpg",@"bsc14b.jpg", nil];
        imagenes=[NSMutableArray arrayWithObjects:@"card1b.jpg", @"card2b.jpg", @"card3b.jpg", @"card4b.jpg", @"card5b.jpg", @"card6b.jpg",@"card1b.jpg", @"card2b.jpg", @"card3b.jpg", @"card4b.jpg", @"card5b.jpg", @"card6b.jpg", nil];
        
    }
    [self shuffle];
    [self.cv reloadData];
    [self.timer invalidate];
    self.timer=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(aumentarTiempo) userInfo:nil repeats:YES];
    
}

-(void)aumentarTiempo{
    segundos=[NSNumber numberWithInt:[segundos intValue]+1];
    if([segundos intValue]<10){
        self.LBtiempo.text=[NSString stringWithFormat:@"%d:0%d",[minutos intValue],[segundos intValue]];
    }
    else{
        if([segundos intValue]>59){
            segundos=0;
            minutos=[NSNumber numberWithInt:[minutos intValue]+1];
            self.LBtiempo.text=[NSString stringWithFormat:@"%d:0%d",[minutos intValue],[segundos intValue]];
        }
        else{
            self.LBtiempo.text=[NSString stringWithFormat:@"%d:%d",[minutos intValue],[segundos intValue]];
        }
        
    }
}



//datasource
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    vitereteFacilCell *celda=[collectionView dequeueReusableCellWithReuseIdentifier:@"CeldaID" forIndexPath:indexPath];
    
    if(contInicio.intValue==0){
        [[celda collectionIV]setImage:[UIImage imageNamed:[imagenes objectAtIndex:indexPath.item]]];   
        [self performSelector:@selector(recargar) withObject:nil afterDelay:1.0];
        return celda;
    }
    else{
        [[celda collectionIV]setImage:[UIImage imageNamed:[imagenesTemp objectAtIndex:indexPath.item]]];
        return celda;
    }  
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return imagenes.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//delegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if([cont intValue]==0){
        v1pos=[NSNumber numberWithInteger:indexPath.item];
        primeraCarta=[[vitereteCarta alloc]initWithId:[imagenes objectAtIndex:indexPath.item]];
        primeraCelda=[collectionView cellForItemAtIndexPath:indexPath];
        [[primeraCelda collectionIV]setImage:[UIImage imageNamed:[imagenes objectAtIndex:indexPath.item]]];
        cont=[NSNumber numberWithInt:[cont intValue] + 1];
    }
    else{
        if([v1pos intValue]==indexPath.item){
            self.alerta = [[UIAlertView alloc] initWithTitle:@"Advertencia" message:@"La misma carta fué seleccionada" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
            [self.alerta  show];
            [self performSelector:@selector(cerrarAlerta) withObject:nil afterDelay:1.0];
            turnos = [NSNumber numberWithInt:[turnos intValue] + 1];
            self.LBturnos.text=[NSString stringWithFormat:@"%@",turnos];
        }
        else{
            segundaCelda=[collectionView cellForItemAtIndexPath:indexPath];
            segundaCarta=[[vitereteCarta alloc]initWithId:[imagenes objectAtIndex:indexPath.item]];
            [[segundaCelda collectionIV]setImage:[UIImage imageNamed:[imagenes objectAtIndex:indexPath.item]]];
            if([self compar:[primeraCarta identificador] ar:[segundaCarta identificador]]){
                turnos = [NSNumber numberWithInt:[turnos intValue] + 1];
                self.LBturnos.text=[NSString stringWithFormat:@"%@",turnos];
                collectionView.userInteractionEnabled=NO;
                [self performSelector:@selector(esconder) withObject:nil afterDelay:1.0];
                contwinner = [NSNumber numberWithInt:[contwinner intValue] + 1];
                puntaje = [NSNumber numberWithInt:[puntaje intValue] + 500];
                self.LBpuntaje.text=[NSString stringWithFormat:@"%@",puntaje];
                [self checkWin];
            }
            else{
                turnos = [NSNumber numberWithInt:[turnos intValue] + 1];
                self.LBturnos.text=[NSString stringWithFormat:@"%@",turnos];
                collectionView.userInteractionEnabled=NO;
                [self performSelector:@selector(reponer:) withObject:indexPath afterDelay:1.0]; 
            }
            cont=0;
        }
    }
    
}

-(void)shuffle{
    for (int x = 0; x < [imagenes count]; x++) {
        int randInt = (arc4random() % ([imagenes count] - x)) + x;
        [imagenes exchangeObjectAtIndex:x withObjectAtIndex:randInt];
    }
}


-(BOOL)compar:(NSString*)carta1 ar:(NSString*)carta2{
    BOOL check=NO;
    if([carta1 isEqualToString:carta2]){
        check=YES;
    }
    else{
        check=NO;
    }
    return check;
}

-(void)checkWin{
    if([contwinner intValue]==6){
        NSString *TVTbonoturnos,*TVTtiempo;
        switch(turnos.intValue){
            case 6:bonoturnos=[NSNumber numberWithInt:turnos.intValue*1000];
                TVTbonoturnos=[NSString stringWithFormat:@"%@ x 1000",turnos.stringValue];
                break;
            case 7:bonoturnos=[NSNumber numberWithInt:turnos.intValue*900];
                TVTbonoturnos=[NSString stringWithFormat:@"%@ x 900",turnos.stringValue];
                break;
            case 8:bonoturnos=[NSNumber numberWithInt:turnos.intValue*800];
                TVTbonoturnos=[NSString stringWithFormat:@"%@ x 800",turnos.stringValue];
                break;
            case 9:bonoturnos=[NSNumber numberWithInt:turnos.intValue*700];
                TVTbonoturnos=[NSString stringWithFormat:@"%@ x 700",turnos.stringValue];
                break;
            case 10:bonoturnos=[NSNumber numberWithInt:turnos.intValue*600];
                TVTbonoturnos=[NSString stringWithFormat:@"%@ x 600",turnos.stringValue];
                break;
            case 11:bonoturnos=[NSNumber numberWithInt:turnos.intValue*500];
                TVTbonoturnos=[NSString stringWithFormat:@"%@ x 500",turnos.stringValue];
                break;
            case 12:bonoturnos=[NSNumber numberWithInt:turnos.intValue*400];
                TVTbonoturnos=[NSString stringWithFormat:@"%@ x 400",turnos.stringValue];
                break;
            case 13:bonoturnos=[NSNumber numberWithInt:turnos.intValue*300];
                TVTbonoturnos=[NSString stringWithFormat:@"%@ x 300",turnos.stringValue];
                break;
            case 14:bonoturnos=[NSNumber numberWithInt:turnos.intValue*200];
                TVTbonoturnos=[NSString stringWithFormat:@"%@ x 200",turnos.stringValue];
                break;
            default:bonoturnos=0;
                TVTbonoturnos=[NSString stringWithFormat:@"%@ + 0",turnos.stringValue];
                break;
        }
        
        if(minutos==0){
            if(segundos.intValue<10){
                TVTtiempo=[NSString stringWithFormat:@"0%@ s",segundos.stringValue];
                bonotiempo=[NSNumber numberWithInt:5000];
            }
            else if(segundos.intValue<12){
                TVTtiempo=[NSString stringWithFormat:@"%@ s",segundos.stringValue];
                bonotiempo=[NSNumber numberWithInt:4000];
            }
            else if(segundos.intValue<15){
                TVTtiempo=[NSString stringWithFormat:@"%@ s",segundos.stringValue];
                bonotiempo=[NSNumber numberWithInt:3000];;
            }
            else if(segundos.intValue<20){
                TVTtiempo=[NSString stringWithFormat:@"%@ s",segundos.stringValue];
                bonotiempo=[NSNumber numberWithInt:2000];
            }
            else if(segundos.intValue<25){
                TVTtiempo=[NSString stringWithFormat:@"%@ s",segundos.stringValue];
                bonotiempo=[NSNumber numberWithInt:1000];
            }
            else{
                TVTtiempo=[NSString stringWithFormat:@"%@ s",segundos.stringValue];
                bonotiempo=[NSNumber numberWithInt:100];
            }
        }
        else{
            if(segundos.intValue<10){
                TVTtiempo=[NSString stringWithFormat:@"%@:0%@ s",minutos.stringValue,segundos.stringValue];
                bonotiempo=[NSNumber numberWithInt:500];
            }
            else{
                TVTtiempo=[NSString stringWithFormat:@"%@:%@ s",minutos.stringValue,segundos.stringValue];
                bonotiempo=[NSNumber numberWithInt:100];
            }
        }     
        puntajef=[NSNumber numberWithInt:bonotiempo.intValue+bonoturnos.intValue+puntaje.intValue];
        [self insertarPuntaje:puntajef];
        self.alerta = [[UIAlertView alloc] initWithTitle:@"Ganaste!!!" message:[NSString stringWithFormat:@"Turnos: %@ \n Tiempo: %@ \n Puntaje: %@ \n Bono por turnos: %@ \n Bono por tiempo: %@ \n Puntaje total: %@ \n",turnos.stringValue,TVTtiempo,puntaje.stringValue,TVTbonoturnos,bonotiempo.stringValue,puntajef.stringValue] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Comparte",@"Replay",@"Salir", nil];
        [self.alerta  show];
    }
}

-(void)cerrarAlerta{
    [self.alerta dismissWithClickedButtonIndex:0 animated:YES];
}
-(void)esconder{
    [primeraCelda setHidden:YES];
    [segundaCelda setHidden:YES];
    self.cv.userInteractionEnabled=YES;
}

-(void)reponer:(NSIndexPath*)index{
    [[primeraCelda collectionIV]setImage:[UIImage imageNamed:[imagenesTemp objectAtIndex:[v1pos intValue]]]];
    [[segundaCelda collectionIV]setImage:[UIImage imageNamed:[imagenesTemp objectAtIndex:index.item]]];
    self.cv.userInteractionEnabled=YES;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *mensaje=[NSString stringWithFormat:@"Mi puntuación en Barce Memo 2013 fue: %@, Quieres superarme? Bajate la aplicación aquí....",puntajef.stringValue];
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:[NSArray arrayWithObject:mensaje] applicationActivities:nil];
    switch (buttonIndex) {
        case 0:
            [self presentViewController:activityController animated:YES completion:nil];
            break;
        case 1:
            self.viewDidLoad;
            break;
        case 2:
            [self.navigationController popToRootViewControllerAnimated:YES];
            break;
}    
}

-(void)recargar{
    contInicio=[NSNumber numberWithInt:[cont intValue] + 1];
    [self.cv reloadData];
    self.cv.userInteractionEnabled=YES;
}

-(void)insertarPuntaje:(NSNumber *)puntajeFinal{
    NSString *sql=[NSString stringWithFormat:@"INSERT INTO Tabla_Jugador ('nombre_jugador', 'puntaje_jugador') VALUES ('%@', '%d')",[[UIDevice currentDevice]name],puntajeFinal.intValue];
    char *err;
    if(sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK){
        sqlite3_close(db);
        NSAssert(0, @"Error al crear un registro %@",[NSString stringWithUTF8String:sqlite3_errmsg(db)]);
    }
    NSLog(@"El registro se creo satisfactoriamente");
}

@end
