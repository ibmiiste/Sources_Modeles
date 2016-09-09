000100131127     H DEBUG DECEDIT('0,') DATEDIT(*DMY.)
000101131127     F*****************************************************
000102131127     F*                                                   *
000103131127     F* Liste outq                                        *
000104131127     F*                                                   *
000105131127     F*****************************************************
000106131127     FPGMF30FM  CF   E             WORKSTN
000107131127     F                                     SFILE(SFL01 :WRAN01)
000108131127     F                                     INFDS(DSSFL1)
000109131127     FFIO01L    IF A E           K DISK
000110131127     F                                     INFDS(WDSFIC)
000111131127     FFIO00P    UF   E             DISK
000112131127     F                                     RENAME(FIOF      :FIOFP)
000113131127     DWTXT1            C                   'DSPOBJD OBJ('
000114131127     DWTXT2            C                   ') OBJTYPE(*USRPRF) OUTPUT(*PRINT)'
000115131127     DWTXT3            C                   ') OBJTYPE(*OUTQ) OUTPUT(*PRINT)'
000116131127     DW14              S             14  0
000117131127     DWDAT             S              8
000118131127     DWHEU             S              6
000119131127     DWCMD             S            256
000120131127     DWLNG             S             15  5
000121131127     DPNREC            S             10
000122131127     DW10              S             10
000123131127     DWSUSR            S             10
000124131127     DWSDOC            S             10
000125131127     DWSPRT            S             10
000126131127     DDSPROG          SDS
000127131127     DWNPROG                   1     10
000128131127     DWSTATP                  11     15  0
000129131127     DWSTAPR                  16     20  0
000130131127     DWSQSRC                  21     28
000131131127     DWSBROU                  29     36
000132131127     DWNPARM                  37     39  0
000133131127     DWTYEXC                  40     42
000134131127     DWNMSGM                  40     46
000135131127     DWNMEXC                  43     46
000136131127     DWINSMC                  47     50
000137131127     DWZOMSG                  51     80
000138131127     DWLBPGM                  81     90
000139131127     DWSFDTA                  91    170
000140131127     DWCDERR                 171    174
000141131127     DWLSFIL                 201    208
000142131127     DWLSINF                 209    243
000143131127     DWJOB                   244    253
000144131127     DWUSER                  254    263
000145131127     DWNJOB                  264    269  0
000146131127     DDSSFL1           DS
000147131127     DWPOSC                  370    371B 0
000148131127     DWRRNG                  376    377B 0
000149131127     DWRNGP                  378    379B 0
000150131127     DWNBRSF                 380    381B 0
000151131127     DWNLIGF                 382    383B 0
000152131127     DWNRCME                 403    404B 0
000153131127     DWDSFIC           DS
000154131127     DWCDFIL                   1      8
000155131127     DWOPENF                   9      9
000156131127     DWSTSFI                  11     15  0
000157131127     DWOPCOD                  16     21
000158131127     DWRPGSQ                  30     37
000159131127     DWRPGNR                  38     45
000160131127     DWERRFI                  46     52
000161131127     DWNFICH                  83     92
000162131127     DWNLIBR                  93    102
000163131127     DWSPNAM                 103    112
000164131127     DWSPLIB                 113    122
000165131127     DWSPNUM                 123    124B 0
000166131127     DWLIMBR                 129    138
000167131127     DWNBPUT                 243    246B 0
000168131127     DWNBGET                 247    250B 0
000169131127     DWNBPG                  251    254B 0
000170131127     DWNBIO                  255    258B 0
000171131127     DWRCDFT                 261    270
000172131127     DWNBRCD                 283    286B 0
000173131127     DWNRCFI                 397    400B 0
000174131127     C     SKEY01        KLIST
000175131127     C                   KFLD                    FOUSR
000176131127     C     KEY001        KLIST
000177131127     C                   KFLD                    ZMUSR
000178131127     C                   KFLD                    ZMDOC
000179131127     C                   KFLD                    ZMPRT
000180131127     C                   Z-ADD     14            NBLIS1            4 0
000181131127     C                   MOVEL     '*   '        WPGMQ
000182131127     C                   MOVEL     'CC01'        WMGKEY
000183131127     C* Programme Liste des Outq
000184131127     C* initialisations générales
000185131127     C                   Z-ADD     256           WLNG
000186131127     C                   MOVEL     WNPROG        ZPGM
000187131127     C                   EXSR      DATHEU
000188131127     C                   MOVE      WDAT          ZDATE
000189131127     C                   MOVE      WHEU          ZHEUR
000190131127     C                   MOVEL     WUSER         ZUSER
000191131127     C                   MOVEL     WJOB          ZJOB
000192131127     C                   SETON                                        091050
000193131127     C* Debut du traitement,
000194131127     C                   EXSR      INITSF
000195131127     C* Boucle d'attente de sortie
000196131127     C                   DOW       *IN50 = '1'
000197131127     C                   EXSR      TRTSFL
000198131127     C                   END
000199131127     C                   SETON                                        LR
000200131127     C* traitement ecran
000201131127     C     TRTSFL        BEGSR
000202131127     C********************************
000203131127     C                   MOVEL     '3'           PTYP
000204131127     C                   MOVEL     *BLANK        PFIM
000205131127     C                   MOVEL     *BLANK        PMID
000206131127     C                   CALL      'PGM001CL'
000207131127     C                   PARM                    PTYP              1
000208131127     C                   PARM                    PFIM             10
000209131127     C                   PARM                    PMID              7
000210131127     C                   PARM                    PMDT             99
000211131127     C* mise à blanc du sous fichier de messages
000212131127     C                   WRITE     WSFCTL
000213131127     C                   SETON                                        0405
000214131127     C* ecriture de l'écran
000215131127     C                   WRITE     FORE1                                  70
000216131127     C                   WRITE     FORB1
000217131127     C* attente lecture
000218131127     C                   READ      FORE1
000219131127     C* chargement de l'heure
000220131127     C                   EXSR      DATHEU
000221131127     C                   MOVE      WDAT          ZDATE
000222131127     C                   MOVE      WHEU          ZHEUR
000223131127     C                   SETON                                          5185
000224131127     C                   IF        WSUSR <> ZSUSR OR
000225131127     C                             WSDOC <> ZSDOC OR
000226131127     C                             WSPRT <> ZSPRT
000227131127     C                   EXSR      INITSF
000228131127     C                   SETOFF                                         51
000229131127     C                   END
000230131127     C* touches F3 et F12
000231131127     C   51              IF        *INKC = '1' OR
000232131127     C                             *INKL = '1'
000233131127     C* on met l'indicateur à Off
000234131127     C                   SETOFF                                       5051
000235131127     C                   END
000236131127     C* la suite n'est exécutée que si indicateur 51 = '1'
000237131127     C   51              IF        *IN02 = '1'
000238131127     C* page suivante
000239131127     C                   EXSR      CHGPAG
000240131127     C                   SETOFF                                       51
000241131127     C                   END
000242131127     C*
000243131127     C   51              IF        *INKF = '1'
000244131127     C* fonction création
000245131127     C     LSTLIG        ADD       1             LSTLIG
000246131127     C                   Z-ADD     LSTLIG        WRAN01
000247131127     C                   MOVEL     *BLANK        ZMUSR
000248131127     C                   MOVEL     *BLANK        ZMPRT
000249131127     C                   MOVEL     *BLANK        ZMDOC
000250131127     C* on rajoute une ligne à saisir dans le sous fichier
000251131127     C                   WRITE     SFL01
000252131127     C*                  SETON
000253131127     C                   SETOFF                                       51
000254131127     C                   ENDIF
000255131127     C   51              IF        *INKP = '1'
000256131127     C* ménage profils et outq inconnus
000257131127     C                   Z-ADD     0             HNREC
000258131127     C                   READ      FIOFP                                9070
000259131127     C                   DOW       *IN70 = '0'
000260131127     C                   EVAL      W10 = FOUSR
000261131127     C                   SETOFF                                         86
000262131127     C                   EXSR      EXECMD
000263131127     C                   IF        *IN90 = '1'
000264131127     C                   DELETE    FIOFP
000265131127     C                   SETON                                        85
000266131127     C                   ELSE
000267131127     C                   EVAL      W10 = FOOUQ
000268131127     C                   SETON                                          86
000269131127     C                   SETON                                        85
000270131127     C                   EXSR      EXECMD
000271131127     C                   IF        *IN90 = '1'
000272131127     C                   DELETE    FIOFP
000273131127     C                   SETON                                        85
000274131127     C                   END
000275131127     C                   END
000276131127     C                   READ      FIOFP                                9070
000277131127     C                   ENDDO
000278131127     C                   END
000279131127     C* vérification saisie/choix
000280131127     C   51              EXSR      CTLDTA
000281131127     C* en cas de modification on rafraichit l'écran
000282131127     C   85              EXSR      INITSF
000283131127     C* on recommence la boucle d'attente
000284131127     C                   ENDSR
000285131127     C* initialisation du sous fichier
000286131127     C     INITSF        BEGSR
000287131127     C                   eval      WSUSR = ZSUSR
000288131127     C                   eval      WSDOC = ZSDOC
000289131127     C                   eval      WSPRT = ZSPRT
000290131127     C* La dernière ligne écrite
000291131127     C                   Z-ADD     0             LSTLIG            4 0
000292131127     C* Le compteur de ligne par page
000293131127     C                   Z-ADD     0             NBRLIG            4 0
000294131127     C* Le fameux WRAN01
000295131127     C                   Z-ADD     0             WRAN01            4 0
000296131127     C* Effacement du sous=fichier
000297131127     C                   SETON                                        0607
000298131127     C                   SETOFF                                       0405
000299131127     C                   WRITE     FORE1
000300131127     C                   SETOFF                                       06
000301131127     C                   SETON                                        0405
000302131127     C* Positionnement en début de fichier
000303131127     C                   MOVEL     *LOVAL        FOUSR
000304131127     C     SKEY01        SETLL     FIOF
000305131127     C* Chargement de la première page
000306131127     C                   EXSR      CHGPAG
000307131127     C                   ENDSR
000308131127     C* vérification des données
000309131127     C     CTLDTA        BEGSR
000310131127     C********************
000311131127     C* lecture des enregistrements modifiés
000312131127     C                   Z-ADD     1             WRAN01
000313131127     C* Top pour rafraichir l'écran, si besoin
000314131127     C                   SETOFF                                       86
000315131127     C  N70              READC     SFL01
000316131127     C* boucle de lecture
000317131127     C     *IN70         DOWEQ     '0'
000318131127     C                   MOVEL     '1'           *IN85
000319131127     C* si les trois champs sont remis à blank = suppression
000320131127     C                   IF        ZMUSR = *BLANK AND
000321131127     C                             ZMPRT = *BLANK AND
000322131127     C                             ZMDOC = *BLANK
000323131127     C     HNREC         CHAIN     FIOFP                              70
000324131127     C                   IF        *IN71  = '0'
000325131127     C                   DELETE    FIOFP
000326131127     C                   END
000327131127     C                   ELSE
000328131128     C     KEY001        CHAIN     FIOF                               71
000329131128     C                   IF        *IN71 = '0'
000330131127     C* pas bon du tout
000331131127     C                   MOVEL     '0'           *IN85
000332131127     C                   ELSE
000333131127     C* le user doit exister
000334131127     C                   EVAL      W10 = ZMUSR
000335131127     C                   EXSR      EXECMD
000336131127     C                   IF        *IN90 = '1'
000337131127     C                   MOVEL     '0'           *IN85
000338131127     C                   MOVEL     'MSG0005'     WMGID            10
000339131127     C                   END
000340131127     C* et la outq aussi
000341131127     C                   IF        *IN85 = '1'
000342131127     C                   EVAL      W10  =  ZMPRT
000343131127     C                   SETON                                        86
000344131127     C                   EXSR      EXECMD
000345131127     C                   IF        *IN90 = '1'
000346131127     C                   MOVEL     '0'           *IN85
000347131127     C                   MOVEL     'MSG0006'     WMGID            10
000348131127     C                   END
000349131127     C                   END
000350131127     C                   END
000351131127     C* si c'est ok
000352131127     C                   IF        *IN85 = '1'
000353131127     C                   MOVEL     ZMUSR         FOUSR
000354131127     C                   MOVEL     ZMDOC         FODOC
000355131127     C                   MOVEL     ZMPRT         FOOUQ
000356131127     C                   WRITE     FIOF
000357131127     C                   ELSE
000358131127     C* message d'erreur
000359131127     C                   END
000360131127     C                   END
000361131127     C* mise à jour du sous fichier
000362131127     C                   UPDATE    SFL01
000363131127     C* lecture du suivant
000364131127     C                   READC     SFL01
000365131127     C                   END
000366131127     C                   ENDSR
000367131127     C**********************************
000368131127     C     CHGPAG        BEGSR
000369131127     C*  chargement de la page
000370131127     C                   SETOFF                                       08
000371131127     C*                  SETON                                        04
000372131127     C                   Z-ADD     LSTLIG        WRAN01
000373131127     C                   READ      FIOF
000374131127     C                   Z-ADD     0             NBRLIG            4 0
000375131127     C*
000376131127     C     *IN70         DOWEQ     '0'
000377131127     C     NBRLIG        ANDLT     14
000378131127     C* remplissage des zones écran
000379131127     C                   SETON                                        86
000380131127     C                   IF        ( FOUSR = ZSUSR OR
000381131127     C                             ZSUSR = *BLANK) AND
000382131127     C                             ( FODOC = ZSDOC OR
000383131127     C                             ZSDOC = *BLANK) AND
000384131127     C                             ( FOOUQ = ZSPRT OR
000385131127     C                             ZSPRT = *BLANK)
000386131127     C* On recherche la stricte égalité
000387131127     C                   MOVEL     FOUSR         ZMUSR
000388131127     C                   MOVEL     FODOC         ZMDOC
000389131127     C                   MOVEL     FOOUQ         ZMPRT
000390131127     C                   Z-ADD     WNRCFI        HNREC
000391131127     C                   ADD       1             NBRLIG
000392131127     C                   ADD       1             WRAN01
000393131127     C                   ADD       1             LSTLIG            4 0
000394131127     C                   WRITE     SFL01
000395131127     C                   END
000396131127     C* lecture du suivant
000397131127     C                   READ      FIOF
000398131127     C                   END
000399131127     C* on quitte la boucle soit en fin de page
000400131127     C*                     soit en fin de fichier
000401131127     C     *IN70         IFEQ      '1'
000402131127     C* le caractère de suite
000403131127     C                   SETON                                        07
000404131127     C                   END
000405131127     C* si le fichier est vide
000406131127     C     WRAN01        IFEQ      0
000407131127     C                   Z-ADD     1             NBRLIG
000408131127     C                   Z-ADD     1             LSTLIG            4 0
000409131127     C* un petit message
000410131127     C                   Z-ADD     1             WRAN01
000411131127     C* pas de saisie d'option
000412131127     C                   SETON                                        20
000413131127     C                   eval      ZMDOC = 'vide      '
000414131127     C                   IF        ZMUSR = *BLANK AND ZMDOC = *BLANK AND
000415131127     C                             ZMPRT = *BLANK
000416131127     C                   eval      ZMUSR = 'Fichier   '
000417131127     C                   ELSE
000418131127     C                   eval      ZMUSR = 'Sélection '
000419131127     C                   END
000420131127     C                   MOVEL     *BLANK        ZMPRT
000421131127     C                   MOVEL     *BLANK        WDSFIC
000422131127     C                   Z-ADD     0             HNREC
000423131127     C                   WRITE     SFL01
000424131127     C                   END
000425131127     C* le WRAN01 à 1 pour afficher le premier enregistrement
000426131127     C                   Z-ADD     1             WRAN01
000427131127     C                   ENDSR
000428131127     C* execution de commande, puisqu'on le fait plusieurs fois
000429131127     C     EXECMD        BEGSR
000430131127     C* On nettoie la variable
000431131127     C                   MOVEL     *BLANK        WCMD
000432131127     C* ça on le fait dans les deux cas
000433131127     C                   EVAL      WCMD = WTXT1+ W10
000434131127     C* selon le cas on teste user ou outq
000435131127     C                   IF        *IN86 = '0'
000436131127     C                   EVAL      WCMD = %TRIMR(WCMD) +  WTXT2
000437131127     C                   ELSE
000438131127     C                   EVAL      WCMD = %TRIMR(WCMD) +  WTXT3
000439131127     C                   END
000440131127     C* execution commande, WLNG = longueur de WCMD (init au début)
000441131127     C                   CALL      'QCMDEXC'
000442131127     C                   PARM                    WCMD
000443131127     C                   PARM                    WLNG
000444131127     C                   ENDSR
000445131127     C* procédure pour la date
000446131127     C     DATHEU        BEGSR
000447131127     C                   TIME                    W14
000448131127     C                   MOVE      W14           WDAT
000449131127     C                   MOVEL     W14           WHEU
000450131127     C                   ENDSR
