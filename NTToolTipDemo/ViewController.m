//
//  ViewController.m
//  NTToolTipDemo
//
//  Created by Brandon Nason on 11/3/11.
//  Copyright (c) 2011 Nason Tech. All rights reserved.
//

#import "ViewController.h"
#import "NTToolTip.h"

@implementation ViewController
{
	IBOutlet UILabel *label;
	IBOutlet UIButton *button;
	IBOutlet UISegmentedControl *segmentedControl;
	IBOutlet UITextField *textField;
	IBOutlet UIStepper *stepper;
	IBOutlet UIProgressView *progressBar;
	NTToolTip *toolTip;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
	textField.inputView = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

	toolTip = [[NTToolTip alloc] initWithTitle:@"" message:@"Select any item!" pointAt:button];
	[toolTip show];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
	    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
	} else {
	    return YES;
	}
}

- (IBAction)toolTipShow:(id)sender
{
	UIView *originalView = [toolTip pointAt];

	// Dismiss and release old NSToolTip
	[toolTip dismiss];
	[toolTip release], toolTip = nil;

	if (originalView != sender)
	{
		// Create new NSToolTip for new item
		toolTip = [[NTToolTip alloc] initWithTitle:@"" message:NSStringFromClass([sender class]) pointAt:sender];
		[toolTip show];
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	UIView *view = [[touches anyObject] view];
	if (view.tag > 0)
		[self toolTipShow:view];
}

@end