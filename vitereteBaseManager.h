//
//  vitereteBaseManager.h
//  Barce Memo 2013
//
//  Created by Victor Pinto on 13/10/13.
//  Copyright (c) 2013 Victor Pinto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"

@interface vitereteBaseManager : NSObject
{
    sqlite3 *db;
}

@property (nonatomic,readonly) NSNumber *clave;
@property NSURL *url;
-(NSString*)path;
-(void)abrir;
-(void)crearTabla;
-(void)insertarVecesJugadas;
-(void)insertarPuntaje:(int)puntaje;
-(float)obtenerPorcentajePorIdentificador:(NSString*)id;
+(vitereteBaseManager*)solicitarHelper;
-(void)resetearBase;

@end
