//
//  GameCenterManager.h
//  Barce Memo 2013
//
//  Created by Victor Pinto on 06/10/13.
//  Copyright (c) 2013 Victor Pinto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

@protocol GameCenterManagerDelegate<NSObject>

-(void)puntajeEnviado:(bool)success;

@end

@interface GameCenterManager : NSObject

@property (assign,readonly) BOOL gameCenterDisponible;
@property BOOL usuarioAutenticado;
@property BOOL puntajeEnviado;
@property (retain) UIViewController *vcActual;
@property (nonatomic,assign) id <GameCenterManagerDelegate> delegate;
@property (nonatomic, readonly) NSError* ultimoError;

-(void)autenticarJugador;
-(void)jugadorAutenticado;
+(GameCenterManager*)solicitarHelper;
-(void)autenticacionCambio;
-(void)setUltimoError:(NSError*)error;
-(UIViewController*)getRootViewController;
-(void)presentViewController:(UIViewController*)vc;
-(void)enviarPuntaje:(int64_t)puntaje
           conIdentificador:(NSString*)identificador;
-(void)enviarPuntaje:(int64_t)puntaje conIdentificador:(NSString *)identificador conLogro:(NSString*)logro;
-(void)reportarLogro:(NSString*)identificador conPorcentaje:(float)porcentaje;
-(void)resetLogros;
@end
