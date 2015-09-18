//
//  GameCenterManager.m
//  Barce Memo 2013
//
//  Created by Victor Pinto on 06/10/13.
//  Copyright (c) 2013 Victor Pinto. All rights reserved.
//

#import "GameCenterManager.h"

@implementation GameCenterManager

@synthesize gameCenterDisponible,usuarioAutenticado,vcActual,delegate,ultimoError,puntajeEnviado;

static GameCenterManager *helper=nil;

-(id)init{
    if((self=[super init])){
        NSNotificationCenter *nc=[NSNotificationCenter defaultCenter];
        [nc addObserver:self selector:@selector(autenticacionCambio) name:GKPlayerAuthenticationDidChangeNotificationName object:nil];
    }
    return self;
}

+(GameCenterManager *)solicitarHelper{
    if(!helper){
        helper=[[GameCenterManager alloc]init];
    }
    return helper;
}

-(void)autenticacionCambio{
    if([GKLocalPlayer localPlayer].isAuthenticated && !usuarioAutenticado){
        NSLog(@"Jugador Autenticado");
        usuarioAutenticado=TRUE;
    }
    else if(![GKLocalPlayer localPlayer].isAuthenticated && usuarioAutenticado){
        NSLog(@"Jugador NO Autenticado");
        usuarioAutenticado=FALSE;
    }
}

-(void)autenticarJugador{
        GKLocalPlayer *jugadorLocal=[GKLocalPlayer localPlayer];
        jugadorLocal.authenticateHandler = ^(UIViewController *viewController, NSError
                                             *error){
            [self setUltimoError:error];
            if (viewController != nil)
            {
                [self presentViewController:viewController];
            }
            else if (jugadorLocal.isAuthenticated)
            {
                [self jugadorAutenticado];
            }
        };

}

-(void)jugadorAutenticado{
    GKLocalPlayer *jugadorLocal=[GKLocalPlayer localPlayer];
    if(jugadorLocal.isAuthenticated){
        self.usuarioAutenticado=YES;
    }
    else{
        self.usuarioAutenticado=NO;
    }
}

-(UIViewController*) getRootViewController {
    return [UIApplication
            sharedApplication].keyWindow.rootViewController;
}

-(void)presentViewController:(UIViewController*)vc {
    UIViewController* rootVC = [self getRootViewController];
    [rootVC presentViewController:vc animated:YES
                       completion:nil];
}

-(void)enviarPuntaje:(int64_t)puntaje conIdentificador:(NSString *)identificador{
    GKScore *GMpuntaje=[[GKScore alloc]initWithLeaderboardIdentifier:identificador];
    GMpuntaje.value=puntaje;
    GMpuntaje.context=0;
    NSArray *scores = @[GMpuntaje];
    [GKScore reportScores:scores withCompletionHandler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"Error reportando puntaje: %@", error);
        }
        else{}
    }];
}

-(void)enviarPuntaje:(int64_t)puntaje conIdentificador:(NSString *)identificador conLogro:(NSString *)logro{
    GKScore *GMpuntaje=[[GKScore alloc]initWithLeaderboardIdentifier:identificador];
    GMpuntaje.value=puntaje;
    GMpuntaje.context=0;
    NSArray *scores = @[GMpuntaje];
    GKAchievement *logro1=[[GKAchievement alloc]initWithIdentifier:logro];
    logro1.percentComplete=100;
    logro1.showsCompletionBanner=YES;
    [GKScore reportScores:scores withCompletionHandler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"Error reportando puntaje: %@", error);
        }
        else{}
    }];
    if(logro1){
        NSArray *achievements = [NSArray arrayWithObjects:logro1, nil];
        [GKAchievement reportAchievements:achievements withCompletionHandler:^(NSError *error) {
            if (error != nil) {
                NSLog(@"Error reportando logro: %@", error);
            }
            else{
                if(logro1.isCompleted){
                    if([logro isEqualToString:@"Puntos15000"]){
                        [GKNotificationBanner showBannerWithTitle:@"Logro obtenido" message:@"Hiciste 15000 puntos!" completionHandler:^{}];
                        [logro1 showsCompletionBanner];
                    }
                    else if([logro isEqualToString:@"Puntos25000"]){
                        [GKNotificationBanner showBannerWithTitle:@"Logro obtenido" message:@"Hiciste 25000 puntos!" completionHandler:^{}];
                        [logro1 showsCompletionBanner];
                    }
                    else if([logro isEqualToString:@"Puntos30000"]){
                        [GKNotificationBanner showBannerWithTitle:@"Logro obtenido" message:@"Hiciste 30000 puntos!" completionHandler:^{}];
                        [logro1 showsCompletionBanner];
                    }
                    else if([logro isEqualToString:@"Puntos35000"]){
                        [GKNotificationBanner showBannerWithTitle:@"Logro obtenido" message:@"Hiciste 35000 puntos!" completionHandler:^{}];
                        [logro1 showsCompletionBanner];
                    }
                    else if([logro isEqualToString:@"Puntos40000"]){
                        [GKNotificationBanner showBannerWithTitle:@"Logro obtenido" message:@"Hiciste 40000 puntos!" completionHandler:^{}];
                        [logro1 showsCompletionBanner];
                    }
                    else if([logro isEqualToString:@"Puntos45000"]){
                        [GKNotificationBanner showBannerWithTitle:@"Logro obtenido" message:@"Hiciste 45000 puntos!" completionHandler:^{}];
                        [logro1 showsCompletionBanner];
                    }
                    else if([logro isEqualToString:@"Puntos47000"]){
                        [GKNotificationBanner showBannerWithTitle:@"Logro obtenido" message:@"Hiciste más de 47000 puntos!" completionHandler:^{}];
                        [logro1 showsCompletionBanner];
                    }
                }
            }

        }];
    }
}

-(void)reportarLogro:(NSString *)identificador conPorcentaje:(float)porcentaje{
    GKAchievement *logro=[[GKAchievement alloc]initWithIdentifier:identificador];
    logro.percentComplete=porcentaje;
    logro.showsCompletionBanner=YES;
    if(logro){
        NSArray *achievements = [NSArray arrayWithObjects:logro, nil];
        [GKAchievement reportAchievements:achievements withCompletionHandler:^(NSError *error) {
            if (error != nil) {
                NSLog(@"Error reportando logro: %@", error);
            }
            else{
                if(logro.isCompleted){
                    if([identificador isEqualToString:@"1"]){
                        [GKNotificationBanner showBannerWithTitle:@"Logro obtenido" message:@"Jugaste 2 veces!" completionHandler:^{}];
                        [logro showsCompletionBanner];
                    }
                    else if ([identificador isEqualToString:@"Juega10Veces"]){
                        [GKNotificationBanner showBannerWithTitle:@"Logro obtenido" message:@"Jugaste 10 veces!" completionHandler:^{}];
                        [logro showsCompletionBanner];
                    }
                    else if ([identificador isEqualToString:@"Juega20Veces"]){
                        [GKNotificationBanner showBannerWithTitle:@"Logro obtenido" message:@"Jugaste 20 veces!" completionHandler:^{}];
                        [logro showsCompletionBanner];
                    }
                    else if ([identificador isEqualToString:@"Juega30Veces"]){
                        [GKNotificationBanner showBannerWithTitle:@"Logro obtenido" message:@"Jugaste 30 veces!" completionHandler:^{}];
                        [logro showsCompletionBanner];
                    }
                    else if ([identificador isEqualToString:@"Juega50Veces"]){
                        [GKNotificationBanner showBannerWithTitle:@"Logro obtenido" message:@"Jugaste 50 veces!" completionHandler:^{}];
                        [logro showsCompletionBanner];
                    }
                    else if ([identificador isEqualToString:@"Juega100Veces"]){
                        [GKNotificationBanner showBannerWithTitle:@"Logro obtenido" message:@"Jugaste 100 veces!" completionHandler:^{}];
                        [logro showsCompletionBanner];
                    }
                    
                }
                
            }
        }];
    }
}

-(void)setUltimoError:(NSError*)error {
    ultimoError = [error copy];
    if (ultimoError) {
        NSLog(@"Error de game center: %@", [[ultimoError userInfo]
                                           description]);
    }
}

-(void)resetLogros{
    [GKAchievement resetAchievementsWithCompletionHandler:^(NSError *error)
     {
         if (error != nil){
             
         }
     }];
}

@end
