//
//  iTunesManager.m
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "iTunesManager.h"
#import "Entidades/Midias.h"
#import "Entidades/Filmes.h"
#import "Entidades/Musica.h"
#import "Entidades/Ebook.h"







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


- (NSArray *)buscaFilme:(NSString *)termo {
    if (!termo) {
        termo = @"";
    }
    
    
  
    NSString *url = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@&media=movie", termo];
    NSData *jsonData = [NSData dataWithContentsOfURL: [NSURL URLWithString:url]];
    
    NSError *error;
    NSDictionary *resultado = [NSJSONSerialization JSONObjectWithData:jsonData
                                                              options:NSJSONReadingMutableContainers
                                                                error:&error];
    
    NSArray *resultados = [resultado objectForKey:@"results"];
 //   NSMutableArray *midiasArray = [[NSMutableArray alloc] init];
    if (error) {
        NSLog(@"Não foi possível fazer a busca. ERRO: %@", error);
        return nil;
    }
    
   // NSArray *resultados = [self pesquisa:termo: @"movie"];
    NSMutableArray *filmeArray = [[NSMutableArray alloc] init];
    for (NSDictionary *item in resultados) {
        Filmes *filmeTunes = [[Filmes alloc] init];

        [filmeTunes setNome:[item objectForKey:@"trackName"]];
        [filmeTunes setTrackId:[item objectForKey:@"trackId"]];
        [filmeTunes setArtista:[item objectForKey:@"artistName"]];
        [filmeTunes setDuracao:[item objectForKey:@"trackTimeMillis"]];
        [filmeTunes setGenero:[item objectForKey:@"primaryGenreName"]];
        [filmeTunes setPais:[item objectForKey:@"country"]];
        [filmeTunes setTipo:[item objectForKey:@"kind"]];
        [filmeTunes setPreco:[NSString stringWithFormat:@"$%@",[item objectForKey:@"trackPrice"]]];
       // NSString *string = [NSString stringWithFormat:@"%@", [item objectForKey:@"trackPrice"]];
        [filmeTunes setImagem:[item objectForKey:@"artworkUrl60"]];
        [filmeArray addObject:filmeTunes];


        
    }
    
    
    

    
    
    return filmeArray
    ;
}



- (NSArray *)buscaMusica:(NSString *)termo {
    if (!termo) {
        termo = @"";
    }
    
    
    
    NSString *url = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@&media=music", termo];
    NSData *jsonData = [NSData dataWithContentsOfURL: [NSURL URLWithString:url]];
    
    NSError *error;
    NSDictionary *resultado = [NSJSONSerialization JSONObjectWithData:jsonData
                                                              options:NSJSONReadingMutableContainers
                                                                error:&error];

    NSArray *resultados = [resultado objectForKey:@"results"];

    NSMutableArray *musicaArray = [[NSMutableArray alloc] init];
    for (NSDictionary *item in resultados) {
        Musica *musicaTunes = [[Musica alloc]init];
        
        [musicaTunes setNome:[item objectForKey:@"trackName"]];
        [musicaTunes setTrackId:[item objectForKey:@"trackId"]];
        [musicaTunes setArtista:[item objectForKey:@"artistName"]];
        [musicaTunes setDuracao:[item objectForKey:@"trackTimeMillis"]];
        [musicaTunes setGenero:[item objectForKey:@"primaryGenreName"]];
        [musicaTunes setPais:[item objectForKey:@"country"]];
        [musicaTunes setTipo:[item objectForKey:@"kind"]];
        [musicaTunes setPreco:[NSString stringWithFormat:@"$%@",[item objectForKey:@"trackPrice"]]];
        [musicaTunes setImagem:[item objectForKey:@"artworkUrl60"]];
        [musicaArray addObject:musicaTunes];
    }
    return musicaArray;
}


- (NSArray *)buscaEbook:(NSString *)termo{
    if (!termo) {
        termo = @"";
    }
    
    
    
    NSString *url = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@&media=ebook", termo];
    NSData *jsonData = [NSData dataWithContentsOfURL: [NSURL URLWithString:url]];
    
    NSError *error;
    NSDictionary *resultado = [NSJSONSerialization JSONObjectWithData:jsonData
                                                              options:NSJSONReadingMutableContainers
                                                                error:&error];
    
    NSArray *resultados = [resultado objectForKey:@"results"];
    
    NSMutableArray *ebookArray = [[NSMutableArray alloc] init];
    for (NSDictionary *item in resultados) {
        Ebook *ebookTunes = [[Ebook alloc]init];
        
        [ebookTunes setNome:[item objectForKey:@"trackName"]];
        [ebookTunes setTrackId:[item objectForKey:@"trackId"]];
        [ebookTunes setArtista:[item objectForKey:@"artistName"]];
        [ebookTunes setDuracao:[item objectForKey:@"trackTimeMillis"]];
        [ebookTunes setGenero:[item objectForKey:@"primaryGenreName"]];
        [ebookTunes setPais:[item objectForKey:@"country"]];
        [ebookTunes setTipo:[item objectForKey:@"kind"]];
        [ebookTunes setPreco:[NSString stringWithFormat:@"$%@",[item objectForKey:@"trackPrice"]]];
        [ebookTunes setImagem:[item objectForKey:@"artworkUrl60"]];
        [ebookArray addObject:ebookTunes];
    }
    return ebookArray;
    
}
- (NSArray *)buscaPodcast:(NSString *)termo{
    
    if (!termo) {
        termo = @"";
    }
    
    
    
    NSString *url = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@&media=podcast", termo];
    NSData *jsonData = [NSData dataWithContentsOfURL: [NSURL URLWithString:url]];
    
    NSError *error;
    NSDictionary *resultado = [NSJSONSerialization JSONObjectWithData:jsonData
                                                              options:NSJSONReadingMutableContainers
                                                                error:&error];
    
    NSArray *resultados = [resultado objectForKey:@"results"];
    
    NSMutableArray *podcastArray = [[NSMutableArray alloc] init];
    for (NSDictionary *item in resultados) {
        Musica *podcastTunes = [[Musica alloc]init];
        
        [podcastTunes setNome:[item objectForKey:@"trackName"]];
        [podcastTunes setTrackId:[item objectForKey:@"trackId"]];
        [podcastTunes setArtista:[item objectForKey:@"artistName"]];
        [podcastTunes setDuracao:[item objectForKey:@"trackTimeMillis"]];
        [podcastTunes setGenero:[item objectForKey:@"primaryGenreName"]];
        [podcastTunes setPais:[item objectForKey:@"country"]];
        [podcastTunes setTipo:[item objectForKey:@"kind"]];
        [podcastTunes setPreco:[NSString stringWithFormat:@"$%@",[item objectForKey:@"trackPrice"]]];
        [podcastTunes setImagem:[item objectForKey:@"artworkUrl60"]];
        [podcastArray addObject:podcastTunes];
    }
    return podcastArray;
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
