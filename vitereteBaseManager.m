//
//  vitereteBaseManager.m
//  Barce Memo 2013
//
//  Created by Victor Pinto on 13/10/13.
//  Copyright (c) 2013 Victor Pinto. All rights reserved.
//

#import "vitereteBaseManager.h"
#import "GameCenterManager.h"

@implementation vitereteBaseManager

static vitereteBaseManager *helper=nil;


+(vitereteBaseManager *)solicitarHelper{
    if(!helper){
        helper=[[vitereteBaseManager alloc]init];
    }
    return helper;
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

-(void)crearTabla{
    char *err;
    NSString *sql=[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS 'Logros' ('clave' INTEGER PRIMARY KEY AUTOINCREMENT, 'id_logro' TEXT, 'porcentaje_completado' REAL);"];
    if(sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err)!=SQLITE_OK){
        sqlite3_close(db);
        NSAssert(0, @"Error al crear la tabla");
    }
    else{
        NSLog(@"La tabla se creo satisfactoriamente");
    }
}

-(void)insertarVecesJugadas{
    [self abrir];
    [self crearTabla];
    if([self obtenerPorcentajePorIdentificador:@"1"]<100){
        NSString *sql=[NSString stringWithFormat:@"UPDATE Logros SET porcentaje_completado=%.f WHERE id_logro='1';",50.0+[self obtenerPorcentajePorIdentificador:@"1"]];
        char *err;
        if(sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK){
            sqlite3_close(db);
            NSAssert(0, @"Error al crear un registro %@",[NSString stringWithUTF8String:sqlite3_errmsg(db)]);
        }
        if(sqlite3_changes(db)==0){
            NSString *sql1=[NSString stringWithFormat:@"INSERT INTO Logros(id_logro,porcentaje_completado) VALUES('1',%.f);",50.0];
            NSLog(@"Porcentaje 1 antes %f",[self obtenerPorcentajePorIdentificador:@"1"]);
            char *err;
            if(sqlite3_exec(db, [sql1 UTF8String], NULL, NULL, &err) != SQLITE_OK){
                sqlite3_close(db);
                NSAssert(0, @"Error al crear un registro %@",[NSString stringWithUTF8String:sqlite3_errmsg(db)]);
            }
        }
                [[GameCenterManager solicitarHelper]reportarLogro:@"1" conPorcentaje:[self obtenerPorcentajePorIdentificador:@"1"]];
    }
    if([self obtenerPorcentajePorIdentificador:@"Juega10Veces"]<100){
       NSString *sql=[NSString stringWithFormat:@"UPDATE Logros SET porcentaje_completado=%.f WHERE id_logro='Juega10Veces';",10.0+[self obtenerPorcentajePorIdentificador:@"Juega10Veces"]];
        char *err;
        if(sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK){
            sqlite3_close(db);
            NSAssert(0, @"Error al crear un registro %@",[NSString stringWithUTF8String:sqlite3_errmsg(db)]);
        }
        if(sqlite3_changes(db)==0){
            NSString *sql1=[NSString stringWithFormat:@"INSERT INTO Logros(id_logro,porcentaje_completado) VALUES('Juega10Veces',%.f);",10.0+[self obtenerPorcentajePorIdentificador:@"Juega10Veces"]];
            NSLog(@"Porcentaje 2 antes %f",[self obtenerPorcentajePorIdentificador:@"Juega10Veces"]);
            char *err;
            if(sqlite3_exec(db, [sql1 UTF8String], NULL, NULL, &err) != SQLITE_OK){
                sqlite3_close(db);
                NSAssert(0, @"Error al crear un registro %@",[NSString stringWithUTF8String:sqlite3_errmsg(db)]);
            }
        }
        [[GameCenterManager solicitarHelper]reportarLogro:@"Juega10Veces" conPorcentaje:[self obtenerPorcentajePorIdentificador:@"Juega10Veces"]];
    }
    if([self obtenerPorcentajePorIdentificador:@"Juega20Veces"]<100){
        NSString *sql=[NSString stringWithFormat:@"UPDATE Logros SET porcentaje_completado=%.f WHERE id_logro='Juega20Veces';",5.0+[self obtenerPorcentajePorIdentificador:@"Juega20Veces"]];
        char *err;
        if(sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK){
            sqlite3_close(db);
            NSAssert(0, @"Error al crear un registro %@",[NSString stringWithUTF8String:sqlite3_errmsg(db)]);
        }
        if(sqlite3_changes(db)==0){
            NSString *sql1=[NSString stringWithFormat:@"INSERT INTO Logros(id_logro,porcentaje_completado) VALUES('Juega20Veces',%.f);",5.0+[self obtenerPorcentajePorIdentificador:@"Juega20Veces"]];
            char *err;
            if(sqlite3_exec(db, [sql1 UTF8String], NULL, NULL, &err) != SQLITE_OK){
                sqlite3_close(db);
                NSAssert(0, @"Error al crear un registro %@",[NSString stringWithUTF8String:sqlite3_errmsg(db)]);
            }
        }
        [[GameCenterManager solicitarHelper]reportarLogro:@"Juega20Veces" conPorcentaje:[self obtenerPorcentajePorIdentificador:@"Juega20Veces"]];
    }
    if([self obtenerPorcentajePorIdentificador:@"Juega30Veces"]<100){
        NSString *sql=[NSString stringWithFormat:@"UPDATE Logros SET porcentaje_completado=%.f WHERE id_logro='Juega30Veces';",3.3+[self obtenerPorcentajePorIdentificador:@"Juega30Veces"]];
        char *err;
        if(sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK){
            sqlite3_close(db);
            NSAssert(0, @"Error al crear un registro %@",[NSString stringWithUTF8String:sqlite3_errmsg(db)]);
        }
        if(sqlite3_changes(db)==0){
            NSString *sql1=[NSString stringWithFormat:@"INSERT INTO Logros(id_logro,porcentaje_completado) VALUES('Juega30Veces',%.f);",3.3+[self obtenerPorcentajePorIdentificador:@"Juega30Veces"]];
            char *err;
            if(sqlite3_exec(db, [sql1 UTF8String], NULL, NULL, &err) != SQLITE_OK){
                sqlite3_close(db);
                NSAssert(0, @"Error al crear un registro %@",[NSString stringWithUTF8String:sqlite3_errmsg(db)]);
            }
        }
        [[GameCenterManager solicitarHelper]reportarLogro:@"Juega30Veces" conPorcentaje:[self obtenerPorcentajePorIdentificador:@"Juega30Veces"]];
    }
    if([self obtenerPorcentajePorIdentificador:@"Juega50Veces"]<100){
        NSString *sql=[NSString stringWithFormat:@"UPDATE Logros SET porcentaje_completado=%.f WHERE id_logro='Juega50Veces';",2.0+[self obtenerPorcentajePorIdentificador:@"Juega50Veces"]];
        char *err;
        if(sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK){
            sqlite3_close(db);
            NSAssert(0, @"Error al crear un registro %@",[NSString stringWithUTF8String:sqlite3_errmsg(db)]);
        }
        if(sqlite3_changes(db)==0){
            NSString *sql1=[NSString stringWithFormat:@"INSERT INTO Logros(id_logro,porcentaje_completado) VALUES('Juega50Veces',%.f);",2.0+[self obtenerPorcentajePorIdentificador:@"Juega50Veces"]];
            char *err;
            if(sqlite3_exec(db, [sql1 UTF8String], NULL, NULL, &err) != SQLITE_OK){
                sqlite3_close(db);
                NSAssert(0, @"Error al crear un registro %@",[NSString stringWithUTF8String:sqlite3_errmsg(db)]);
            }
        }
        [[GameCenterManager solicitarHelper]reportarLogro:@"Juega50Veces" conPorcentaje:[self obtenerPorcentajePorIdentificador:@"Juega50Veces"]];
    }
    if([self obtenerPorcentajePorIdentificador:@"Juega100Veces"]<100){
        NSString *sql=[NSString stringWithFormat:@"UPDATE Logros SET porcentaje_completado=%.f WHERE id_logro='Juega100Veces';",1.0+[self obtenerPorcentajePorIdentificador:@"Juega100Veces"]];
        char *err;
        if(sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK){
            sqlite3_close(db);
            NSAssert(0, @"Error al crear un registro %@",[NSString stringWithUTF8String:sqlite3_errmsg(db)]);
        }
        if(sqlite3_changes(db)==0){
            NSString *sql1=[NSString stringWithFormat:@"INSERT INTO Logros(id_logro,porcentaje_completado) VALUES('Juega100Veces',%.f);",1.0+[self obtenerPorcentajePorIdentificador:@"Juega100Veces"]];
            char *err;
            if(sqlite3_exec(db, [sql1 UTF8String], NULL, NULL, &err) != SQLITE_OK){
                sqlite3_close(db);
                NSAssert(0, @"Error al crear un registro %@",[NSString stringWithUTF8String:sqlite3_errmsg(db)]);
            }
        }
        [[GameCenterManager solicitarHelper]reportarLogro:@"Juega100Veces" conPorcentaje:[self obtenerPorcentajePorIdentificador:@"Juega100Veces"]];
    }
}

-(void)insertarPuntaje:(int)puntaje{
    [self abrir];
    [self crearTabla];
    BOOL tieneLogro=NO;
    if(puntaje>=47000){
        if([self obtenerPorcentajePorIdentificador:@"Puntos47000"]<100){
            tieneLogro=YES;
            NSString *sql=[NSString stringWithFormat:@"UPDATE Logros SET porcentaje_completado=100.0 WHERE id_logro='Puntos47000';"];
            char *err;
            if(sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK){
                sqlite3_close(db);
                NSAssert(0, @"Error al crear un registro %@",[NSString stringWithUTF8String:sqlite3_errmsg(db)]);
            }
            if(sqlite3_changes(db)==0){
                NSString *sql1=[NSString stringWithFormat:@"INSERT INTO Logros(id_logro,porcentaje_completado) VALUES('Puntos47000',100.0);"];
                char *err;
                if(sqlite3_exec(db, [sql1 UTF8String], NULL, NULL, &err) != SQLITE_OK){
                    sqlite3_close(db);
                    NSAssert(0, @"Error al crear un registro %@",[NSString stringWithUTF8String:sqlite3_errmsg(db)]);
                }
            }
            if(tieneLogro==NO){
                [[GameCenterManager solicitarHelper]enviarPuntaje:puntaje conIdentificador:@"1"];
            }
            else{
                [[GameCenterManager solicitarHelper]enviarPuntaje:puntaje conIdentificador:@"1" conLogro:@"Puntos47000"];
            }
        }
    }
    else if(puntaje>=45000){
        if([self obtenerPorcentajePorIdentificador:@"Puntos45000"]<100){
            tieneLogro=YES;
            NSString *sql=[NSString stringWithFormat:@"UPDATE Logros SET porcentaje_completado=100.0 WHERE id_logro='Puntos45000';"];
            char *err;
            if(sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK){
                sqlite3_close(db);
                NSAssert(0, @"Error al crear un registro %@",[NSString stringWithUTF8String:sqlite3_errmsg(db)]);
            }
            if(sqlite3_changes(db)==0){
                NSString *sql1=[NSString stringWithFormat:@"INSERT INTO Logros(id_logro,porcentaje_completado) VALUES('Puntos45000',100.0);"];
                char *err;
                if(sqlite3_exec(db, [sql1 UTF8String], NULL, NULL, &err) != SQLITE_OK){
                    sqlite3_close(db);
                    NSAssert(0, @"Error al crear un registro %@",[NSString stringWithUTF8String:sqlite3_errmsg(db)]);
                }
            }
            if(tieneLogro==NO){
                [[GameCenterManager solicitarHelper]enviarPuntaje:puntaje conIdentificador:@"1"];
            }
            else{
                [[GameCenterManager solicitarHelper]enviarPuntaje:puntaje conIdentificador:@"1" conLogro:@"Puntos45000"];
            }
        }
    }
    else if(puntaje>=40000){
        if([self obtenerPorcentajePorIdentificador:@"Puntos40000"]<100){
            tieneLogro=YES;
            NSString *sql=[NSString stringWithFormat:@"UPDATE Logros SET porcentaje_completado=100.0 WHERE id_logro='Puntos40000';"];
            char *err;
            if(sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK){
                sqlite3_close(db);
                NSAssert(0, @"Error al crear un registro %@",[NSString stringWithUTF8String:sqlite3_errmsg(db)]);
            }
            if(sqlite3_changes(db)==0){
                NSString *sql1=[NSString stringWithFormat:@"INSERT INTO Logros(id_logro,porcentaje_completado) VALUES('Puntos40000',100.0);"];
                char *err;
                if(sqlite3_exec(db, [sql1 UTF8String], NULL, NULL, &err) != SQLITE_OK){
                    sqlite3_close(db);
                    NSAssert(0, @"Error al crear un registro %@",[NSString stringWithUTF8String:sqlite3_errmsg(db)]);
                }
            }
            if(tieneLogro==NO){
                [[GameCenterManager solicitarHelper]enviarPuntaje:puntaje conIdentificador:@"1"];
            }
            else{
                [[GameCenterManager solicitarHelper]enviarPuntaje:puntaje conIdentificador:@"1" conLogro:@"Puntos40000"];
            }
        }
    }
    else if(puntaje>=35000){
        if([self obtenerPorcentajePorIdentificador:@"Puntos35000"]<100){
            tieneLogro=YES;
            NSString *sql=[NSString stringWithFormat:@"UPDATE Logros SET porcentaje_completado=100.0 WHERE id_logro='Puntos35000';"];
            char *err;
            if(sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK){
                sqlite3_close(db);
                NSAssert(0, @"Error al crear un registro %@",[NSString stringWithUTF8String:sqlite3_errmsg(db)]);
            }
            if(sqlite3_changes(db)==0){
                NSString *sql1=[NSString stringWithFormat:@"INSERT INTO Logros(id_logro,porcentaje_completado) VALUES('Puntos35000',100.0);"];
                char *err;
                if(sqlite3_exec(db, [sql1 UTF8String], NULL, NULL, &err) != SQLITE_OK){
                    sqlite3_close(db);
                    NSAssert(0, @"Error al crear un registro %@",[NSString stringWithUTF8String:sqlite3_errmsg(db)]);
                }
            }
            if(tieneLogro==NO){
                [[GameCenterManager solicitarHelper]enviarPuntaje:puntaje conIdentificador:@"1"];
            }
            else{
                [[GameCenterManager solicitarHelper]enviarPuntaje:puntaje conIdentificador:@"1" conLogro:@"Puntos35000"];
            }
        }
    }
    else if(puntaje>=30000){
        if([self obtenerPorcentajePorIdentificador:@"Puntos30000"]<100){
            tieneLogro=YES;
            NSString *sql=[NSString stringWithFormat:@"UPDATE Logros SET porcentaje_completado=100.0 WHERE id_logro='Puntos30000';"];
            char *err;
            if(sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK){
                sqlite3_close(db);
                NSAssert(0, @"Error al crear un registro %@",[NSString stringWithUTF8String:sqlite3_errmsg(db)]);
            }
            if(sqlite3_changes(db)==0){
                NSString *sql1=[NSString stringWithFormat:@"INSERT INTO Logros(id_logro,porcentaje_completado) VALUES('Puntos30000',100.0);"];
                char *err;
                if(sqlite3_exec(db, [sql1 UTF8String], NULL, NULL, &err) != SQLITE_OK){
                    sqlite3_close(db);
                    NSAssert(0, @"Error al crear un registro %@",[NSString stringWithUTF8String:sqlite3_errmsg(db)]);
                }
            }
            if(tieneLogro==NO){
                [[GameCenterManager solicitarHelper]enviarPuntaje:puntaje conIdentificador:@"1"];
            }
            else{
                [[GameCenterManager solicitarHelper]enviarPuntaje:puntaje conIdentificador:@"1" conLogro:@"Puntos30000"];
            }
        }
    }
    else if(puntaje>=25000){
        if([self obtenerPorcentajePorIdentificador:@"Puntos25000"]<100){
            tieneLogro=YES;
            NSString *sql=[NSString stringWithFormat:@"UPDATE Logros SET porcentaje_completado=100.0 WHERE id_logro='Puntos25000';"];
            char *err;
            if(sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK){
                sqlite3_close(db);
                NSAssert(0, @"Error al crear un registro %@",[NSString stringWithUTF8String:sqlite3_errmsg(db)]);
            }
            if(sqlite3_changes(db)==0){
                NSString *sql1=[NSString stringWithFormat:@"INSERT INTO Logros(id_logro,porcentaje_completado) VALUES('Puntos25000',100.0);"];
                char *err;
                if(sqlite3_exec(db, [sql1 UTF8String], NULL, NULL, &err) != SQLITE_OK){
                    sqlite3_close(db);
                    NSAssert(0, @"Error al crear un registro %@",[NSString stringWithUTF8String:sqlite3_errmsg(db)]);
                }
            }
            if(tieneLogro==NO){
                [[GameCenterManager solicitarHelper]enviarPuntaje:puntaje conIdentificador:@"1"];
            }
            else{
                [[GameCenterManager solicitarHelper]enviarPuntaje:puntaje conIdentificador:@"1" conLogro:@"Puntos25000"];
            }
        }
    }
    else if(puntaje>=15000){
        if([self obtenerPorcentajePorIdentificador:@"Puntos15000"]<100){
            tieneLogro=YES;
            NSString *sql=[NSString stringWithFormat:@"UPDATE Logros SET porcentaje_completado=100.0 WHERE id_logro='Puntos15000';"];
            char *err;
            if(sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK){
                sqlite3_close(db);
                NSAssert(0, @"Error al crear un registro %@",[NSString stringWithUTF8String:sqlite3_errmsg(db)]);
            }
            if(sqlite3_changes(db)==0){
                NSString *sql1=[NSString stringWithFormat:@"INSERT INTO Logros(id_logro,porcentaje_completado) VALUES('Puntos15000',100.0);"];
                char *err;
                if(sqlite3_exec(db, [sql1 UTF8String], NULL, NULL, &err) != SQLITE_OK){
                    sqlite3_close(db);
                    NSAssert(0, @"Error al crear un registro %@",[NSString stringWithUTF8String:sqlite3_errmsg(db)]);
                }
            }
            if(tieneLogro==NO){
                [[GameCenterManager solicitarHelper]enviarPuntaje:puntaje conIdentificador:@"1"];
            }
            else{
                [[GameCenterManager solicitarHelper]enviarPuntaje:puntaje conIdentificador:@"1" conLogro:@"Puntos15000"];
            }
        }
    }
}

-(float)obtenerPorcentajePorIdentificador:(NSString *)id{
    NSString *val=@"";
     NSString *sql=[NSString stringWithFormat:@"SELECT porcentaje_completado FROM Logros WHERE id_logro='%@'",id];
     sqlite3_stmt *statement;
     if(sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil)==SQLITE_OK){
     while (sqlite3_step(statement)==SQLITE_ROW) {
         char *campo1=(char*)sqlite3_column_text(statement, 0);
         val=[NSString stringWithUTF8String:campo1];
         sqlite3_finalize(statement);
         return val.floatValue;
     }

     }
     else{
         NSLog(@"valiste");
     }
}

-(void)resetearBase{
    NSString *sql=[NSString stringWithFormat:@"DELETE FROM Logros"];
    char *err;
    if(sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK){
        sqlite3_close(db);
        NSAssert(0, @"Error al crear un registro %@",[NSString stringWithUTF8String:sqlite3_errmsg(db)]);
    }

}


@end
