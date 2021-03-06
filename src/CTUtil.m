#import "CTUtil.h"

NSBundle *CTFrameworkBundle = nil;
NSBundle *CTHostBundle = nil;

@implementation CTUtil

+ (void)load {
  NSAutoreleasePool* pool = [NSAutoreleasePool new];
  CTFrameworkBundle = [[NSBundle bundleForClass:self] retain];
  assert(CTFrameworkBundle);
  CTHostBundle = [[NSBundle mainBundle] retain];
  assert(CTHostBundle);
  [pool drain];
}

+(NSBundle *)bundleForResource:(NSString *)name {
  return [self bundleForResource:name ofType:nil];
}

+(NSBundle *)bundleForResource:(NSString *)name ofType:(NSString *)ext {
  if ([CTHostBundle pathForResource:name ofType:ext])
    return CTHostBundle;
  assert([CTFrameworkBundle pathForResource:name ofType:ext]);
  return CTFrameworkBundle;
}

+(NSString *)pathForResource:(NSString *)name ofType:(NSString *)ext {
  NSString *path = [CTHostBundle pathForResource:name ofType:ext];
  if (path)
    return path;
  return [CTFrameworkBundle pathForResource:name ofType:ext];
}

@end
