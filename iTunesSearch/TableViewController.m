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

@interface TableViewController () {
    NSArray *midias;
}

@end

@implementation TableViewController

-(void)Pesquisa{
    iTunesManager *itunes = [iTunesManager sharedInstance];

    
      midias = [itunes buscarMidias:_searchBar.text];
    [_tableview reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
   // NSLog(@"%@", NSLocalizedString(@"a", nil));
    //[ _btnPesquisa setTitle:NSLocalizedString(@"searchKey", @"") forState:UIControlStateNormal];

    
    iTunesManager *itunes = [iTunesManager sharedInstance];
   // midias = [itunes buscarMidias:_searchBar.text];
    
    
    self.tableview.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f,self.tableview.bounds.size.width , 70.f)];
    
    
    _searchBar = [[UITextField alloc] initWithFrame:CGRectMake(10.0f, 30.0f, 200.0f, 44.0f)];
    _searchBar.borderStyle = UITextBorderStyleBezel;
    _searchBar.placeholder = @"Digite sua busca";
    
#warning Necessario para que a table view tenha um espaco em relacao ao topo, pois caso contrario o texto ficara atras da barra superior
  //  self.tableview.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableview.bounds.size.width, 15.f)];
    
   
    
    _btnPesquisa = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  //  [_btnPesquisa setTitle:@"Buscar" forState:UIControlStateNormal];
    _btnPesquisa.frame = CGRectMake(220.0f, 35.0f, 90.0f, 46.0f);
   /* [_btnPesquisa  addTarget:self
                   action:@selector(pesquisar)
         forControlEvents:UIControlEventTouchUpInside];*/
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
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [midias count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *celula = [self.tableview dequeueReusableCellWithIdentifier:@"celulaPadrao"];
    
    Midias *midias1 = [midias objectAtIndex:indexPath.row];
    
    [celula.nome setText:midias1.nome];
    [celula.pais setText:midias1.pais];
    [celula.preco setText:midias1.preco];
    
    
    [celula.tipo setText:midias1.tipo];
    
    NSURL *url = [NSURL URLWithString:midias1.imagem];
     NSData *imgData = [NSData dataWithContentsOfURL:url];
    
    [celula.imageView setImage:[UIImage imageWithData:imgData]];
    
    return celula;
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
