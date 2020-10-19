//
//  ManageWordList.hpp
//  VocTrainer
//
//  Created by Thiviyan Saravanamuthu on 14.10.20.
//

#ifndef ManageWordList_hpp
#define ManageWordList_hpp

#include <iostream>
#include <vector>
#include <fstream>


class Manage
{
public:
    void WriteToList(char *NameofPart,char *Language,char *SecondLanguage);
    void ReadList(char *Language, char *SecondLanguage);
    
   
    
    std::fstream FileStream;
    
private:
    
    std::string Write;
    
    
};



#endif /* ManageWordList_hpp */
