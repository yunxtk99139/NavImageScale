//
//  FirstTableCtl.m
//  testScrollView
//
//  Created by zhuyun on 16/3/14.
//  Copyright © 2016年 codera. All rights reserved.
//

#import "FirstTableCtl.h"
#import "UINavigationBar+extension.h"
#define STATUSBARHEIGHT  [UIApplication sharedApplication].statusBarFrame.size.height
#define NavigationBarHight 64.0f
#define SCREENWIDHT   [UIScreen mainScreen].bounds.size.width
static CGFloat ImageHight = 200.0f;
@interface FirstTableCtl ()
@property (nonatomic,strong) UIImageView* imageView;
@end

@implementation FirstTableCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString* path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"jpg"];
    UIImage* image = [UIImage imageNamed:path];
    CGFloat taslate = image.size.width / image.size.height;
    ImageHight = SCREENWIDHT / taslate;
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:0 green:130/250.0 blue:210/250.0 alpha:1];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.contentInset = UIEdgeInsetsMake(ImageHight-NavigationBarHight, 0, 0, 0);
//    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    UIImageView* imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView = imageView;
   _imageView.frame = CGRectMake(0, -ImageHight, SCREENWIDHT, ImageHight);
    [self.tableView addSubview:_imageView];
}
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
//    if([keyPath isEqualToString:@"contentOffset"]){
//    }
//}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y<-320) {
        scrollView.contentOffset = CGPointMake(0, -320);//限制下拉距离
    }
    UIColor * color = [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1];
    CGFloat offsetY = scrollView.contentOffset.y+ImageHight-NavigationBarHight+STATUSBARHEIGHT;
    if (offsetY > NavigationBarHight) {
        CGFloat alpha = MIN(1, 1 - ((NavigationBarHight + 64 - offsetY) / 64));
        [self.navigationController.navigationBar setBackgroundColor:[color colorWithAlphaComponent:alpha]];
    } else {
        [self.navigationController.navigationBar setBackgroundColor:[color colorWithAlphaComponent:0]];
    }
    CGFloat y = scrollView.contentOffset.y;//+NavigationBarHight;//根据实际选择加不加上NavigationBarHight（44、64 或者没有导航条）
    if (y < -ImageHight) {
        CGRect frame = _imageView.frame;
        frame.origin.y = y;
        frame.size.height =  -y;//contentMode = UIViewContentModeScaleAspectFill时，高度改变宽度也跟着改变
        _imageView.frame = frame;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 24;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     UITableViewCell *cell = [UITableViewCell new];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
