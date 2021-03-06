#ifndef mulle_serializable_version_h__
#define mulle_serializable_version_h__

/*
 *  version:  major, minor, patch
 */
#define MULLE_SERIALIZABLE_VERSION  ((0 << 20) | (7 << 8) | 56)


static inline unsigned int   MulleSerializable_get_version_major( void)
{
   return( MULLE_SERIALIZABLE_VERSION >> 20);
}


static inline unsigned int   MulleSerializable_get_version_minor( void)
{
   return( (MULLE_SERIALIZABLE_VERSION >> 8) & 0xFFF);
}


static inline unsigned int   MulleSerializable_get_version_patch( void)
{
   return( MULLE_SERIALIZABLE_VERSION & 0xFF);
}

#endif
