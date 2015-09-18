//
//  vitereteVCPreferencias.m
//  Barce Memo 2013
//
//  Created by Victor Pinto on 28/07/13.
//  Copyright (c) 2013 Victor Pinto. All rights reserved.
//

#import "vitereteVCPreferencias.h"

@interface vitereteVCPreferencias ()

@end

@implementation vitereteVCPreferencias


@synthesize pickerV;
@synthesize listaCanciones;
@synthesize swCancion;


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.listaCanciones count];
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [self.listaCanciones objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:row forKey:@"numeroCancion"];
    [defaults synchronize];
}

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
        self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"fondo4a.png"]];
    }
    else if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"fondo_ipada.png"]];
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.listaCanciones=[NSMutableArray arrayWithObjects:@"Un solo ídolo",@"Si, si señores",@"Amarillo es mi color", nil];
    if([defaults integerForKey:@"estadoSwitch"]==0){
        [self.swCancion setOn:NO];
    }
    else{
        [self.swCancion setOn:YES];
    }
    [self.pickerV reloadAllComponents];
    [self.pickerV selectRow:[defaults integerForKey:@"numeroCancion"] inComponent:0 animated:YES];
    [defaults synchronize];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)switchSeleccionado:(id)sender{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if(self.swCancion.on){
        [defaults setInteger:1 forKey:@"estadoSwitch"];
        [defaults setBool:YES forKey:@"repCancion"];
    }
    else{
        [defaults setInteger:0 forKey:@"estadoSwitch"];
        [defaults setBool:NO forKey:@"repCancion"];
    }
    [defaults synchronize];
}

-(IBAction)acercaDe:(id)sender{
    UIAlertView *acercaDe=[[UIAlertView alloc]initWithTitle:@"Acerca de" message:@"Aplicación no oficial de Barcelona Sporting Club 2013 desarrollada por Víctor Pinto sin fines de lucro.\n Contacto: viterete8@gmail.com" delegate:self cancelButtonTitle:@"Cancelar" otherButtonTitles:nil, nil];
    [acercaDe show];
}





@end
