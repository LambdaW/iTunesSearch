//
//  iTunesManager.m
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "iTunesManager.h"
#import "Entidades/Midias.h"

@implementation iTunesManager

static iTunesManager *SINGLETON = nil;

static bool isFirstAccess = YES;

#pragma mark - Public Method

+ (id)sharedInstance
{
  
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isFirstAccess = NO;
        SINGLETON = [[super allocWithZone:NULL] init];    
    });
    
    return SINGLETON;
}


- (NSArray *)buscarMidias:(NSString *)termo {
  
    
    if (!termo) {
        termo = @"";
    }
    
    NSString *url = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@&media=all", termo];
    NSData *jsonData = [NSData dataWithContentsOfURL: [NSURL URLWithString:url]];
    
    NSError *error;
    NSDictionary *resultado = [NSJSONSerialization JSONObjectWithData:jsonData
                                                              options:NSJSONReadingMutableContainers
                                                                error:&error];
    if (error) {
        NSLog(@"Não foi possível fazer a busca. ERRO: %@", error);
        return nil;
    }
    
    
    NSArray *resultados = [resultado objectForKey:@"results"];
    NSMutableArray *midiasArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *item in resultados) {
        Midias *midiaTunes = [[Midias alloc] init];
        [midiaTunes setNome:[item objectForKey:@"trackName"]];
        [midiaTunes setTrackId:[item objectForKey:@"trackId"]];
        [midiaTunes setArtista:[item objectForKey:@"artistName"]];
        [midiaTunes setDuracao:[item objectForKey:@"trackTimeMillis"]];
        [midiaTunes setGenero:[item objectForKey:@"primaryGenreName"]];
        [midiaTunes setPais:[item objectForKey:@"country"]];
        [midiaTunes setTipo:[item objectForKey:@"kind"]];
       
        
        
        NSString *string = [NSString stringWithFormat:@"%@", [item objectForKey:@"trackPrice"]];
        
        [midiaTunes setImagem:[item objectForKey:@"artworkUrl60"]];
        [midiasArray addObject:midiaTunes];
        
;
        
        [midiaTunes setPreco:string];
       // [filmes addObject:filme];
    }
    
    return midiasArray;
}




#pragma mark - Life Cycle

+ (id) allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)copyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)mutableCopyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

- (id)copy
{
    return [[iTunesManager alloc] init];
}

- (id)mutableCopy
{
    return [[iTunesManager alloc] init];
}

- (id) init
{
    if(SINGLETON){
        return SINGLETON;
    }
    if (isFirstAccess) {
        [self doesNotRecognizeSelector:_cmd]
        ;
    }
    self = [super init];
    return self;
}


@end
