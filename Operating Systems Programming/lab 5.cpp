#include <cstdlib>
#include <cstring>
#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include <string>
#include <sys/types.h>
#include <unistd.h>

using namespace std;

int fChild[2], fParent[2];
string* childMsg = new string;
string* parentMsg = new string;
string* tempStr = new string("message from parent to child");
string* tempStr2 = new string("message from child to parent");
pid_t pid;

int main() {
	if(pipe(fChild)<0||pipe(fParent)<0){
		exit(1);
	}
	if((pid=fork())>0){
		close(fParent[0]);
		write(fParent[1], tempStr, 29);
		close(fChild[0]);
		cout << "The message read from the child is: " << *parentMsg << endl;
	}
	else{
		close(fParent[1]);
		read(fParent[0], childMsg, 29);
		close(fParent[0]);
		cout << "The message read from the parent is: " << *childMsg << endl;

		close(fChild[0]);
		write(fChild[1], tempStr2, 29);
		close(fChild[1]);
	     }

}