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

@interface vitereteViewController ()

@end

@implementation vitereteViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)elegirNivel:(id)sender{
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Elige el nivel" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"Fácil",@"Medio",@"Difícil",@"Cancelar", nil];
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



@end
