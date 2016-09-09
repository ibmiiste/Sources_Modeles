000100131127     H DEBUG DECEDIT('0,') DATEDIT(*DMY.)
000101131127     F*****************************************************
000102131127     F*                                                   *
000103131127     F* Invite sur fonction                               *
000104131127     F*                                                   *
000105131127     F*****************************************************
000106131127     FPGMI01FM  CF   E             WORKSTN
000107131127     F                                     SFILE(SFL01 :WRAN01)
000108131127     F                                     INFDS(DSSFL1)
000109131127     FFIF01L    IF   E           K DISK
000110131127     DPCDACT           S              2
000111131127     DPRET             S              1
000112131127     DPFCT             S              3
000113131127     D* la ds du programme, on pourrait s'en passer dans ce cas
000114131127     DDSPROG          SDS
000115131127     DWNPROG                   1     10
000116131127     DWSTATP                  11     15  0
000117131127     DWSTAPR                  16     20  0
000118131127     DWSQSRC                  21     28
000119131127     DWSBROU                  29     36
000120131127     DWNPARM                  37     39  0
000121131127     DWTYEXC                  40     42
000122131127     DWNMSGM                  40     46
000123131127     DWNMEXC                  43     46
000124131127     DWINSMC                  47     50
000125131127     DWZOMSG                  51     80
000126131127     DWLBPGM                  81     90
000127131127     DWSFDTA                  91    170
000128131127     DWCDERR                 171    174
000129131127     DWLSFIL                 201    208
000130131127     DWLSINF                 209    243
000131131127     DWJOB                   244    253
000132131127     DWNJOB                  264    269  0
000133131127     D* La DS du sous=fichier
000134131127     DDSSFL1           DS
000135131127     DWPOSC                  370    371B 0
000136131127     DWRRNG                  376    377B 0
000137131127     DWRNGP                  378    379B 0
000138131127     DWNBRSF                 380    381B 0
000139131127     C* les paramètres d'entrée
000140131127     C     *ENTRY        PLIST
000141131127     C                   PARM                    PCDACT
000142131127     C                   PARM                    PFCT
000143131127     C* c'est ici que ça commence
000144131127     C     KEYSF1        KLIST
000145131127     C                   KFLD                    MIFON
000146131127     C* la clé sert  trier par code
000147131127     C                   MOVEL     '*   '        WPGMQ
000148131127     C                   MOVEL     'CC01'        WMGKEY
000149131127     C                   MOVEL     WNPROG        ZPGM
000150131127     C* Initialisation des indicateurs
000151131127     C                   SETON                                        0910
000152131127     C                   SETON                                        5013
000153131127     C                   IF        PCDACT = 'GS'
000154131127     C* indicateur pour autoriser la saisie du choix & visu option
000155131127     C                   SETOFF                                       13
000156131127     C                   END
000157131127     C* Initialisation du sous fichier
000158131127     C                   EXSR      INITSF
000159131127     C* Boucle d'attente de sortie
000160131127     C                   DOW       *IN50 = '1'
000161131127     C                   EXSR      TRTSFL
000162131127     C                   END
000163131127     C* Indicateur de fin de programme
000164131127     C                   SETON                                        LR
000165131127     C* Les procédures
000166131127     C     TRTSFL        BEGSR
000167131127     C* Effacement du sous=fichier de messages
000168131127     C                   MOVEL     '3'           PTYP
000169131127     C                   MOVEL     *BLANK        PFIM
000170131127     C                   MOVEL     *BLANK        PMID
000171131127     C                   CALL      'PGM001CL'
000172131127     C                   PARM                    PTYP              1
000173131127     C                   PARM                    PFIM             10
000174131127     C                   PARM                    PMID              7
000175131127     C                   PARM                    PMDT             99
000176131127     C                   WRITE     WSFCTL
000177131127     C* Ecriture de l'écran
000178131127     C                   SETON                                        0405
000179131127     C                   WRITE     FORE1                                  70
000180131127     C                   WRITE     FORB1                                  70
000181131127     C* Attente lecture
000182131127     C                   READ      FORE1                                  70
000183131127     C                   READ      FORB1                                  70
000184131127     C                   IF        *IN02 = '1'
000185131127     C* pour mémoire, on est en chargement total
000186131127     C* c'est le système qui s'en occupe
000187131127     C                   END
000188131127     C                   IF        *INKC = '1' OR
000189131127     C                             *INKL = '1'
000190131127     C* on quitte sans rien faire
000191131127     C                   SETOFF                                       50
000192131127     C                   END
000193131127     C* en mode GS, si on ne quitte pas, on vérifie le choix
000194131127     C   50              IF        PCDACT = 'GS'
000195131127     C* en mode GS uniquement
000196131127     C                   EXSR      VERIF
000197131127     C* l'utilisateur a fait le bon choix, on quitte le programme
000198131127     C                   IF        *IN85 = '0'
000199131127     C                   SETOFF                                       50
000200131127     C                   END
000201131127     C                   END
000202131127     C* On recommence la boucle d'attente
000203131127     C                   ENDSR
000204131127     C* vérification si choix '1'
000205131127     C     VERIF         BEGSR
000206131127     C* indicateur de fin de boucle
000207131127     C                   SETON                                          85
000208131127     C                   Z-ADD     1             WRAN01
000209131127     C  N70              READC     SFL01                                7070
000210131127     C*
000211131127     C                   DOW       *IN70 = '0' AND *IN85 = '1'
000212131127     C                   IF        ZOPT = '1'
000213131127     C* saisie correcte, on quitte la boucle
000214131127     C                   MOVEL     ZFCT          PFCT
000215131127     C                   SETOFF                                         85
000216131127     C                   END
000217131127     C* en fait c'est un peu inutile, et pour bien faire on devrait
000218131127     C* signaler  l'utilisateur si son choix est différent de '1'
000219131127     C                   MOVEL     *BLANK        ZOPT
000220131127     C                   UPDATE    SFL01                                90
000221131127     C*
000222131127     C                   READC     SFL01                                7070
000223131127     C                   ENDDO
000224131127     C                   ENDSR
000225131127     C*********************************
000226131127     C     INITSF        BEGSR
000227131127     C* initialisation de la position de la fenetre ligne6
000228131127     C                   Z-ADD     6             WINLIG
000229131127     C*                                       colonne 32
000230131127     C                   Z-ADD     32            WINCOL
000231131127     C                   Z-ADD     0             WRAN01
000232131127     C* la partie sensible de l'initialisation
000233131127     C                   SETON                                        0607
000234131127     C                   SETOFF                                       0405
000235131127     C                   WRITE     FORE1
000236131127     C                   SETOFF                                       06
000237131127     C                   SETON                                        0405
000238131127     C* lecture de tout le fichier
000239131127     C                   READ      FIFF                                   70
000240131127     C* normalement on devrait tester si WRAN01 est inférieur  9999
000241131127     C     *IN70         DOWEQ     '0'
000242131127     C* remplissage des zones
000243131127     C                   MOVEL     MIFON         ZFCT
000244131127     C                   MOVEL     MILIB         ZLIB
000245131127     C                   ADD       1             WRAN01
000246131127     C                   WRITE     SFL01
000247131127     C                   READ      FIFF                                   70
000248131127     C                   ENDDO
000249131127     C                   ENDSR
