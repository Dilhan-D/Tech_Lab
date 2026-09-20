**free
// *********************************************************
//                                            
// Créé par : nom
// Le       : ../..../2024
// N° ticket: num(10) - Numéro du ticket
// description
// *********************************************************
ctl-opt dftactgrp(*no) actgrp(*caller) option(*srcstmt:*nodebugio);

//==================================================
// Fichiers
//==================================================
dcl-f 'DisplayFile' workstn indds(ds_ind) sfile(sfl01:rang01);

//==================================================
// Paramètres
//==================================================
dcl-pi *n;
   SelectedValue     char(15);
   ExitWithF3        char(1);
   ExitWithF12       char(1);
end-pi;

//==================================================
// Indicateurs écran
//==================================================
dcl-ds ScreenIndicators len(99);
   IndicatorExitF3        ind pos(03);
   IndicatorExitF12       ind pos(12);
   IndicatorShowSubfile   ind pos(20);
   IndicatorShowControl   ind pos(22);
   IndicatorClearSubfile  ind pos(23);
   IndicatorEndOfList     ind pos(50);
end-ds;

//==================================================
// Variables générales
//==================================================
dcl-s EndProgram          ind inz(*off);
dcl-s SubfileRrn          packed(4:0) inz(0);
dcl-s Rang01        packed(4:0) inz(9999);

//==================================================
// Variables sous-fichier
//==================================================
dcl-s SelectionOption     char(1);
dcl-s ColumnValue1        char(10);
dcl-s ColumnValue2        char(30);
dcl-s ColumnAmount1       packed(9:2);
dcl-s ColumnAmount2       packed(9:2);
dcl-s ColumnAmount3       packed(9:2);

//==================================================
// Variables filtres
//==================================================
dcl-s FilterValue1        char(15) inz(*blanks);
dcl-s FilterValue2        packed(5:0) inz(0);

//==================================================
// SQL
//==================================================
EXEC SQL
  SET OPTION
        NAMING    = *SYS,
        COMMIT    = *NONE,
        USRPRF    = *USER,
        DYNUSRPRF = *USER,
        DATFMT    = *ISO,
        CLOSQLCSR = *ENDMOD;

//==================================================
// Curseur SQL template
//==================================================
exec sql
   declare ResultCursor cursor for
      select
         cast('' as char(10)),
         cast('' as char(30)),
         cast(0 as dec(9,2)),
         cast(0 as dec(9,2)),
         cast(0 as dec(9,2))
        from sysibm/sysdummy1
       for read only;

//==================================================
// Main
//==================================================
initializeScreen();
loadSubfileData();

dow not EndProgram;
   displayScreen();
   if not EndProgram;
      processUserSelection();
   endif;
enddo;

*inlr = *on;
return;

//==================================================
// Préparer l'écran
//==================================================
dcl-proc initializeScreen;

   EndProgram = *off;
   SubfileRrn = 0;
   ExitWithF3 = '0';
   ExitWithF12 = '0';

   IndicatorShowSubfile  = *off;
   IndicatorShowControl  = *on;
   IndicatorClearSubfile = *on;
   IndicatorEndOfList    = *off;

   write ControlFormat;
   IndicatorClearSubfile = *off;

end-proc;

//==================================================
// Charger les données du sous-fichier
//==================================================
dcl-proc loadSubfileData;

   IndicatorClearSubfile = *on;
   write ControlFormat;
   IndicatorClearSubfile = *off;

   SubfileRrn = 0;

   exec sql open ResultCursor;

   exec sql
      fetch ResultCursor
      into
         :ColumnValue1,
         :ColumnValue2,
         :ColumnAmount1,
         :ColumnAmount2,
         :ColumnAmount3;

   dow sqlstate < '02000' and SubfileRrn < MaximumLines;

      SubfileRrn += 1;
      write SubfileRecord;

      exec sql
         fetch ResultCursor into
            :ColumnValue1,
            :ColumnValue2,
            :ColumnAmount1,
            :ColumnAmount2,
            :ColumnAmount3;

   enddo;

   if sqlstate = '02000';
      IndicatorEndOfList = *on;
   else;
      IndicatorEndOfList = *off;
   endif;

   exec sql close ResultCursor;

   if SubfileRrn > 0;
      IndicatorShowSubfile = *on;
   else;
      IndicatorShowSubfile = *off;
   endif;

end-proc;

//==================================================
// Afficher l'écran et gérer les touches
//==================================================
dcl-proc displayScreen;

   exfmt ControlFormat;

   select;
   when IndicatorExitF3;
      ExitWithF3 = '1';
      EndProgram = *on;

   when IndicatorExitF12;
      ExitWithF12 = '1';
      EndProgram = *on;

   other;

   endsl;

end-proc;

//==================================================
// Traiter la sélection utilisateur
//==================================================
dcl-proc processUserSelection;

   readc SubfileRecord;
   dow not %eof(DisplayFile);

      if SelectionOption = '1';
         SelectedValue = %trim(ColumnValue1);
         EndProgram = *on;
      endif;

      clear SelectionOption;
      update SubfileRecord;

      readc SubfileRecord;
   enddo;

end-proc;
