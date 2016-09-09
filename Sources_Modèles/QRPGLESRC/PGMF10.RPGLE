000100131128     H DEBUG DECEDIT('0,') DATEDIT(*DMY.)
000101131128     F*****************************************************
000102131128     F*                                                   *
000103131128     F* Liste fonction                                    *
000104131128     F*                                                   *
000105131128     F*****************************************************
000106131128     FPGMF10FM  CF   E             WORKSTN
000107131128     F                                     SFILE(SFL01 :WRAN01)
000108131128     F                                     INFDS(WDSFL1)
000109131128     FFIF01L    IF   E           K DISK
000110131128     F                                     INFDS(WDSFIF)
000111131128     FFIC02L    IF   E           K DISK
000112131128     DW14              S             14  0
000113131128     DWDAT             S              8
000114131128     DWHEU             S              6
000115131128     DPOPT             S              2
000116131128     DW8               S              8
000117131128     DWHS              S               Z
000118131128     DPNREC            S             10
000119131128     DWS               DS
000120131128     DWSA                      1      4
000121131128     DWMA                      6      7
000122131128     DWJA                      9     10
000123131128     DWHA                     12     13
000124131128     DWIA                     15     16
000125131128     DWKA                     18     19
000126131128     DWMU                     21     26
000127131128     DWASTA                    1     26
000128131128     DWDSPGM          SDS
000129131128     DWLIPGM                   1     10
000130131128     DWSTATU                  11     15  0
000131131128     DWSTPRE                  16     20  0
000132131128     DWSRCSQ                  21     28
000133131128     DWNMROU                  29     36
000134131128     DWNBPAR                  37     39  0
000135131128     DWTYEXC                  40     42
000136131128     DWLICPF                  40     46
000137131128     DWNUEXC                  43     46
000138131128     DWMIODT                  47     50
000139131128     DWZOMES                  51     80
000140131128     DWBIPGM                  81     90
000141131128     DWRTDTA                  91    170
000142131128     DWCOERR                 171    174
000143131128     DWDERFI                 201    208
000144131128     DWFIINF                 209    243
000145131128     DWJOB                   244    253
000146131128     DWUSER                  254    263
000147131128     DWJBNUM                 264    269  0
000148131128     DWDSFL1           DS
000149131128     DWPOSC                  370    371B 0
000150131128     DWRRNG                  376    377B 0
000151131128     DWRNGP                  378    379B 0
000152131128     DWNBRSF                 380    381B 0
000153131128     DWLIGCF                 382    383B 0
000154131128     DWRCMIE                 403    404B 0
000155131128     DWDSFIF           DS
000156131128     DWNRC01                 397    400B 0
000157131128     DWDSFI1           DS
000158131128     DWCDFIL                   1      8
000159131128     DWOPNF                    9      9
000160131128     DWSTFIL                  11     15  0
000161131128     DWOPCOD                  16     21
000162131128     DWRPGSQ                  30     37
000163131128     DWRPGNR                  38     45
000164131128     DWERRFI                  46     52
000165131128     DWNMFIC                  83     92
000166131128     DWNMBIB                  93    102
000167131128     DWSPNOM                 103    112
000168131128     DWSPLIB                 113    122
000169131128     DWSPNBR                 123    124B 0
000170131128     DWLIMBR                 129    138
000171131128     DWNBPUT                 243    246B 0
000172131128     DWNBGET                 247    250B 0
000173131128     DWNBPG                  251    254B 0
000174131128     DWNBIO                  255    258B 0
000175131128     DWRCDFT                 261    270
000176131128     DWNBRCD                 283    286B 0
000177131128     DWNRCFI                 397    400B 0
000178131128     C     SKKCL1        KLIST
000179131128     C                   KFLD                    MIFON
000180131128     C     KKCL01        KLIST
000181131128     C                   KFLD                    MIFON
000182131128     C* initialisations générales
000183131128     C                   SETON                                        0910
000184131128     C                   EXSR      DATHEU
000185131128     C                   MOVE      WDAT          ZDATE
000186131128     C                   MOVE      WHEU          ZHEUR
000187131128     C                   MOVEL     WUSER         ZUSER
000188131128     C                   MOVEL     WJOB          ZJOB
000189131128     C                   MOVEL     '*  '         WPGMQ
000190131128     C                   MOVEL     'CC01'        WMGKEY
000191131128     C                   SETON                                        0910
000192131128     C* Indicateur fin
000193131128     C                   SETON                                        50
000194131128     C* Debut du traitement,
000195131128     C                   EXSR      INITSF
000196131128     C* Boucle d'attente de sortie
000197131128     C                   DOW       *IN50 = '1'
000198131128     C                   EXSR      TRTSFL
000199131128     C                   END
000200131128     C                   SETON                                        LR
000201131128     C* traitement de l'écran
000202131128     C     TRTSFL        BEGSR
000203131128     C*
000204131128     C                   MOVEL     '3'           PTYP
000205131128     C                   MOVEL     *BLANK        PFIM
000206131128     C                   MOVEL     *BLANK        PMID
000207131128     C                   CALL      'PGM001CL'
000208131128     C                   PARM                    PTYP              1
000209131128     C                   PARM                    PFIM             10
000210131128     C                   PARM                    PMID              7
000211131128     C                   PARM                    PMDT             99
000212131128     C                   WRITE     WSFCTL
000213131128     C                   SETON                                        0405
000214131128     C                   WRITE     FORE1                                  70
000215131128     C                   WRITE     FORB1
000216131128     C* attente lecture
000217131128     C                   READ      FORE1                                  70
000218131128     C* chargement de l'heure
000219131128     C                   TIME                    ZHEUR
000220131128     C*
000221131128     C                   SETON                                        51
000222131128     C                   IF        *IN02 = '1'
000223131128     C* page suivante
000224131128     C                   EXSR      CHGPAG
000225131128     C                   SETOFF                                       51
000226131128     C                   END
000227131128     C*
000228131128     C* touches F3 et F12
000229131128     C                   IF        *INKC = '1' OR
000230131128     C                             *INKL = '1'
000231131128     C* on met l'indicateur à Off
000232131128     C                   SETOFF                                       5051
000233131128     C                   END
000234131128     C*
000235131128     C                   IF        *INKE = '1'
000236131128     C* F5 Rafraichissement de l'écran
000237131128     C                   EXSR      INITSF
000238131128     C                   SETOFF                                       51
000239131128     C                   END
000240131128     C*
000241131128     C                   IF        *INKF = '1'
000242131128     C* F6 création d'une nouvelle fonction
000243131128     C                   MOVEL     'CR'          PCHX
000244131128     C                   MOVEL     *BLANK        NREC
000245131128     C                   CALL      'PGMF11'
000246131128     C                   PARM                    PCHX              2
000247131128     C                   PARM                    NREC             10
000248131128     C                   EXSR      INITSF
000249131128     C                   SETOFF                                       51
000250131128     C                   END
000251131128     C*
000252131128     C                   IF        *IN51 = '1'
000253131128     C                   EXSR      TRTOPT
000254131128     C                   END
000255131128     C* on recommence la boucle d'attente
000256131128     C                   ENDSR
000257131128     C* Les Sub Routines
000258131128     C*****************************************
000259131128     C*  Initialisation du sous-fichier
000260131128     C*****************************************
000261131128     C     INITSF        BEGSR
000262131128     C*    l'indicateur 20 conditionne la zone OPT (protection)
000263131128     C                   SETOFF                                       20
000264131128     C*    dernière ligne écrite
000265131128     C                   Z-ADD     0             LSTLIG            4 0
000266131128     C*    compteur de ligne par page
000267131128     C                   Z-ADD     0             NBRLIG            4 0
000268131128     C*    la fameux WRAN01
000269131128     C                   Z-ADD     0             WRAN01            4 0
000270131128     C                   SETON                                        0607
000271131128     C                   SETOFF                                       0405
000272131128     C                   WRITE     FORE1
000273131128     C                   SETOFF                                       06
000274131128     C                   SETON                                        0405
000275131128     C                   EXSR      CHGPAG
000276131128     C*
000277131128     C                   ENDSR
000278131128     C******************************
000279131128     C     TRTOPT        BEGSR
000280131128     C*  Lecture des enregistrements modifiés
000281131128     C                   Z-ADD     1             WRAN01
000282131128     C* top pour rafraichir l'écran
000283131128     C                   SETOFF                                       86
000284131128     C  N70              READC     SFL01                                7070
000285131128     C*
000286131128     C     *IN70         DOWEQ     '0'
000287131128     C                   MOVE      HNREC         NREC
000288131128     C                   SETON                                        85
000289131128     C                   SELECT
000290131128     C                   WHEN      (ZOPT = ' ')
000291131128     C                   SETOFF                                       85
000292131128     C                   WHEN      (ZOPT = '2')
000293131128     C                   MOVEL     'MO'          PCHX
000294131128     C                   WHEN      (ZOPT = '3')
000295131128     C                   MOVEL     'CO'          PCHX
000296131128     C                   WHEN      (ZOPT = '4')
000297131128     C                   MOVEL     'SU'          PCHX
000298131128     C                   WHEN      (ZOPT = '5')
000299131128     C                   MOVEL     'AF'          PCHX
000300131128     C                   OTHER
000301131128     C                   SETOFF                                       85
000302131128     C* envoyer un message pour dire que l'option n'existe pas
000303131128     C                   MOVEL     '1'           PTYP
000304131128     C                   MOVEL     'FICMSG   '   PFIM
000305131128     C                   MOVEL     'MSG0002'     PMID
000306131128     C                   CALL      'PGM001CL'
000307131128     C                   PARM                    PTYP              1
000308131128     C                   PARM                    PFIM             10
000309131128     C                   PARM                    PMID              7
000310131128     C                   PARM                    PMDT             99
000311131128     C                   ENDSL
000312131128     C                   MOVEL     *BLANK        ZOPT
000313131128     C                   UPDATE    SFL01                                90
000314131128     C* on aurait pu aussi faire IF ....
000315131128     C   85              CALL      'PGMF11'
000316131128     C                   PARM                    PCHX              2
000317131128     C                   PARM                    NREC             10
000318131128     C   85              SETON                                        86
000319131128     C                   READC     SFL01                                7070
000320131128     C                   END
000321131128     C   86              EXSR      INITSF
000322131128     C                   ENDSR
000323131128     C*************************************
000324131128     C     CHGPAG        BEGSR
000325131128     C*  chargement de la page
000326131128     C                   SETOFF                                       08
000327131128     C*                  SETON                                        04
000328131128     C                   Z-ADD     LSTLIG        WRAN01
000329131128     C     *LOVAL        SETLL     FIFF                                   70
000330131128     C                   READ      FIFF                                   70
000331131128     C                   Z-ADD     0             NBRLIG            4 0
000332131128     C*
000333131128     C     *IN70         DOWEQ     '0'
000334131128     C     NBRLIG        ANDLT     15
000335131128     C* remplissage des zones écran
000336131128     C                   MOVEL     MIFON         ZCOD
000337131128     C* on tronque à l'affichage
000338131128     C                   MOVEL     MILIB         ZLIB
000339131128     C* conversion de la date
000340131128     C                   TEST (Z)                MITSC                  90
000341131128     C     *IN90         IFEQ      '1'
000342131128     C                   MOVEL     *LOVAL        WHS
000343131128     C                   ELSE
000344131128     C                   MOVEL     MITSC         WHS
000345131128     C                   END
000346131128     C                   EXSR      CVTDAT
000347131128     C                   MOVE      W8            ZDAC
000348131128     C                   TEST (Z)                MITSM                  90
000349131128     C     *IN90         IFEQ      '1'
000350131128     C                   MOVEL     *LOVAL        WHS
000351131128     C                   ELSE
000352131128     C                   MOVEL     MITSM         WHS
000353131128     C                   END
000354131128     C                   EXSR      CVTDAT
000355131128     C                   MOVE      W8            ZDAM
000356131128     C* la on met une petite complication qui ralentit fortement le traitement
000357131128     C                   Z-ADD     0             ZNBEM
000358131128     C     KKCL01        CHAIN     FICF                               7190
000359131128     C* la clé est la code fonction lu dans le fichier des codes
000360131128     C                   DOW       *IN71 = '0'
000361131128     C* lecture de tous les employés ayant le même code
000362131128     C     ZNBEM         ADD       1             ZNBEM
000363131128     C     KKCL01        READE     FICF                                 9071
000364131128     C                   ENDDO
000365131128     C* pour récupérer le numéro d'enregistrement
000366131128     C                   MOVEL     WDSFIF        WDSFI1
000367131128     C                   Z-ADD     WNRCFI        HNREC
000368131128     C                   ADD       1             NBRLIG
000369131128     C                   ADD       1             WRAN01
000370131128     C                   ADD       1             LSTLIG            4 0
000371131128     C                   WRITE     SFL01
000372131128     C* lecture du suivant
000373131128     C                   READ      FIFF                                   70
000374131128     C                   END
000375131128     C* on quitte la boucle soit en fin de page
000376131128     C*                     soit en fin de fichier
000377131128     C     *IN70         IFEQ      '1'
000378131128     C* le caractère de suite
000379131128     C                   SETON                                        07
000380131128     C                   END
000381131128     C* si le fichier est vide
000382131128     C     WRAN01        IFEQ      0
000383131128     C                   Z-ADD     1             NBRLIG
000384131128     C                   Z-ADD     1             LSTLIG            4 0
000385131128     C* un petit message
000386131128     C                   Z-ADD     1             WRAN01
000387131128     C* pas de saisie d'option
000388131128     C                   SETON                                        20
000389131128     C                   eval      ZLIB = 'Sélection Vide   '
000390131128     C                   MOVEL     *BLANK        ZCOD
000391131128     C                   Z-ADD     0             HNREC
000392131128     C                   WRITE     SFL01
000393131128     C                   END
000394131128     C* le WRAN01 à 1 pour afficher le premier enregistrement
000395131128     C                   Z-ADD     1             WRAN01
000396131128     C                   ENDSR
000397131128     C* chargement de la date et heure système
000398131128     C     DATHEU        BEGSR
000399131128     C                   TIME                    W14
000400131128     C                   MOVE      W14           WDAT
000401131128     C                   MOVEL     W14           WHEU
000402131128     C                   ENDSR
000403131128     C* conversion de la date
000404131128     C     CVTDAT        BEGSR
000405131128     C                   MOVEL     WHS           WASTA
000406131128     C* la DS découpe les valeurs que l'on concatène
000407131128     C                   EVAL      W8 = WJA+ WMA+ WSA
000408131128     C* il ne reste plus qu'a charger dans la zone écran
000409131128     C                   ENDSR
