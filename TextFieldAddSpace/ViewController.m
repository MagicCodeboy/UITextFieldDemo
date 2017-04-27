//
//  ViewController.m
//  TextFieldAddSpace
//
//  Created by lalala on 2017/4/27.
//  Copyright © 2017年 lsh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextFieldDelegate>

@property(nonatomic,strong) UITextField * textField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(0, 100, 200, 50)];
    _textField.borderStyle = UITextBorderStyleLine;
    _textField.delegate = self;
    [self.view addSubview:_textField];
}
/**
 *  这个方法在textField的text被改变时调用,如果return NO,那么此次输入被忽略,YES,此次输入被添加
 *  @param textField 记住这个是改变之前的textFiled
 *  @param range     指的是要输入字符串的位置,比如用户在字符串之间进行插入,比如
 *  range = {4, 2}
 *  @param string    本次输入的字符串
 */
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    BOOL returnValue = YES;
    NSMutableString * newText = [NSMutableString stringWithCapacity:0];
    [newText appendString:textField.text];//拿到原有text 根据下面判断可能给它添加“”（空格）
    NSString * noBlankStr = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSInteger  textLength = [noBlankStr length];
    if (string.length) {
        if (textLength < 25) {//这个25是控制实际字符串长度，比如银行卡号长度
            if (textLength > 0 && textLength % 4 == 0) {
                newText = [NSMutableString stringWithString:[newText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];//这个方法是去除字符中的前后的空格
                [newText appendString:@" "];
                [newText appendString:string];
                textField.text = newText;
                returnValue = NO;
                //为什么return NO?因为textField.text = newText;text已经被我们替换好了,那么就不需要系统帮我们添加了,如果你ruturnYES的话,你会发现会多出一个字符串
            } else {
                [newText appendString:string];
            }
        } else {
            //比25长的话 return NO这样输入就无效了
            returnValue = NO;
        }
    } else {
        //如果输入为空 不用操作
        [newText replaceCharactersInRange:range withString:string];
    }
    return returnValue;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
