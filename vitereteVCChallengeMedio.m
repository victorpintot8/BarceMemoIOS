//
//  vitereteVCChallengeMedio.m
//  Barce Memo 2013
//
//  Created by Victor Pinto on 05/08/13.
//  Copyright (c) 2013 Victor Pinto. All rights reserved.
//

#import "vitereteVCChallengeMedio.h"
#import "vitereteVCPreferencias.h"
#import "vitereteFacilCell.h"
#import "vitereteCarta.h"
#import "vitereteViewController.h"
#import "GameCenterManager.h"
#import "vitereteResultadoViewController.h"

@interface vitereteVCChallengeMedio ()
{
    NSMutableArray *imagenes,*imagenesTemp;
    NSNumber *cont,*contInicio,*contwinner,*v1pos,*turnos,*puntaje,*segundos,*minutos,*bonoturnos,*bonotiempo,*puntajef;
    vitereteFacilCell *primeraCelda,*segundaCelda;
    vitereteCarta *primeraCarta,*segundaCarta;
}

@end

@implementation vitereteVCChallengeMedio

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
    [super viewDidLoad];
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone)
    {
        self.cv.backgroundColor = [UIColor clearColor];
        self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"fondo4a.png"]];
    }
    else if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        self.cv.backgroundColor = [UIColor clearColor];
        self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"fondo_ipada.png"]];
    }

    [self reproducirSonido];
    [self reiniciar:self];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    if(self.ad==NO){
        [self reproducirSonido];
        [self reiniciar:self];
    }
    else{
        self.ad=NO;
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    if(self.ad){
        [self.sonido pause];
    }
    else{
        [self.sonido stop];
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
        imagenesTemp=[NSMutableArray arrayWithObjects:@"bsc14.png",@"bsc14.png",@"bsc14.png",@"bsc14.png",@"bsc14.png",@"bsc14.png",@"bsc14.png",@"bsc14.png",@"bsc14.png",@"bsc14.png",@"bsc14.png",@"bsc14.png",@"bsc14.png",@"bsc14.png",@"bsc14.png",@"bsc14.png", nil];
        imagenes=[NSMutableArray arrayWithObjects:@"card1.jpg", @"card2.jpg", @"card3.jpg", @"card4.jpg", @"card5.jpg", @"card6.png", @"card7.png", @"card8.jpg",@"card1.jpg", @"card2.jpg", @"card3.jpg", @"card4.jpg", @"card5.jpg", @"card6.png", @"card7.png", @"card8.jpg", nil];
        
    }
    else if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        imagenesTemp=[NSMutableArray arrayWithObjects:@"bsc14b.png",@"bsc14b.png",@"bsc14b.png",@"bsc14b.png",@"bsc14b.png",@"bsc14b.png",@"bsc14b.png",@"bsc14b.png",@"bsc14b.png",@"bsc14b.png",@"bsc14b.png",@"bsc14b.png",@"bsc14b.png",@"bsc14b.png",@"bsc14b.png",@"bsc14b.png", nil];
        imagenes=[NSMutableArray arrayWithObjects:@"card1b.jpg", @"card2b.jpg", @"card3b.jpg", @"card4b.jpg", @"card5b.jpg", @"card6b.png", @"card7b.png", @"card8b.jpg",@"card1b.jpg", @"card2b.jpg", @"card3b.jpg", @"card4b.jpg", @"card5b.jpg", @"card6b.png", @"card7b.png", @"card8b.jpg", nil];        
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
    [celda setAlpha:1.0f];
    if(contInicio.intValue==0){
        [[celda collectionIV]setImage:[UIImage imageNamed:[imagenes objectAtIndex:indexPath.item]]];
        [self performSelector:@selector(recargar) withObject:nil afterDelay:0.850];
        return celda;
    }
    else{
        [[celda collectionIV]setImage:[UIImage imageNamed:[imagenesTemp objectAtIndex:indexPath.item]]];
        return celda;
    }  
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [imagenes count];
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
        [UIView transitionWithView:[primeraCelda collectionIV] duration:0.4
                           options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
                               [[primeraCelda collectionIV]setImage:[UIImage imageNamed:[imagenes objectAtIndex:indexPath.item]]];
                           } completion:nil];

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
            [UIView transitionWithView:[segundaCelda collectionIV] duration:0.4
                               options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
                                   [[segundaCelda collectionIV]setImage:[UIImage imageNamed:[imagenes objectAtIndex:indexPath.item]]];
                               } completion:nil];
            if([self compar:[primeraCarta identificador] ar:[segundaCarta identificador]]){
                turnos = [NSNumber numberWithInt:[turnos intValue] + 1];
                self.LBturnos.text=[NSString stringWithFormat:@"%@",turnos];
                collectionView.userInteractionEnabled=NO;
                [self performSelector:@selector(esconder) withObject:nil afterDelay:0.500];
                contwinner = [NSNumber numberWithInt:[contwinner intValue] + 1];
                puntaje = [NSNumber numberWithInt:[puntaje intValue] + 500];
                self.LBpuntaje.text=[NSString stringWithFormat:@"%@",puntaje];
                [self checkWin];
            }
            else{
                turnos = [NSNumber numberWithInt:[turnos intValue] + 1];
                self.LBturnos.text=[NSString stringWithFormat:@"%@",turnos];
                collectionView.userInteractionEnabled=NO;
                [self performSelector:@selector(reponer:) withObject:indexPath afterDelay:0.500];
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
    if([contwinner intValue]==8){
        NSString *TVTbonoturnos,*TVTtiempo;
        switch(turnos.intValue){
            case 8:bonoturnos=[NSNumber numberWithInt:30000];
                TVTbonoturnos=[NSString stringWithFormat:@"30000"];
                break;
            case 9:bonoturnos=[NSNumber numberWithInt:29000];
                TVTbonoturnos=[NSString stringWithFormat:@"29000"];
                break;
            case 10:bonoturnos=[NSNumber numberWithInt:28000];
                TVTbonoturnos=[NSString stringWithFormat:@"28000"];
                break;
            case 11:bonoturnos=[NSNumber numberWithInt:27000];
                TVTbonoturnos=[NSString stringWithFormat:@"27000"];
                break;
            case 12:bonoturnos=[NSNumber numberWithInt:26000];
                TVTbonoturnos=[NSString stringWithFormat:@"26000"];
                break;
            case 13:bonoturnos=[NSNumber numberWithInt:25000];
                TVTbonoturnos=[NSString stringWithFormat:@"25000"];
                break;
            case 14:bonoturnos=[NSNumber numberWithInt:24000];
                TVTbonoturnos=[NSString stringWithFormat:@"24000"];
                break;
            case 15:bonoturnos=[NSNumber numberWithInt:23000];
                TVTbonoturnos=[NSString stringWithFormat:@"23000"];
                break;
            case 16:bonoturnos=[NSNumber numberWithInt:22000];
                TVTbonoturnos=[NSString stringWithFormat:@"22000"];
                break;
            case 17:bonoturnos=[NSNumber numberWithInt:21000];
                TVTbonoturnos=[NSString stringWithFormat:@"21000"];
                break;
            case 18:bonoturnos=[NSNumber numberWithInt:20000];
                TVTbonoturnos=[NSString stringWithFormat:@"20000"];
                break;
            case 19:bonoturnos=[NSNumber numberWithInt:19000];
                TVTbonoturnos=[NSString stringWithFormat:@"19000"];
                break;
            case 20:bonoturnos=[NSNumber numberWithInt:18000];
                TVTbonoturnos=[NSString stringWithFormat:@"18000"];
                break;
            default:bonoturnos=0;
                TVTbonoturnos=[NSString stringWithFormat:@"0"];
                break;
        }
        
        if(minutos==0){
            if(segundos.intValue<12){
                TVTtiempo=[NSString stringWithFormat:@"%@ s",segundos.stringValue];
                bonotiempo=[NSNumber numberWithInt:6000];
            }
            else if(segundos.intValue<14){
                TVTtiempo=[NSString stringWithFormat:@"%@ s",segundos.stringValue];
                bonotiempo=[NSNumber numberWithInt:5000];;
            }
            else if(segundos.intValue<16){
                TVTtiempo=[NSString stringWithFormat:@"%@ s",segundos.stringValue];
                bonotiempo=[NSNumber numberWithInt:3000];
            }
            else if(segundos.intValue<18){
                TVTtiempo=[NSString stringWithFormat:@"%@ s",segundos.stringValue];
                bonotiempo=[NSNumber numberWithInt:2000];
            }
            else if(segundos.intValue<20){
                TVTtiempo=[NSString stringWithFormat:@"%@ s",segundos.stringValue];
                bonotiempo=[NSNumber numberWithInt:1500];
            }
            else if(segundos.intValue<22){
                TVTtiempo=[NSString stringWithFormat:@"%@ s",segundos.stringValue];
                bonotiempo=[NSNumber numberWithInt:1000];
            }
            else if(segundos.intValue<25){
                TVTtiempo=[NSString stringWithFormat:@"%@ s",segundos.stringValue];
                bonotiempo=[NSNumber numberWithInt:800];
            }
            else if(segundos.intValue<28){
                TVTtiempo=[NSString stringWithFormat:@"%@ s",segundos.stringValue];
                bonotiempo=[NSNumber numberWithInt:700];
            }
            else if(segundos.intValue<30){
                TVTtiempo=[NSString stringWithFormat:@"%@ s",segundos.stringValue];
                bonotiempo=[NSNumber numberWithInt:600];
            }
            else if(segundos.intValue<35){
                TVTtiempo=[NSString stringWithFormat:@"%@ s",segundos.stringValue];
                bonotiempo=[NSNumber numberWithInt:500];
            }
            else if(segundos.intValue<40){
                TVTtiempo=[NSString stringWithFormat:@"%@ s",segundos.stringValue];
                bonotiempo=[NSNumber numberWithInt:400];
            }
            else{
                TVTtiempo=[NSString stringWithFormat:@"%@ s",segundos.stringValue];
                bonotiempo=[NSNumber numberWithInt:300];
            }
        }
        else{
            if(segundos.intValue<10){
                TVTtiempo=[NSString stringWithFormat:@"%@:0%@ s",minutos.stringValue,segundos.stringValue];
                bonotiempo=[NSNumber numberWithInt:250];
            }
            else{
                TVTtiempo=[NSString stringWithFormat:@"%@:%@ s",minutos.stringValue,segundos.stringValue];
                bonotiempo=[NSNumber numberWithInt:100];
            }
        }
        puntajef=[NSNumber numberWithInt:bonotiempo.intValue+bonoturnos.intValue+puntaje.intValue];
        vitereteResultadoViewController *resultado=[self.storyboard instantiateViewControllerWithIdentifier:@"resultado"];
        resultado.Spuntaje=puntaje.stringValue;
        resultado.Stiempo=TVTtiempo;
        resultado.Sturnos=turnos.stringValue;
        resultado.SbonoTurnos=TVTbonoturnos;
        resultado.SbonoTiempo=bonotiempo.stringValue;
        resultado.SpuntajeTotal=puntajef.stringValue;
        [self.navigationController pushViewController:resultado animated:YES];
        [timer invalidate];
    }
}

-(void)cerrarAlerta{
    [self.alerta dismissWithClickedButtonIndex:0 animated:YES];
}
-(void)esconder{
    [primeraCelda setAlpha:0];
    [segundaCelda setAlpha:0];
    self.cv.userInteractionEnabled=YES;
}

-(void)reponer:(NSIndexPath*)index{
    [UIView transitionWithView:[primeraCelda collectionIV] duration:0.4
                       options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
                           [[primeraCelda collectionIV]setImage:[UIImage imageNamed:[imagenesTemp objectAtIndex:[v1pos intValue]]]];
                       } completion:nil];
    [UIView transitionWithView:[segundaCelda collectionIV] duration:0.4
                       options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
                           [[segundaCelda collectionIV]setImage:[UIImage imageNamed:[imagenesTemp objectAtIndex:[v1pos intValue]]]];
                       } completion:nil];
    self.cv.userInteractionEnabled=YES;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *mensaje=[NSString stringWithFormat:@"Mi puntuación en Barce Memo 2013 fue: %@, Quieres superarme? Bajate la aplicación aquí https://itunes.apple.com/us/app/barce-memo/id721350353?l=es&ls=1&mt=8",puntajef.stringValue];
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:[NSArray arrayWithObject:mensaje] applicationActivities:nil];
    switch (buttonIndex) {
        case 0:
            [self presentViewController:activityController animated:YES completion:nil];
            break;
        case 1:
            [self viewDidLoad];
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

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1];
    [banner setAlpha:0];
    [UIView commitAnimations];
}

-(BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave{
    [self.timer invalidate];
    [self.sonido pause];
    self.ad=YES;
    return YES;
}

-(void)bannerViewDidLoadAd:(ADBannerView *)banner{
    [banner setAlpha:0];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1];
    [banner setAlpha:1.0];
    [UIView commitAnimations];
}

-(void)bannerViewActionDidFinish:(ADBannerView *)banner{
    self.timer=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(aumentarTiempo) userInfo:nil repeats:YES];
    [self.sonido play];
}


@end
