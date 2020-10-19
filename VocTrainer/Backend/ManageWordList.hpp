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
    void WriteToList(std::string NameofPart,std::string Language, std::string SecondLanguage);
    void ReadList(std::string Language, std::string SecondLanguage);
    
private:
    std::string Write;
    
    
};



#endif /* ManageWordList_hpp */
