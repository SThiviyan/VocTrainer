//
//  Use this file to import your target's public headers that you would like to expose to Swift.
//

#ifndef ManageWorldList_hpp
#define ManageWorldList_hpp

#ifdef __cplusplus
extern "C" {
#endif
   
    
   void WriteToList(char *NameofPart,char *Language, char *SecondLanguage);
   void ReadList(char *Language, char *SecondLanguage);
    
#ifdef __cplusplus
}
#endif

#endif
