//
//  FirebaseRecognitionVC.m
//  firebase
//
//  Created by 朱校明 on 2020/4/29.
//  Copyright © 2020 goodick.com. All rights reserved.
//

#import "FirebaseRecognitionVC.h"
#import <AVFoundation/AVFoundation.h>

@interface FirebaseRecognitionVC ()<AVCaptureVideoDataOutputSampleBufferDelegate>

@property (weak, nonatomic) IBOutlet UIButton *runBtn;
@property (weak, nonatomic) IBOutlet UIButton *pauseBtn;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (nonatomic, strong) AVCaptureDevice *device;
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureDeviceInput *input;
@property (nonatomic, strong) AVCaptureVideoDataOutput *output;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *layer;

@end

@implementation FirebaseRecognitionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initAVCapture];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [_session startRunning];
    _runBtn.enabled = NO;
    _pauseBtn.enabled = YES;
    [self.view bringSubviewToFront:_runBtn];
    [self.view bringSubviewToFront:_pauseBtn];
    [self.view bringSubviewToFront:_textView];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [_session stopRunning];
}
- (void)initAVCapture {
    
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    _session = [AVCaptureSession new];
    [_session setSessionPreset:AVCaptureSessionPreset1920x1080];
    
    _input = [AVCaptureDeviceInput deviceInputWithDevice:_device error:nil];
    
    _output = [AVCaptureVideoDataOutput new];
    [_output setVideoSettings:@{(NSString *)kCVPixelBufferPixelFormatTypeKey:[NSNumber numberWithUnsignedInt:kCVPixelFormatType_32BGRA]}];
    [_output setSampleBufferDelegate:self queue:dispatch_queue_create("AVCaptureVideoDataOutput", DISPATCH_QUEUE_PRIORITY_DEFAULT)];
    
    [_session addInput:_input];
    [_session addOutput:_output];
    
    _layer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    _layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _layer.frame = self.view.bounds;
    [self.view.layer addSublayer:_layer];
}

- (void)captureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    
}
- (IBAction)runAction:(id)sender {
    
    [_session startRunning];
    _runBtn.enabled = NO;
    _pauseBtn.enabled = YES;
}
- (IBAction)pauseAction:(id)sender {
    
    [_session stopRunning];
    _runBtn.enabled = YES;
    _pauseBtn.enabled = NO;
}

@end
