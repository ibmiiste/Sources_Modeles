000100000000     H dftactgrp(*no) actgrp(*caller) expropts(*resdecpos)
000200000000     H datfmt(*iso) timfmt(*iso) option(*nodebugio: *nounref)
000300131127     H debug decedit('0,') datedit(*dmy.)
000400150710      //****************************************************
000500150710      //                                                   *
000600150710      // Détail personnel                                  *
000700150710      //                                                   *
000800150710      //****************************************************
000900131127     Fpgmf02fm  cf   e             workstn
001000131127     F                                     infds(wdsecr)
001100131127     Ffic00p    uf   e             disk
001200131127     Ffic01l    uf a e           k disk
001300131127     F                                     rename(ficf      :ficf1)
001400131127     Ffif01l    if   e           k disk
001500000000
001600000000   ?  //--*STAND ALONE-------------------------------------------
001700150710     D l_cod           s              3a
001800150710     D l_cpt           s              1a
001900150710     D l_cp1           s              6a
002000150710     D l_ficm          s             10a
002100150710     D l_mat           s             10a
002200150710     D l_mgdt          s             99a
002300150710     D l_mgid          s              7a
002400150710     D l_typ           s              1a
002500000000
002600150710     Dc_txt1           c                   '         Modification         '
002700150710     Dc_txt2           c                   '             Copie            '
002800150710     Dc_txt3           c                   '         Suppression          '
002900150710     Dc_txt4           c                   '           Affichage          '
003000150710     Dc_txt5           c                   '           Création           '
003100150710     Dc_txt6           c                   '        Fin de contrat        '
003200131127     Dwdat             s              8
003300131127     Dwheu             s              6
003400131127     Dw14              s             14  0
003500131127     Dpchx             s              2
003600131127     Dpnrec            s             10
003700131127     Dwnrec            s             10  0
003800131127     Dpact             s              2
003900131127     Dpgfct            s              3
004000131127     Dwdi              ds
004100131127     Dwssai                    1      4  0
004200131127     Dwmi                      5      6  0
004300131127     Dwji                      7      8  0
004400131127     Dwdati                    1      8  0
004500131127     Dwde              ds
004600131127     Dwje                      1      2  0
004700131127     Dwme                      3      4  0
004800131127     Dwssae                    5      8  0
004900131127     Dwdate                    1      8  0
005000131127     Dwdspgm          sds
005100131127     Dwnmpgm                   1     10
005200131127     Dwstatu                  11     15  0
005300131127     Dwstpre                  16     20  0
005400131127     Dwsrcsq                  21     28
005500131127     Dwnmrou                  29     36
005600131127     Dwnbpar                  37     39  0
005700131127     Dwtyexc                  40     42
005800131127     Dwlicpf                  40     46
005900131127     Dwnuexc                  43     46
006000131127     Dwmiodt                  47     50
006100131127     Dwzomes                  51     80
006200131127     Dwbipgm                  81     90
006300131127     Dwrtdta                  91    170
006400131127     Dwcoerr                 171    174
006500131127     Dwderfi                 201    208
006600131127     Dwfiinf                 209    243
006700131127     Dwjob                   244    253
006800131127     Dwuser                  254    263
006900131127     Dwjobnm                 264    269  0
007000131127     Dwdsecr           ds
007100131127     Dwnlig                  370    371b 0
007200131127     Dwranp                  378    379b 0
007300131127     Dwnbrs                  380    381b 0
007400131127     Dwnulc                  382    383b 0
007500131127     Dwrecmi                 403    404b 0
007600131127     C     *entry        plist
007700150721     C                   PARM                    pchx              2
007800150721     C                   PARM                    pnrec            10 0
007900131127     C     key001        klist
008000131127     C                   kfld                    zmatr
008100131127     C     key002        klist
008200131127     C                   kfld                    zfcod
008300150710      // début du programme
008400131127     C                   movel     wnmpgm        zpgm
008401150710      /FREE
008500150710       exsr datheu;
008501150710      /END-FREE
008600131127     C                   move      wdat          zdate
008700131127     C                   move      wheu          zheur
008800131127     C                   movel     wuser         zuser
008900131127     C                   movel     wjob          zjob
009000131127     C                   movel     '*  '         wpgmq
009100131127     C                   movel     'CC01'        wmgkey
009101150710      /FREE
009200150710       *IN09 = *ON;
009201150710       *IN10 = *ON;
009300150710       *IN14 = *ON;
009301150710       *IN15 = *ON;
009302150710       *IN16 = *ON;
009400150710       *IN17 = *ON;
009401150710       *IN18 = *ON;
009500150710       *IN85 = *OFF;
009501150710       *IN88 = *OFF;
009600150710       // constantes pour ce programme
009601150710      /END-FREE
009700131127     C                   move      '1'           ptyp
009800131127     C                   movel     'FICMSG    '  pficm
009801150710      /FREE
009900150710 1b    select;
010000150710 1x    when (pchx = 'MO');
010100150710         // modification
010101150710      /END-FREE
010200131127     C                   movel     wtxt1         zmode
010300150710      // on ne peut modifier que ces zones
010301150710      /FREE
010400150710         *IN14 = *OFF;
010401150710         *IN15 = *OFF;
010402150710         *IN16 = *OFF;
010500150710 1x    when (pchx = 'CO');
010600150710         // copie
010601150710      /END-FREE
010700131127     C                   movel     wtxt2         zmode
010800150710      // toutes les zones sont autorisées
010801150710      /FREE
010900150710         *IN14 = *OFF;
010901150710         *IN15 = *OFF;
010902150710         *IN16 = *OFF;
011000150710         *IN17 = *OFF;
011001150710         *IN18 = *OFF;
011100150710 1x    when (pchx = 'SU');
011200150710         // suppression
011201150710      /END-FREE
011300131127     C                   movel     wtxt3         zmode
011400150710      // aucune zone n'est saisisable
011401150710      /FREE
011500150710 1x    when (pchx = 'AF');
011600150710         // affichage
011601150710      /END-FREE
011700131127     C                   movel     wtxt4         zmode
011800150710      // aucune zone n'est saisisable
011801150710      /FREE
011900150710 1x    when (pchx = 'CR');
012000150710         // création
012001150710      /END-FREE
012100131127     C                   movel     wtxt5         zmode
012200150710      // tout est saisisable sauf date de sortie
012201150710      /FREE
012300150710         *IN14 = *OFF;
012301150710         *IN15 = *OFF;
012302150710         *IN16 = *OFF;
012400150710         *in17 = *off;
012500150710 1x    when (pchx = 'PE');
012600150710         // direction P le Emploi
012601150710      /END-FREE
012700131127     C                   movel     wtxt6         zmode
012800150710      // on saisit simplement la date de fin
012801150710      /FREE
012900150710         *in18 = *off;
013000150710 1e    endsl;
013100150710       // Initialisation de l'écran si on un numéro d'enregistrement
013200150721 1b    if pnrec <> *zero
013201150710      /END-FREE
013300150721     C                   eval      wnrec=pnrec
013301150710      /FREE
013400150710         chain(nE) wnrec ficf;
013401150710         *IN70 = NOT %ERROR AND NOT %FOUND;
013402150710         *IN90 = %ERROR;
013500150710 2b      if pchx = 'CR' or pchx = 'CO';
013600150710           // en création ou copie zone non renseignée
013601150710      /END-FREE
013700131127     C                   z-add     0             zmatr
013701150710      /FREE
013800150710 2x      else;
013801150710      /END-FREE
013900131127     C                   z-add     fimat         zmatr
013901150710      /FREE
014000150710 2e      endif;
014001150710      /END-FREE
014100131127     C                   movel     fifon         zfcod
014200150710      // fichier des fonctions => libellé
014201150710      /FREE
014300150710         chain(E) key002 fiff;
014301150710         *IN70 = NOT %ERROR AND NOT %FOUND;
014302150710         *IN90 = %ERROR;
014303150710      /END-FREE
014400131127     C                   movel     milib         zflib
014500131127     C                   movel     finom         znom
014600131127     C                   movel     fipr1         zpr1
014700131127     C                   movel     fipr2         zpr2
014800131127     C                   movel     fiad1         zad1
014900131127     C                   movel     fiad2         zad2
015000131127     C                   movel     fiad3         zad3
015100131127     C                   movel     ficpo         zcpo
015200131127     C                   movel     fivil         zvil
015300131127     C                   movel     fitel         ztel
015400131127     C                   movel     fipor         zpor
015500150710      // traitement des dates
015600131127     C                   z-add     fidae         wdati
015601150710      /FREE
015700150710         exsr invdat;
015701150710      /END-FREE
015800131127     C                   z-add     wdate         zdae
015801150710      /FREE
015900150710 2b      if pchx = 'PE';
015901150710      /END-FREE
016000131127     C                   z-add     zdate         zdas
016001150710      /FREE
016100150710 2x      else;
016101150710      /END-FREE
016200131127     C                   z-add     fidas         wdati
016201150710      /FREE
016300150710           exsr invdat;
016301150710      /END-FREE
016400131127     C                   z-add     wdate         zdas
016401150710      /FREE
016500150710 2e      endif;
016600150710         // zones d'audit
016601150710      /END-FREE
016700131127     C                   z-add     fidac         wdati
016701150710      /FREE
016800150710         exsr invdat;
016801150710      /END-FREE
016900131127     C                   z-add     wdate         zdac
017000131127     C                   z-add     fihec         zhec
017100131127     C                   movel     fiusc         zusc
017200131127     C                   z-add     fidam         wdati
017201150710      /FREE
017300150710         exsr invdat;
017301150710      /END-FREE
017400131127     C                   z-add     wdate         zdam
017500131127     C                   z-add     fihem         zhem
017600131127     C                   movel     fiusm         zusm
017601150710      /FREE
017700150710 1x    else;
017800150710         // pas grand chose, la date du jour
017801150710      /END-FREE
017900131127     C                   move      wdat          zdae
017901150710      /FREE
018000150710 1e    endif;
018100150710       // Boucle d'attente de fin
018200150710       *in50 = *on;
018300150710 1b    dow *in50 = '1';
018400150710         exsr trtscr;
018500150710 1e    enddo;
018600150710       //
018700150710       *inlr = *on;
018800150710       // Les procédures
018900150710       begsr trtscr;
019000150710         write wmgctl;
019100150710         // On écrit l'écran
019200150710         write fore1;
019300150710         // On attend l'appui sur une touche
019400150710         read fore1;
019401150710         *IN70 = %EOF;
019500150710         *in51 = *on;
019600150710         // F3 ou F12 on termine
019700150710 1b      if *inkc = '1' or
019800150710               *inkl = '1';
019900150710           *IN50 = *OFF;
019901150710           *IN51 = *OFF;
020000150710 1e      endif;
020100150710         // on met   jour l'heure
020101150710      /END-FREE
020200131127     C   51              time                    zheur
020300131127 1b  C   51              if        *inkd
020400150710      // appui sur la touche F4
020401150710      /FREE
020500150710 2b        if wzocur = 'ZFCOD';
020600150710             pact = 'GS';
020601150710      /END-FREE
020700131127     C                   call      'PGMI01'
020800131127     C                   parm                    pact
020900131127     C                   parm                    pgfct
020901150710      /FREE
021000150710 3b          if pgfct <> *blank;
021001150710      /END-FREE
021100131127     C                   movel     pgfct         zfcod
021101150710      /FREE
021200150710 3e          endif;
021300150710 2e        endif;
021400150710           *in51 = *off;
021500150710 1e      endif;
021600150710         //
021700150710 1b      if pchx = 'SU';
021800150710           *in51 = *off;
021900150710 2b        if *in85 = '1';
022000150710 3b          if *inkp;
022100150710               // touche F15 on supprime si indicateur *IN85
022200150710               chain(E) wnrec ficf;
022201150710               *IN70 = NOT %ERROR AND NOT %FOUND;
022202150710               *IN90 = %ERROR;
022203150710      /END-FREE
022300131127     C  n70              delete    ficf
022301150710      /FREE
022400150710               *IN50 = *OFF;
022401150710               *IN51 = *OFF;
022500150710 3e          endif;
022600150710 2x        else;
022601150710      /END-FREE
022700131127     C                   movel     'MSG0004'     pmgid
022800131127     C                   movel     *blank        pmgdt
022801150710      /FREE
022900150710             exsr envmsg;
023000150710             *in85 = *on;
023100150710 2e        endif;
023200150710 1e      endif;
023300150710         // contr le des données saisies
023400150710 1b      if *in51 = '1';
023500150710           exsr ctldta;
023600150710 2b        if *in88 = '1';
023700150710             // anomalie
023800150710             exsr envmsg;
023900150710             *in88 = *off;
024000150710 2x        else;
024100150710             // confirmation  pour suppression
024200150710             exsr valid1;
024300150710 2e        endif;
024400150710 1e      endif;
024500150710       endsr;
024600150710       // controle des données/si suppression demande de confirmation
024700150710       begsr ctldta;
024800150710         *in88 = *off;
024900150710         // on vérifie que tout est bon
025000150710 1b      if pchx = 'SU';
025100150710           // on demande confirmation
025200150710 1x      else;
025300150710           // vérification du code fonction
025400150710           chain(E) key002 fiff;
025401150710           *IN70 = NOT %ERROR AND NOT %FOUND;
025402150710           *IN90 = %ERROR;
025500150710 2b        if *in70 = '1';
025600150710             *in88 = *off;
025601150710      /END-FREE
025700131127     C                   movel     'MSG0003'     pmgid
025701150710      /FREE
025800150710             pmgdt = '&1'+ zfcod;
025900150710             *in88 = *on;
026000150710 2e        endif;
026100150710 1e      endif;
026200150710       endsr;
026300150710       //** Création suppression et M J selon le cas
026400150710       begsr valid1;
026500150710 1b      if pchx = 'SU';
026600150710           // La suppression se fait par la touche F15
026700150710 1x      else;
026800150710           chain(E) key001 ficf1;
026801150710           *IN71 = NOT %ERROR AND NOT %FOUND;
026802150710           *IN90 = %ERROR;
026900150710 2b        if pchx = 'CR' or pchx = 'CO';
027000150710             // On ne crée le matricule qu'en copie ou création
027001150710      /END-FREE
027100131127     C                   move      'MAT'         pcod
027101150710      /FREE
027200150710             pcpt = '2';
027201150710      /END-FREE
027300131127     C                   call      'PGMC01'
027400131127     C                   parm                    pcod              3
027500131127     C                   parm                    pcpt              1
027600131127     C                   parm                    pcp1              6
027700131127     C                   parm                    pmat             10
027800131127     C                   move      pmat          fimat
027801150710      /FREE
027900150710             *in71 = *on;
028000150710 2e        endif;
028001150710      /END-FREE
028100131127     C                   movel     zfcod         fifon
028200131127     C                   movel     znom          finom
028300131127     C                   movel     zpr1          fipr1
028400131127     C                   movel     zpr2          fipr2
028500131127     C                   movel     zad1          fiad1
028600131127     C                   movel     zad2          fiad2
028700131127     C                   movel     zad3          fiad3
028800131127     C                   movel     zcpo          ficpo
028900131127     C                   movel     zvil          fivil
029000131127     C                   movel     ztel          fitel
029100131127     C                   movel     zpor          fipor
029200150710      // traitement des dates
029300131127     C                   z-add     zdae          wdate
029301150710      /FREE
029400150710           exsr datinv;
029401150710      /END-FREE
029500131127     C                   z-add     wdati         fidae
029600131127     C                   z-add     zdas          wdate
029601150710      /FREE
029700150710           exsr datinv;
029701150710      /END-FREE
029800131127     C                   z-add     wdati         fidas
029900150710      // zones d'audit
029901150710      /FREE
030000150710           exsr datheu;
030001150710      /END-FREE
030100131127     C                   move      wdat          wdate
030101150710      /FREE
030200150710           exsr datinv;
030201150710      /END-FREE
030300131127     C                   z-add     wdati         fidam
030400131127     C                   move      wheu          fihem
030500131127     C                   movel     wuser         fiusm
030501150710      /FREE
030600150710 2b        if *in71 = '0';
030700150710             // on met   jour directement
030800150710             update ficf1;
030900150710 2x        else;
031000150710             // création
031001150710      /END-FREE
031100131127     C                   z-add     wdati         fidac
031200131127     C                   move      wheu          fihec
031300131127     C                   movel     wuser         fiusc
031301150710      /FREE
031400150710             write ficf1;
031500150710 2e        endif;
031600150710 1e      endif;
031700150710         *in50 = *off;
031800150710       endsr;
031900150710       // Traitements de la date
032000150710       begsr datheu;
032001150710      /END-FREE
032100131127     C                   time                    w14
032200131127     C                   move      w14           wdat
032300131127     C                   movel     w14           wheu
032301150710      /FREE
032400150710       endsr;
032500150710       begsr invdat;
032501150710      /END-FREE
032600131127     C                   z-add     wssai         wssae
032700131127     C                   z-add     wmi           wme
032800131127     C                   z-add     wji           wje
032801150710      /FREE
032900150710       endsr;
033000150710       begsr datinv;
033001150710      /END-FREE
033100131127     C                   z-add     wssae         wssai
033200131127     C                   z-add     wme           wmi
033300131127     C                   z-add     wje           wji
033301150710      /FREE
033400150710       endsr;
033500150710       //****Envoi d'un message programme
033600150710       begsr envmsg;
033601150710      /END-FREE
033700131127     C                   call      'PGM001CL'
033800131127     C                   parm                    ptyp              1
033900131127     C                   parm                    pficm            10
034000131127     C                   parm                    pmgid             7
034100131127     C                   parm                    pmgdt            99
034101150710      /FREE
034200150710       endsr;
034201150710      /END-FREE
