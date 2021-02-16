open terminal
 =>1 nano ~/.bash_profile 
 //When you are fire this command then you will get one notepad like screen in terminal and then you have to follow below command 
 =>2 paste export PATH=$PATH://Users/iconflux/Documents/Flutter\ SDK/flutter/bin 
           inside it and press ctrl + x and save that file
 =>3 after successfully doing above process
     fire this command in existing window 
     source $HOME/.bash_profile
 =>4 now you can enjoy flutter anywhere in your mac os 
 
When you get non window file path error while building flutter tool then go to the packages/flutter_tool folder directory and fire below

your_pc_path/flutter/bin/flutter
