* Program 10.5.4.sas
* Modifying the SASAUTOS environmental variable 
* in the configuration file;

/* Setup the SAS System autocall library definition */
-SET SASAUTOS (
        "f:\GroupProjA\saspgms\macros"
        "!SASROOT\core\sasmacro"
        "!SASROOT\aacomp\sasmacro"
        "!SASROOT\accelmva\sasmacro"
        "!SASROOT\assist\sasmacro"
        "!SASROOT\dmscore\sasmacro"
        "!SASROOT\dquality\sasmacro"
        "!SASROOT\ets\sasmacro"
        "!SASROOT\graph\sasmacro"
        "!SASROOT\hps\sasmacro"
        "!SASROOT\inttech\sasmacro"
        "!SASROOT\or\sasmacro"
        "!SASROOT\qc\sasmacro"
        "!SASROOT\stat\sasmacro"
        )
