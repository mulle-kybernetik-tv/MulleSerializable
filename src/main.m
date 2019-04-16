#import "import-private.h"

#include <stdio.h>

#include "version.h"

@class MulleObjCSerializable;
@protocol MulleObjCSerializable < NSCoding>
@end

@interface MulleObjCSerializable <MulleObjCSerializable>
@end


@implementation MulleObjCSerializable


struct coder_context
{
   id        self;
   NSCoder   *coder;
};


static mulle_objc_walkcommand_t
   decode_callback( struct _mulle_objc_property *property,
                    struct _mulle_objc_infraclass *cls,
                    struct coder_context *ctxt)
{
   uint32_t                   bits;
   ptrdiff_t                  offset;
   struct _mulle_objc_ivar    *ivar;
   mulle_objc_ivarid_t        ivarid;

   if( ! (_mulle_objc_property_get_bits( property) & _mulle_objc_property_serializable))
      return( mulle_objc_walk_ok);

   ivarid = _mulle_objc_property_get_ivarid( property);
   ivar   = mulle_objc_infraclass_search_ivar( cls, ivarid);
   offset = _mulle_objc_ivar_get_offset( ivar);
   [ctxt->coder decodeValueOfObjCType:_mulle_objc_ivar_get_signature( ivar) 
                                   at:&((char *) ctxt->self)[ offset]];
   return( mulle_objc_walk_ok);
}


- (instancetype) initWithCoder:(NSCoder *) coder
{
   Class                  cls;
   struct coder_context   ctxt;

   self = [self init];
   if( ! self)
      return( self);

   cls        = [self class];
   ctxt.self  = self;
   ctxt.coder = coder;
   _mulle_objc_infraclass_walk_properties( cls, 
                                           0, 
                                           (mulle_objc_walkpropertiescallback *) decode_callback, 
                                           &ctxt);
   return( self);
}

static mulle_objc_walkcommand_t
   encode_callback( struct _mulle_objc_property *property,
                    struct _mulle_objc_infraclass *cls,
                    struct coder_context *ctxt)
{
   uint32_t                   bits;
   ptrdiff_t                  offset;
   struct _mulle_objc_ivar    *ivar;
   mulle_objc_ivarid_t        ivarid;

   if( ! (_mulle_objc_property_get_bits( property) & _mulle_objc_property_serializable))
      return( mulle_objc_walk_ok);

   ivarid = _mulle_objc_property_get_ivarid( property);
   ivar   = mulle_objc_infraclass_search_ivar( cls, ivarid);
   offset = _mulle_objc_ivar_get_offset( ivar);
   [ctxt->coder encodeValueOfObjCType:_mulle_objc_ivar_get_signature( ivar) 
                                   at:&((char *) ctxt->self)[ offset]];
   return( mulle_objc_walk_ok);
}


- (void) encodeWithCoder:(NSCoder *) coder
{
   Class                  cls;
   struct coder_context   ctxt;

   cls        = [self class];
   ctxt.self  = self;
   ctxt.coder = coder;
   _mulle_objc_infraclass_walk_properties( cls, 
                                           0, 
                                           (mulle_objc_walkpropertiescallback *) encode_callback, 
                                           &ctxt);
}

@end


@interface Hello : NSObject <MulleObjCSerializable>

@property( serializable, assign) int    value;

@end


@implementation Hello
@end



@interface World : Hello 

@property( serializable, copy) NSString  *string;

@end


@implementation World
@end



int  main( int argc, char *argv[])
{
   World    *hello;
   World    *clone;
   NSData   *data;

   hello = [[World new] autorelease];
   [hello setValue:1848];
   [hello setString:@"Bochum"];

   data  = [NSArchiver archivedDataWithRootObject:hello];
   clone = [NSUnarchiver unarchiveObjectWithData:data];

   printf( "hello: %d %s\n", [hello value], [[hello string] UTF8String]);
   printf( "clone: %d %s\n", [clone value], [[clone string] UTF8String]);

   return( 0);
}
