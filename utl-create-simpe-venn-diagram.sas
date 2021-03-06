Create simple three part venn diagam

Not as obvious as you might think

https://github.com/rogerjdeangelis/utl-create-simpe-venn-diagram
https://github.com/rogerjdeangelis/utl-macros-used-in-many-of-rogerjdeangelis-repositories

 _                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|

CLASSA total obs=5

Obs     NAME      SEX    AGE    HEIGHT    WEIGHT

 1     Classa1     M      14     69.0      112.5
 2     Classa2     F      13     56.5       84.0
 3     Classa3     F      13     65.3       98.0
 4     Carol       F      14     62.8      102.5
 5     Henry       M      14     63.5      102.5

CLASSB total obs=5

Obs     NAME      SEX    AGE    HEIGHT    WEIGHT

 1     Classb1     M      14     69.0      112.5
 2     Classb2     F      13     56.5       84.0
 3     Barbara     F      13     65.3       98.0
 4     Carol       F      14     62.8      102.5
 5     Henry       M      14     63.5      102.5

 _ __  _ __ ___   ___ ___  ___ ___
| `_ \| `__/ _ \ / __/ _ \/ __/ __|
| |_) | | | (_) | (_|  __/\__ \__ \
| .__/|_|  \___/ \___\___||___/___/
|_|

* macro is below and in macro library;

%utlvenn
 (
    uinmema = work.classa
   ,uinmemb = work.classb
   ,uvara   = name
   ,uvarb   = name
);

First of all note that CLASSA and CLASSB Have 2 Obsevations in common


CLASSA total obs=5

Obs     NAME      SEX    AGE    HEIGHT    WEIGHT

 4     Carol       F      14     62.8      102.5
 5     Henry       M      14     63.5      102.5


CLASSB total obs=5

Obs     NAME      SEX    AGE    HEIGHT    WEIGHT

 4     Carol       F      14     62.8      102.5
 5     Henry       M      14     63.5      102.5


* Now notice that CLASSA has 3 observarions that arre not in CLASSB

CLASSA total obs=5

Obs     NAME      SEX    AGE    HEIGHT    WEIGHT

 1     Classa1     M      14     69.0      112.5
 2     Classa2     F      13     56.5       84.0
 3     Classa3     F      13     65.3       98.0


* Likewise CLASSB has 3 obervations not in CLASSA

CLASSB total obs=5

Obs     NAME      SEX    AGE    HEIGHT    WEIGHT

 1     Classb1     M      14     69.0      112.5
 2     Classb2     F      13     56.5       84.0
 3     Barbara     F      13     65.3       98.0


/*           _               _
  ___  _   _| |_ _ __  _   _| |_
 / _ \| | | | __| `_ \| | | | __|
| (_) | |_| | |_| |_) | |_| | |_
 \___/ \__,_|\__| .__/ \__,_|\__|
                |_|

        Set A is WORK.CLASSA  Element=NAME
        Set B is WORK.CLASSB  Element=NAME

                   A Union B
                        10   Obs
                         8   Distinct

                CLASSA         CLASSB
                   5              5
                   5              5

             *8888888888*     *88888888*
            8            8   8          8
           8              8 8            8
          8                8              8
         8               8  8              8
        8              8     8              8
       8              8       8              8
      8              8         8              8
     8              8           8              8
    8              8             8              8
    8              8             8              8
    8    3               2                3     8
    8              8             8              8
    8              8             8              8
    8              8             8              8
     8              8           8              8
      8              8         8              8
       8              8       8              8
        8              8     8              8
         8              8   8              8
          8              8 8              8
           8              8              8
            8            8 8            8
             *8888888888*   *8888888888*

 _ __ ___   __ _  ___ _ __ ___
| `_ ` _ \ / _` |/ __| `__/ _ \
| | | | | | (_| | (__| | | (_) |
|_| |_| |_|\__,_|\___|_|  \___/

*/

%macro utlvenn                                                                        
     (                                                                                
      uinmema=sashelp.class                                                           
     ,uinmemb=sashelp.classfit                                                        
     ,uvara  =name                                                                    
     ,uvarb  =name                                                                    
     ) / des = "Venn diagram for two tables";                                         
                                                                                      
  %let uinmem1 = %upcase( &uinmema);                                                  
  %let uinmem2 = %upcase( &uinmemb);                                                  
                                                                                      
  %let uinmema = %upcase( &uinmema);                                                  
  %let uinmemb = %upcase( &uinmemb);                                                  
                                                                                      
  %let uvara   = %upcase( &uvara  );                                                  
  %let uvarb   = %upcase( &uvarb  );                                                  
                                                                                      
  %if %index(&uinmem1,%str(.)) = 0 %then %do;                                         
        %let inliba=WORK;                                                             
  %end;                                                                               
  %else %do;                                                                          
       %let inliba  = %scan(&uinmem1,1,%str(.));                                      
       %let uinmema = %scan(&uinmem1,2,%str(.));                                      
  %end;                                                                               
  %if %index(&uinmem2,%str(.)) = 0 %then %do;                                         
       %let inlibb=WORK;                                                              
  %end;                                                                               
  %else %do;                                                                          
       %let inlibb  = %scan(&uinmem2,1,%str(.));                                      
       %let uinmemb = %scan(&uinmem2,2,%str(.));                                      
  %end;                                                                               
                                                                                      
/*----------------------------------------------*\                                    
|  SQL code to get counts                        |                                    
|                                                |                                    
|   udsta    = distint values is set a           |                                    
|   udstb    = distint values is set b           |                                    
|                                                |                                    
|   unota    = values not in a                   |                                    
|   unotb    = values not in b                   |                                    
|                                                |                                    
|   uaib     = values in intersection            |                                    
|                                                |                                    
\*----------------------------------------------*/                                    
                                                                                      
proc sql noprint;                                                                     
                                                                                      
 select memlabel , nobs                                                               
  into :ulaba , :uina                                                                 
  from dictionary.tables                                                              
  where libname="&inliba" and memname="&uinmema";                                     
                                                                                      
 select memlabel , nobs                                                               
  into :ulabb , :uinb                                                                 
  from dictionary.tables                                                              
  where libname="&inlibb" and memname="&uinmemb";                                     
                                                                                      
                                                                                      
 select count(distinct &uvara) into :udsta                                            
  from &uinmem1;                                                                      
                                                                                      
 select count(distinct &uvarb) into :udstb                                            
  from &uinmem2;                                                                      
                                                                                      
                                                                                      
 select count(distinct &uvara) into :unotb                                            
  from &uinmem1                                                                       
  where &uvara not in                                                                 
   (select &uvarb as &uvara                                                           
    from &uinmem2);                                                                   
                                                                                      
 select count(distinct &uvarb) into :unota                                            
  from &uinmem2                                                                       
  where &uvarb not in                                                                 
   (select &uvara as &uvarb                                                           
    from &uinmem1);                                                                   
                                                                                      
                                                                                      
 select count(distinct &uvara) into :uaib                                             
  from &uinmem1                                                                       
  where &uvara in                                                                     
   (select &uvarb as &uvara                                                           
    from &uinmem2);                                                                   
                                                                                      
quit;                                                                                 
run;                                                                                  
                                                                                      
%let udstab=%eval(&unota + &unotb + &uaib);    /* total distinct*/                    
%let uaub=%eval(&uina + &uinb);                /* a union b     */                    
                                                                                      
%put unota=&=unota;                            /* not in  a     */                    
%put unotb=&=unotb;                            /* not in  b     */                    
%put uaib =&=uaib;                             /* a intersect b */                    
%put uina =&=uina;                             /* in a          */                    
%put uinb =&=uinb;                             /* in b          */                    
                                                                                      
%put uinb=&=udsta ;                            /* distinct in a  */                   
%put uinb=&=udstb ;                            /* distinct in b  */                   
                                                                                      
data _null_;                                                                          
                                                                                      
     uaub=%eval(&uina + &uinb);                                                       
     unota=&unota;                                                                    
     unotb=&unotb;                                                                    
     udsta=&udsta;                                                                    
     udstb=&udstb;                                                                    
     udstab=&udstab;                                                                  
     uaib=&uaib;                                                                      
     uina=&uina;                                                                      
     uinb=&uinb;                                                                      
                                                                                      
 put #02 @10 "Set A is %trim(%left(&uinmem1))  Element=%trim(%left(&uvara))";         
 put #03 @10 "Set B is %trim(%left(&uinmem2))  Element=%trim(%left(&uvarb))";         
 put #05 @26 " A Union B "@;                                                          
 put #06 @22 uaub comma12. @;                                                         
 put #07 @22 udstab comma12.@;                                                        
 put #08 @20 "&uinmema" @35 "&uinmemb"@;                                              
 put #09 @16 uina  comma12. @31 uinb  comma12. @45 "OBS";                             
 put #10 @16 udsta comma12. @31 udstb comma12. @45 "DISTINCTS";                       
 put #12 @3 "                  *8888888888*     *88888888*             "@;            
 put #13 @3 "                 8            8   8          8            "@;            
 put #14 @3 "                8              8 8            8           "@;            
 put #15 @3 "               8                8              8          "@;            
 put #16 @3 "              8               8  8              8         "@;            
 put #17 @3 "             8              8     8              8        "@;            
 put #18 @3 "            8              8       8              8       "@;            
 put #19 @3 "           8              8         8              8      "@;            
 put #20 @3 "          8              8           8              8     "@;            
 put #21 @3 "         8              8             8              8    "@;            
 put #22 @3 "         8              8             8              8    "@;            
 put #23 @3 "         8              8             8              8    "@;            
 put #23 @06 unotb comma12.  @22 uaib comma12. @39 unota comma12. @;                  
 put #23 @3 "         8"@;                                                            
 put #24 @3 "         8              8             8              8    "@;            
 put #25 @3 "         8              8             8              8    "@;            
 put #26 @3 "         8              8             8              8    "@;            
 put #27 @3 "          8              8           8              8     "@;            
 put #28 @3 "           8              8         8              8      "@;            
 put #29 @3 "            8              8       8              8       "@;            
 put #30 @3 "             8              8     8              8        "@;            
 put #31 @3 "              8              8   8              8         "@;            
 put #32 @3 "               8              8 8              8          "@;            
 put #33 @3 "                8              8              8           "@;            
 put #34 @3 "                 8            8 8            8            "@;            
 put #35 @3 "                  *8888888888*   *8888888888*             "@;            
 put #36 @3 "                                                          "@;            
 put #37 @3 "                                                         ???? "@;          
 put #38 @3 "                                                          ????"@;          
                                                                                      
stop;                                                                                 
run;                                                                                  
                                                                                      
%mend utlvenn;                                                                        
                                                                                      
* test data;                                                                          
data classa;                                                                          
  set sashelp.class(obs=5);                                                           
  if _n_ le 3  then name=cats('Classa',_n_);                                          
run;quit;                                                                             
                                                                                      
data classb;                                                                          
  set sashelp.class(obs=5);                                                           
  if _n_ le 2  then name=cats('Classb',_n_);                                          
run;quit;                                                                             
                                                                                      
                                                                                      
%utlvenn                                                                              
 (                                                                                    
    uinmema = work.classa                                                             
   ,uinmemb = work.classb                                                             
   ,uvara   = name                                                                    
   ,uvarb   = name                                                                    
);                                                                                    
                                                                                      
%utlvenn                                                                              
 (                                                                                    
    uinmema = sashelp.prdsale                                                         
   ,uinmemb = sashelp.prdsal2                                                         
   ,uvara   = product                                                                 
   ,uvarb   = product                                                                 
);                                                                                    
                                                                                      
/*              _                                                                     
  ___ _ __   __| |                                                                    
 / _ \ `_ \ / _` |                                                                    
|  __/ | | | (_| |                                                                    
 \___|_| |_|\__,_|                                                                    

                                                              
                                                                                           
