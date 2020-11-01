//
//  ManageWordList.hpp
//  VocTrainer
//
//  Created by Thiviyan Saravanamuthu on 14.10.20.
//

#ifndef ManageWordList_h
#define ManageWordList_h

#ifdef __cplusplus
extern "C" {
#endif
  void WriteToList(const char* NameofPart,const char* FirstLanguage, const char* SecondLanguage, const char* FirstLanguageWord, const char* SecondLanguageWord);
  void ReadList(const char* Language, const char* SecondLanguage);

  //This isnt storing it Permanently
  void StoreLanguageChoice(const char* LanguageOne, const char* LanguageTwo);
  const char* getfirstLanguageChoice();
  const char* getsecondLanguageChoice();


  void TestE();
  
  const char* Languageone;
  const char* Languagetwo;

  
   
#ifdef __cplusplus
}
#endif


#endif /* ManageWordList_hpp */
