//
//  ViewController.m
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"
#import "iTunesManager.h"
#import "Entidades/Midias.h"
#import "Entidades/Filmes.h"
#import "Entidades/Musica.h"
#import "Entidades/Ebook.h"
#import "Entidades/Podcast.h"

@interface TableViewController () {
    NSArray *filme;
    NSArray *musica;
    NSArray *ebook;
    NSArray *podcast;
}

@end

@implementation TableViewController

-(void)Pesquisa {
    iTunesManager *itunes = [iTunesManager sharedInstance];

    
      filme = [itunes buscaFilme:_searchBar.text];
      musica = [itunes buscaMusica:_searchBar.text];
      ebook = [itunes buscaEbook:_searchBar.text];
      podcast  = [itunes buscaPodcast:_searchBar.text];


    [_tableview reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
   // NSLog(@"%@", NSLocalizedString(@"a", nil));
    //[ _btnPesquisa setTitle:NSLocalizedString(@"searchKey", @"") forState:UIControlStateNormal];

    
    iTunesManager *itunes = [iTunesManager sharedInstance];
   // midias = [itunes buscarMidias:_searchBar.text];
    
 //   filme= [itunes buscaFilme:_searchBar.text];
   // musica = [itunes buscaMusica:_searchBar.text];

    
    self.tableview.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f,self.tableview.bounds.size.width , 70.f)];
    
    
    _searchBar = [[UITextField alloc] initWithFrame:CGRectMake(10.0f, 30.0f, 200.0f, 44.0f)];
    _searchBar.borderStyle = UITextBorderStyleBezel;
    _searchBar.placeholder = @"Digite sua busca";
    
#warning Necessario para que a table view tenha um espaco em relacao ao topo, pois caso contrario o texto ficara atras da barra superior
    
   
    
    _btnPesquisa = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _btnPesquisa.frame = CGRectMake(220.0f, 35.0f, 90.0f, 46.0f);
 
    [_btnPesquisa addTarget:self
                     action:@selector(Pesquisa)
           forControlEvents:UIControlEventTouchUpInside];
    [self.tableview.tableHeaderView addSubview:_searchBar];
    [self.tableview.tableHeaderView addSubview:_btnPesquisa ];
     [_searchBar setDelegate:self];
  
    UINib *nib = [UINib nibWithNibName:@"TableViewCell" bundle:nil];

    [self.tableview registerNib:nib forCellReuseIdentifier:@"celulaPadrao"];
    

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Metodos do UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0)
        return filme.count;
    if (section == 1)
        return musica.count;
    if (section == 0)
        return ebook.count;
    if (section == 1)
        return podcast.count;
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //static NSString *CellIdentifier = @"Cell";
   // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    TableViewCell *celula = [self.tableview dequeueReusableCellWithIdentifier:@"celulaPadrao"];
    
  //Midias *midias1 = [Midias objectAtIndex:indexPath.row];
   Musica  *musica1 = [musica  objectAtIndex:indexPath.row];
   Filmes  *filme1 = [filme  objectAtIndex:indexPath.row];
   Ebook   *ebook1 = [ebook  objectAtIndex:indexPath.row];
   Podcast *podcast1 =  [podcast objectAtIndex:indexPath.row];

    
    
    
    if (indexPath.section == 0)
     //  celula.textLabel.text = [filme objectAtIndex:indexPath.row];
    [celula.nome setText:filme1.nome];
    [celula.pais setText:filme1.pais];
    [celula.preco setText:filme1.preco];
   [celula.tipo setText:filme1.tipo];
   NSURL *url = [NSURL URLWithString:filme1.imagem];
    
    NSData *imgData = [NSData dataWithContentsOfURL:url];
   
   [celula.imageView setImage:[UIImage imageWithData:imgData]];
    
    if (indexPath.section == 1){
 //   celula.textLabel.text = [musica objectAtIndex:indexPath.row];
  
        [celula.nome setText:musica1.nome];
        [celula.pais setText:musica1.pais];
        [celula.preco setText:musica1.preco];
        [celula.tipo setText:musica1.tipo];
        NSURL *url = [NSURL URLWithString:musica1.imagem];
        
        NSData *imgData = [NSData dataWithContentsOfURL:url];
        
        [celula.imageView setImage:[UIImage imageWithData:imgData]];


    
    }
  
    if (indexPath.section == 2){
        //   celula.textLabel.text = [musica objectAtIndex:indexPath.row];
        
        [celula.nome setText:ebook1.nome];
        [celula.pais setText:ebook1.pais];
        [celula.preco setText:ebook1.preco];
        [celula.tipo setText:ebook1.tipo];
        NSURL *url = [NSURL URLWithString:ebook1.imagem];
        
        NSData *imgData = [NSData dataWithContentsOfURL:url];
        
        [celula.imageView setImage:[UIImage imageWithData:imgData]];
        
        
        
    }
    if (indexPath.section == 3){
        //   celula.textLabel.text = [musica objectAtIndex:indexPath.row];
        
        [celula.nome setText:podcast1.nome];
        [celula.pais setText:podcast1.pais];
        [celula.preco setText:podcast1.preco];
        [celula.tipo setText:podcast1.tipo];
        NSURL *url = [NSURL URLWithString:podcast1.imagem];
        
        NSData *imgData = [NSData dataWithContentsOfURL:url];
        
        [celula.imageView setImage:[UIImage imageWithData:imgData]];
        
        
        
    }

    
    
    return celula;
    

 
    
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0)
        return @"Filme";
    if (section == 1)
        return @"Musica";
    if (section == 2)
        return @"Ebook";
    if (section == 3)
        return @"Podcast";
    return @"---";
}


-(void)viewDidAppear:(BOOL)animated{
    
    if([[[NSLocale preferredLanguages] objectAtIndex:0] isEqual: @"pt"] ){
    
        [_btnPesquisa setTitle:@"Procurar" forState:UIControlStateNormal];
    }
    
    else if ([[[NSLocale preferredLanguages] objectAtIndex:0] isEqual: @"en"]){
        
        [_btnPesquisa setTitle:@"Search" forState:UIControlStateNormal];
    }
    else if ([[[NSLocale preferredLanguages] objectAtIndex:0] isEqual: @"fr"]){
        
        [_btnPesquisa setTitle:@"Recherche" forState:UIControlStateNormal];

    }
    


}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}



-(BOOL) textFieldShouldReturn: (UITextField *) textField{
    
     [textField resignFirstResponder];
     return YES;
    }






@end
