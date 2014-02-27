#import "UIImage+AdditionalFunctionalities.h"

@implementation UIImage (AddtionalFunctionalities)


- (UIImage *)imageWithTint:(UIColor *)tintColor
{
    CGRect aRect = CGRectMake(0.f, 0.f, self.size.width, self.size.height);
    CGImageRef alphaMask;
    
    {
        UIGraphicsBeginImageContext(aRect.size);
        CGContextRef c = UIGraphicsGetCurrentContext();
        
        CGContextTranslateCTM(c, 0, aRect.size.height);
        CGContextScaleCTM(c, 1.0, -1.0);
        [self drawInRect: aRect];
        
        alphaMask = CGBitmapContextCreateImage(c);
        
        UIGraphicsEndImageContext();
    }
    
    UIGraphicsBeginImageContext(aRect.size);
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    [self drawInRect:aRect];
    
    CGContextClipToMask(c, aRect, alphaMask);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextSetFillColorSpace(c, colorSpace);
    CGContextSetFillColorWithColor(c, tintColor.CGColor);
    
    UIRectFillUsingBlendMode(aRect, kCGBlendModeNormal);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(alphaMask);
    
    return img;
}

- (UIImage *)imageWithGradient:(NSArray *)colorsArr{
    UIGraphicsBeginImageContext(CGSizeMake(self.size.width , self.size.height ));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, self.size.width , self.size.height );
    CGContextDrawImage(context, rect, self.CGImage);
    
    // Create gradient
    UIColor *colorOne = [colorsArr objectAtIndex:1]; // top color
    UIColor *colorTwo = [colorsArr objectAtIndex:0]; // bottom color
    
    NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, (id)colorTwo.CGColor, nil];
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColors(space, (__bridge CFArrayRef)colors, NULL);
    
    // Apply gradient
    CGContextClipToMask(context, rect, self.CGImage);
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0,0), CGPointMake(0,self.size.height ), 0);
    UIImage *gradientImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return gradientImage;
}

-(UIImage*)scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

@end