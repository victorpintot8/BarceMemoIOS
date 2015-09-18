//
//  vitereteResultadoViewController.m
//  Barce Memo 2013
//
//  Created by Victor Pinto on 15/10/13.
//  Copyright (c) 2013 Victor Pinto. All rights reserved.
//

#import "vitereteResultadoViewController.h"
#import "vitereteVCChallengeFacil.h"
#import "vitereteVCChallengeMedio.h"
#import "vitereteVCChallengeDificil.h"
#import "GameCenterManager.h"
#import "vitereteBaseManager.h"

@interface vitereteResultadoViewController ()

@end

@implementation vitereteResultadoViewController

@synthesize puntaje,bonoTiempo,bonoTurnos,tiempo,turnos,puntajeTotal;

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
    self.turnos.text=[NSString stringWithFormat:@"Turnos: %@",self.Sturnos];
    self.tiempo.text=[NSString stringWithFormat:@"Tiempo: %@",self.Stiempo];
    self.puntaje.text=[NSString stringWithFormat:@"Puntaje: %@",self.Spuntaje];
    self.bonoTiempo.text=[NSString stringWithFormat:@"Bono por tiempo: +%@",self.SbonoTiempo];
    self.bonoTurnos.text=[NSString stringWithFormat:@"Bono por turnos: +%@",self.SbonoTurnos];
    self.puntajeTotal.text=[NSString stringWithFormat:@"%@ pts",self.SpuntajeTotal];
    [[vitereteBaseManager solicitarHelper]path];
    [[vitereteBaseManager solicitarHelper]abrir];
    [[vitereteBaseManager solicitarHelper]insertarVecesJugadas];
    [[vitereteBaseManager solicitarHelper]insertarPuntaje:[puntajeTotal.text intValue]];
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)compartir:(id)sender{
    NSString *mensaje=[NSString stringWithFormat:@"Mi puntuación en Barce Memo 2013 fue: %@, Quieres superarme? Bajate la aplicación aquí https://itunes.apple.com/us/app/barce-memo/id721350353?l=es&ls=1&mt=8",puntaje];
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:[NSArray arrayWithObject:mensaje] applicationActivities:nil];
    [self presentViewController:activityController animated:YES completion:nil];
}

-(IBAction)atras:(id)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(IBAction)juegaDeNuevo:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIViewController *)backViewController {
    NSArray *stack = self.navigationController.viewControllers;
    
    for (int i=stack.count-1; i > 0; --i)
        if (stack[i] == self)
            return stack[i-1];
    
    return nil;
}

@end
