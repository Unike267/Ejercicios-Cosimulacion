#include <stdio.h>

//Function one for input state values

int in_value_state (int x){
    if(x==1){
    return 0;    
    }
    if(x==2){
    return 0;    
    }
    if(x==3){
    return 0;    
    }
    if(x==4){
    return 0;    
    }
    if(x==5){
    return 1;    
    }
    if(x==6){
    return 1;    
    }
    if(x==7){
    return 1;    
    }
    if(x==8){
    return 1;    
    }
    if(x==9){
    return 2;    
    }
    if(x==10){
    return 2;    
    }
    if(x==11){
    return 2;    
    }
    if(x==12){
    return 2;    
    }
    if(x==13){
    return 3;    
    }
    if(x==14){
    return 3;    
    }
    if(x==15){
    return 3;    
    }
    if(x==16){
    return 3;    
    }
    if(x==17){
    return 4;    
    }
    if(x==18){
    return 4;    
    }
    if(x==19){
    return 4;    
    }
    if(x==20){
    return 4;    
    }
    if(x==21){
    return 5;    
    }
    if(x==22){
    return 5;    
    }
    if(x==23){
    return 5;    
    }
    if(x==24){
    return 5;    
    }
    if(x==25){
    return 6;    
    }
    if(x==26){
    return 6;    
    }
    if(x==27){
    return 6;    
    }
    if(x==28){
    return 6;    
    }
    if(x==29){
    return 7;    
    }
    if(x==30){
    return 7;    
    }
    if(x==31){
    return 7;    
    }
    if(x==32){
    return 7;    
    }
}

//Function two for input flag values

int in_value_flag (int x){
    if(x==1){
    return 0;    
    }
    if(x==2){
    return 1;    
    }
    if(x==3){
    return 2;    
    }
    if(x==4){
    return 3;    
    }
    if(x==5){
    return 0;    
    }
    if(x==6){
    return 1;    
    }
    if(x==7){
    return 2;    
    }
    if(x==8){
    return 3;    
    }
    if(x==9){
    return 0;    
    }
    if(x==10){
    return 1;    
    }
    if(x==11){
    return 2;    
    }
    if(x==12){
    return 3;    
    }
    if(x==13){
    return 0;    
    }
    if(x==14){
    return 1;    
    }
    if(x==15){
    return 2;    
    }
    if(x==16){
    return 3;    
    }
    if(x==17){
    return 0;    
    }
    if(x==18){
    return 1;    
    }
    if(x==19){
    return 2;    
    }
    if(x==20){
    return 3;    
    }
    if(x==21){
    return 0;    
    }
    if(x==22){
    return 1;    
    }
    if(x==23){
    return 2;    
    }
    if(x==24){
    return 3;    
    }
    if(x==25){
    return 0;    
    }
    if(x==26){
    return 1;    
    }
    if(x==27){
    return 2;    
    }
    if(x==28){
    return 3;    
    }
    if(x==29){
    return 0;    
    }
    if(x==30){
    return 1;    
    }
    if(x==31){
    return 2;    
    }
    if(x==32){
    return 3;    
    }
}

//Function three for output next state values

int out_value_nstate (int x){
    if(x==1){
    return 0;    
    }
    if(x==2){
    return 1;    
    }
    if(x==3){
    return 0;    
    }
    if(x==4){
    return 1;    
    }
    if(x==5){
    return 2;    
    }
    if(x==6){
    return 2;    
    }
    if(x==7){
    return 2;    
    }
    if(x==8){
    return 2;    
    }
    if(x==9){
    return 3;    
    }
    if(x==10){
    return 3;    
    }
    if(x==11){
    return 3;    
    }
    if(x==12){
    return 3;    
    }
    if(x==13){
    return 4;    
    }
    if(x==14){
    return 4;    
    }
    if(x==15){
    return 4;    
    }
    if(x==16){
    return 4;    
    }
    if(x==17){
    return 5;    
    }
    if(x==18){
    return 5;    
    }
    if(x==19){
    return 5;    
    }
    if(x==20){
    return 5;    
    }
    if(x==21){
    return 5;    
    }
    if(x==22){
    return 5;    
    }
    if(x==23){
    return 1;    
    }
    if(x==24){
    return 1;    
    }
    if(x==25){
    return 0;    
    }
    if(x==26){
    return 0;    
    }
    if(x==27){
    return 0;    
    }
    if(x==28){
    return 0;    
    }
    if(x==29){
    return 0;    
    }
    if(x==30){
    return 0;    
    }
    if(x==31){
    return 0;    
    }
    if(x==32){
    return 0;    
    }
}

//Function four for output enable values

int out_value_en (int x){
    if(x==1){
    return 0;    
    }
    if(x==2){
    return 0;    
    }
    if(x==3){
    return 0;    
    }
    if(x==4){
    return 0;    
    }
    if(x==5){
    return 1;    
    }
    if(x==6){
    return 1;    
    }
    if(x==7){
    return 1;    
    }
    if(x==8){
    return 1;    
    }
    if(x==9){
    return 2;    
    }
    if(x==10){
    return 2;    
    }
    if(x==11){
    return 2;    
    }
    if(x==12){
    return 2;    
    }
    if(x==13){
    return 4;    
    }
    if(x==14){
    return 4;    
    }
    if(x==15){
    return 4;    
    }
    if(x==16){
    return 4;    
    }
    if(x==17){
    return 8;    
    }
    if(x==18){
    return 8;    
    }
    if(x==19){
    return 8;    
    }
    if(x==20){
    return 8;    
    }
    if(x==21){
    return 0;    
    }
    if(x==22){
    return 0;    
    }
    if(x==23){
    return 0;    
    }
    if(x==24){
    return 0;    
    }
    if(x==25){
    return 0;    
    }
    if(x==26){
    return 0;    
    }
    if(x==27){
    return 0;    
    }
    if(x==28){
    return 0;    
    }
    if(x==29){
    return 0;    
    }
    if(x==30){
    return 0;    
    }
    if(x==31){
    return 0;    
    }
    if(x==32){
    return 0;    
    }
}

//Function five for output iteration counter reset values

int out_value_rst_ci (int x){
    if(x==1){
    return 0;    
    }
    if(x==2){
    return 1;    
    }
    if(x==3){
    return 0;    
    }
    if(x==4){
    return 1;    
    }
    if(x==5){
    return 0;    
    }
    if(x==6){
    return 0;    
    }
    if(x==7){
    return 0;    
    }
    if(x==8){
    return 0;    
    }
    if(x==9){
    return 0;    
    }
    if(x==10){
    return 0;    
    }
    if(x==11){
    return 0;    
    }
    if(x==12){
    return 0;    
    }
    if(x==13){
    return 0;    
    }
    if(x==14){
    return 0;    
    }
    if(x==15){
    return 0;    
    }
    if(x==16){
    return 0;    
    }
    if(x==17){
    return 0;    
    }
    if(x==18){
    return 0;    
    }
    if(x==19){
    return 0;    
    }
    if(x==20){
    return 0;    
    }
    if(x==21){
    return 0;    
    }
    if(x==22){
    return 0;    
    }
    if(x==23){
    return 1;    
    }
    if(x==24){
    return 1;    
    }
    if(x==25){
    return 0;    
    }
    if(x==26){
    return 0;    
    }
    if(x==27){
    return 0;    
    }
    if(x==28){
    return 0;    
    }
    if(x==29){
    return 0;    
    }
    if(x==30){
    return 0;    
    }
    if(x==31){
    return 0;    
    }
    if(x==32){
    return 0;    
    }
}
