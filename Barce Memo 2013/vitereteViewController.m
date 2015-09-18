//
//  vitereteViewController.m
//  Barce Memo 2013
//
//  Created by Victor Pinto on 25/07/13.
//  Copyright (c) 2013 Victor Pinto. All rights reserved.
//

#import "vitereteViewController.h"
#import "vitereteVCChallengeFacil.h"
#import "vitereteVCChallengeMedio.h"
#import "vitereteVCChallengeDificil.h"
#import "GameCenterManager.h"

@interface vitereteViewController ()

@end

@implementation vitereteViewController

@synthesize titulo;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone)
    {
        self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"fondo4a.png"]];
       [self.titulo setFont:[UIFont fontWithName:@"Tequilla Sunrise" size:30.0]];
    }
    else if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
         //CGSize iOSDeviceScreenSize = [[UIScreen mainScreen] bounds].size;
        [self.titulo setFont:[UIFont fontWithName:@"Tequilla Sunrise" size:55.0]];
             self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"fondo_ipada.png"]];
    }    
    [[GameCenterManager solicitarHelper]autenticarJugador];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
}

-(IBAction)elegirNivel:(id)sender{
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Nivel de dificultad" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"Fácil",@"Medio",@"Difícil",@"Cancelar", nil];
   [message show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    vitereteVCChallengeFacil *modoFacil = [self.storyboard instantiateViewControllerWithIdentifier:@"modoFacil"];
    vitereteVCChallengeMedio *modoMedio = [self.storyboard instantiateViewControllerWithIdentifier:@"modoMedio"];
    vitereteVCChallengeModeDificil *modoDificil = [self.storyboard instantiateViewControllerWithIdentifier:@"modoDificil"];
    switch (buttonIndex) {
        case 0:
            [self.navigationController pushViewController:modoFacil animated:YES];
            break;
        case 1:
            [self.navigationController pushViewController:modoMedio animated:YES];
            break;
        case 2:
            [self.navigationController pushViewController:modoDificil animated:YES];
            break;
            

    }
}

-(void)mostrarLogrosController:(id)sender{
    GKGameCenterViewController *gameCenterController = [[GKGameCenterViewController alloc] init];
    if (gameCenterController != nil)
    {
        gameCenterController.gameCenterDelegate =self;
        gameCenterController.viewState = GKGameCenterViewControllerStateAchievements;
        [self presentViewController: gameCenterController animated: YES
                         completion:nil];
    }
}

- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController
                                           *)gameCenterViewController{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
