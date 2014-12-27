//
//  TodoListViewController.m
//  funeralv2
//
//  Created by Omer Janjua on 21/08/2014.
//  Copyright (c) 2014 Appitized. All rights reserved.
//

#import "TodoListViewController.h"
#import "TodoListTableViewCell.h"
#import "JVFloatLabeledTextField.h"
#import "KeyboardManager.h"
#import "NSObject+AssociatedObject.h"
#import "UIImage+Tint.h"

static NSString *kTodoListTableViewCell = @"TodoListTableViewCell";

@interface TodoListViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) TodoListTableViewCell *prototypeCell;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIView *navigationView;
@property (weak, nonatomic) IBOutlet UIButton *sideMenuButton;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UIButton *tickButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *underlineView;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *taskTextField;
@property (strong, nonatomic) NSMutableArray *cmsData;

@end

@implementation TodoListViewController

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
    
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
    
    [self getApi];
    
    [HelperClass dashboardSetup:_config.statusBarColour red:[_config.colourRed floatValue] green:[_config.colourGreen floatValue] blue:[_config.colourBlue floatValue] backgroundImageView:_backgroundImageView sideMenuButton:_sideMenuButton closeButton:_closeButton backButton:nil addMenuButton:_addButton tickMenuButton:_tickButton navigationTitle:_titleLabel navigationSubTitle:nil navigationThirdTitle:nil dashboardImage:nil submitButton:nil saveButton:nil todoListTextField:_taskTextField uiViewColour:_underlineView uisegmentedControlColour:nil];
    
    UINib *nib = [UINib nibWithNibName:@"TodoListTableViewCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:kTodoListTableViewCell];
    
    // Do any additional setup after loading the view from its nib.
    
    navigationViewHeightConstraint.constant = 64;
    
    [_taskTextField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"Task" attributes:@{NSForegroundColorAttributeName: [self appThemeColour:_config.statusBarColour]}]];
    
    _taskTextField.delegate = self;
    
    [_closeButton setHidden:YES];
    [_tickButton setHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Get CMS data
-(void)getApi
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"%@%@%@", Base_URL, _config.appId, Get_TodoList] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         _cmsData = [NSMutableArray new];
         NSArray *manualTodo = [UserDefault arrayForKey:@"manualTodo"];
         if(manualTodo){
             [_cmsData addObjectsFromArray:manualTodo];
         }
         
         
         for (int i = 0; i<[[responseObject objectForKey:@"matches"] count]; i++) {
             [_cmsData addObject:[[[[responseObject objectForKey:@"matches"] objectAtIndex:i] objectForKey:@"title"] objectForKey:@"data"]];
         }
         
         [self.tableView reloadData];
     }
         failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         //if no internet get data from the locally saved json
         NSArray *manualTodo = [UserDefault arrayForKey:@"manualTodo"];
         if(manualTodo){
             [_cmsData addObjectsFromArray:manualTodo];
         }
         
         [_cmsData addObjectsFromArray:[self dataFromLocalJSONFile]];
         
         [self.tableView reloadData];
     }];
}

-(NSMutableArray *)dataFromLocalJSONFile{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"todo-list.json"];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:documentsDirectoryPath] options:NSJSONReadingMutableContainers error:nil];
    
    NSMutableArray *tmp = [NSMutableArray new];
    for (int i = 0; i<[[dic objectForKey:@"matches"] count]; i++) {
        [tmp addObject:[[[[dic objectForKey:@"matches"] objectAtIndex:i] objectForKey:@"title"] objectForKey:@"data"]];
    }
    
    return tmp;
}

#pragma mark - UITableView DataSource & Delegates
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _cmsData.count;
}

-(NSString *)uniqueTodoRepresent:(NSString *)sentence{
    NSMutableCharacterSet *separators = [NSMutableCharacterSet punctuationCharacterSet];
    [separators formUnionWithCharacterSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return [[sentence componentsSeparatedByCharactersInSet:separators] componentsJoinedByString:@"-"];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TodoListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTodoListTableViewCell];
    [self configTodoCell:cell withIndexPath:indexPath];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    [self configTodoCell:self.prototypeCell withIndexPath:indexPath];
    [self.prototypeCell layoutIfNeeded];
    
    CGSize size = [self.prototypeCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height+1;
}

- (void)configTodoCell:(TodoListTableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row % 2) {
        cell.contentView.backgroundColor = [[UIColor alloc]initWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1];
    } else {
        cell.contentView.backgroundColor = [[UIColor alloc]initWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1];
    }
//    cell.titleLabel.preferredMaxLayoutWidth = CGRectGetWidth(_tableView.bounds);
    cell.titleLabel.text = [_cmsData objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.checkButton.associatedObject = indexPath;
    [cell.checkButton addTarget:self action:@selector(checkButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.checkButton setBackgroundImage:[[UIImage imageNamed:@"todo-list-circle"] todoTintedImageWithColor:[UIColor colorWithRed:[_config.colourRed floatValue]/255 green:[_config.colourGreen floatValue]/255 blue:[_config.colourBlue floatValue]/255 alpha:1] ]forState:UIControlStateNormal];
    [cell.checkButton setBackgroundImage:[[UIImage imageNamed:@"todo-list-tick"] todoTintedImageWithColor:[UIColor colorWithRed:[_config.colourRed floatValue]/255 green:[_config.colourGreen floatValue]/255 blue:[_config.colourBlue floatValue]/255 alpha:1] ]forState:UIControlStateSelected];
    
    if ([@"YES" isEqualToString:[[UserDefault dictionaryForKey:@"todoState"] objectForKey:[self uniqueTodoRepresent:[_cmsData objectAtIndex:indexPath.row]]]]) {
        cell.checkButton.selected = YES;
    }
    else{
        cell.checkButton.selected = NO;
    }
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSMutableArray *manualTodo = [[UserDefault arrayForKey:@"manualTodo"] mutableCopy];
        
        if (indexPath.row < [manualTodo count]) {
            //Detete todo item
            [_cmsData removeObjectAtIndex:indexPath.row];
            
            [manualTodo removeObjectAtIndex:indexPath.row];
            [UserDefault setObject:manualTodo forKey:@"manualTodo"];
            [UserDefault synchronize];
        }
        else{
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_config.appName message:@"Item only added manually can be deleted." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        [_tableView reloadData];
    }
}

- (IBAction)checkButtonTapped:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    
    
    //Store todo state here
    NSMutableDictionary *todoState = [[UserDefault dictionaryForKey:@"todoState"] mutableCopy];
    if (!todoState) {
        todoState = [NSMutableDictionary new];
    }
    NSIndexPath *indexPath = (NSIndexPath *)sender.associatedObject;
    if (sender.selected) {
        [todoState setObject:@"YES" forKey:[self uniqueTodoRepresent:[_cmsData objectAtIndex:indexPath.row]]];
    }
    else{
        [todoState setObject:@"NO" forKey:[self uniqueTodoRepresent:[_cmsData objectAtIndex:indexPath.row]]];
    }
    [UserDefault setValue:todoState forKey:@"todoState"];
    [UserDefault synchronize];
    
}
- (TodoListTableViewCell *)prototypeCell
{
    if (!_prototypeCell)
    {
        _prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:kTodoListTableViewCell];
    }
    return _prototypeCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TodoListTableViewCell *selectedCell = (TodoListTableViewCell *)[_tableView cellForRowAtIndexPath:indexPath];
    [selectedCell.checkButton sendActionsForControlEvents:UIControlEventTouchUpInside];
}


#pragma mark - Button Interactions
- (IBAction)addButtonPressed:(id)sender
{
    
    [_closeButton setHidden:NO];
    [_tickButton setHidden:NO];
    
    [_sideMenuButton setHidden:YES];
    [_addButton setHidden:YES];
    
    _titleLabel.text = @"Add A Task";
    
    [self.view layoutIfNeeded]; // Flush out frames
    
    [UIView animateWithDuration:0.3 animations:^{
        navigationViewHeightConstraint.constant = 124.0f;
        [self.view layoutIfNeeded];
    }];
    
}

- (IBAction)closeButtonPressed:(id)sender
{
    _titleLabel.text = @"To Do List";
    
    [_closeButton setHidden:YES];
    [_tickButton setHidden:YES];
    
    [_sideMenuButton setHidden:NO];
    [_addButton setHidden:NO];
    
    [self.view layoutIfNeeded]; // Flush out frames
    
    [UIView animateWithDuration:0.3 animations:^{
        navigationViewHeightConstraint.constant = 64.0f;
        [self.view layoutIfNeeded];
    }];
}

- (IBAction)tickButtonPressed:(id)sender
{
    if ([_taskTextField.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_config.appName message:@"You cannot add blank tasks" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        [_cmsData insertObject:_taskTextField.text atIndex:0];
        
        NSMutableArray *manualTodo = [[UserDefault arrayForKey:@"manualTodo"] mutableCopy];
        if (!manualTodo) {
            manualTodo = [NSMutableArray new];
        }
        [manualTodo insertObject:_taskTextField.text atIndex:0];
        [UserDefault setObject:manualTodo forKey:@"manualTodo"];
        [UserDefault synchronize];
        
        [_taskTextField resignFirstResponder];
        [_tableView reloadData];
        
        [_taskTextField setText:@""];
    }
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([_taskTextField isFirstResponder])
    {
        [_tickButton sendActionsForControlEvents:UIControlEventTouchUpInside];
        [_taskTextField resignFirstResponder];
    }
    return YES;
}

#pragma mark - App Theme Text Colour
- (UIColor *)appThemeColour:(NSString *)cmsThemeColour
{
    if ([cmsThemeColour isEqualToString:@"Light"]) {
        return [UIColor whiteColor];
    }
    if ([cmsThemeColour isEqualToString:@"Dark"]) {
        return [UIColor blackColor];
    }
    return [UIColor lightGrayColor];
}

-(void)dealloc{
    _tableView.dataSource = nil;
    _tableView.delegate = nil;
}

@end
