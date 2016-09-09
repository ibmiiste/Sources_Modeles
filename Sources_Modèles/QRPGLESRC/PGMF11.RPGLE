000100131127     H DEBUG DECEDIT('0,') DATEDIT(*DMY.)
000101131127     F*****************************************************
000102131127     F*                                                   *
000103131127     F* Détail fonction                                   *
000104131127     F*                                                   *
000105131127     F*****************************************************
000106131127     FPGMF11FM  CF   E             WORKSTN
000107131127     F                                     INFDS(WDSECR)
000108131127     FFIF00P    UF A E             DISK
000109131127     FFIF01L    IF   E           K DISK
000110131127     F                                     RENAME(FIFF      :FIFF1   )
000111131127     DWTXT1            C                   '         Modification         '
000112131127     DWTXT2            C                   '             Copie            '
000113131127     DWTXT3            C                   '           Création           '
000114131127     DWTXT4            C                   '         Suppression          '
000115131127     DWTXT5            C                   '           Affichage          '
000116131127     DPOPT             S              2
000117131127     DW14              S             14  0
000118131127     DW8               S              8
000119131127     DWDAT             S              8
000120131127     DWHEU             S              6
000121131127     DWHS              S               Z
000122131127     DPNREC            S             10
000123131127     DWNREC            S             10  0
000124131127     DW6               S              6
000125131127     DWS               DS
000126131127     DWSA                      1      4
000127131127     DWMA                      6      7
000128131127     DWJA                      9     10
000129131127     DWHA                     12     13
000130131127     DWIA                     15     16
000131131127     DWKA                     18     19
000132131127     DWMU                     21     26
000133131127     DWASTA                    1     26
000134131127     DWDSPGM          SDS
000135131127     DWNMPGM                   1     10
000136131127     DWSTATU                  11     15  0
000137131127     DWSTPRE                  16     20  0
000138131127     DWSRCSQ                  21     28
000139131127     DWNMROU                  29     36
000140131127     DWNBPAR                  37     39  0
000141131127     DWTYEXC                  40     42
000142131127     DWLICPF                  40     46
000143131127     DWNUEXC                  43     46
000144131127     DWMIODT                  47     50
000145131127     DWZOMES                  51     80
000146131127     DWBIPGM                  81     90
000147131127     DWRTDTA                  91    170
000148131127     DWCOERR                 171    174
000149131127     DWDERFI                 201    208
000150131127     DWFIINF                 209    243
000151131127     DWJOB                   244    253
000152131127     DWUSER                  254    263
000153131127     DWJOBNM                 264    269  0
000154131127     DWDSECR           DS
000155131127     DWNLIG                  370    371B 0
000156131127     DWRANP                  378    379B 0
000157131127     DWNBRS                  380    381B 0
000158131127     DWNULC                  382    383B 0
000159131127     DWRECMI                 403    404B 0
000160131127     C     *ENTRY        PLIST
000161131127     C                   PARM                    POPT
000162131127     C                   PARM                    PNREC
000163131127     C* Début du programme
000164131127     C     KEY001        KLIST
000165131127     C                   KFLD                    ZFCOD
000166131127     C                   MOVEL     '*   '        WPGMQ
000167131127     C                   MOVEL     'CC01'        WMGKEY
000168131127     C                   SETON                                        0910
000169131127     C                   SETOFF                                       1213
000170131127     C* cette DS découpe automatiquement le time stamp
000171131127     C                   MOVEL     WNMPGM        ZPGM
000172131127     C                   EXSR      DATHEU
000173131127     C                   MOVE      WDAT          ZDATE
000174131127     C                   MOVE      WHEU          ZHEUR
000175131127     C                   MOVEL     WUSER         ZUSER
000176131127     C                   MOVEL     WJOB          ZJOB
000177131127     C* constantes pour ce programme
000178131127     C                   MOVE      '1'           PTYP
000179131127     C                   MOVEL     'FICMSG    '  PFICM
000180131127     C                   SELECT
000181131127     C                   WHEN      (POPT = 'MO')
000182131127     C* modification, forcement du libellé
000183131127     C                   MOVEL     WTXT1         ZMODE
000184131127     C                   SETON                                          13
000185131127     C                   WHEN      (POPT = 'CO')
000186131127     C* tout est saisissable
000187131127     C                   MOVEL     WTXT2         ZMODE
000188131127     C                   SETON                                        1213
000189131127     C                   WHEN      (POPT = 'CR')
000190131127     C* tout est saisissable
000191131127     C                   MOVEL     WTXT3         ZMODE
000192131127     C                   SETON                                        1213
000193131127     C                   WHEN      (POPT = 'SU')
000194131127     C* rien n'est saisissable
000195131127     C                   MOVEL     WTXT4         ZMODE
000196131127     C                   WHEN      (POPT = 'AF')
000197131127     C* rien n'est saisissable
000198131127     C                   MOVEL     WTXT5         ZMODE
000199131127     C                   ENDSL
000200131127     C*
000201131127     C                   MOVE      PNREC         WNREC
000202131127     C                   IF        WNREC <> 0
000203131127     C* sauf si c'est de la création l'enregistrement doit exister
000204131127     C     WNREC         CHAIN (N) FIFF                               7090
000205131127     C                   IF        *IN70 = '0'
000206131127     C* et dans ce cas on renseigne les valeurs, sinon
000207131127     C* les variables sont initialisées à zéro
000208131127     C                   MOVEL     MIFON         ZFCOD
000209131127     C                   MOVEL     MILIB         ZFLIB
000210131127     C* date et heure création
000211131127     C                   TEST (Z)                MITSC                  90
000212131127     C     *IN90         IFEQ      '1'
000213131127     C                   MOVEL     *LOVAL        WHS
000214131127     C                   ELSE
000215131127     C                   MOVEL     MITSC         WHS
000216131127     C                   END
000217131127     C                   EXSR      CVTDAT
000218131127     C* il ne reste plus qu'à charger dans la zone écran
000219131127     C                   MOVE      W8            ZDAC
000220131127     C                   MOVE      W6            ZHEC
000221131127     C                   MOVEL     MIUSC         ZUSC
000222131127     C* date et heure de modif
000223131127     C                   TEST (Z)                MITSM                  90
000224131127     C     *IN90         IFEQ      '1'
000225131127     C                   MOVEL     *LOVAL        WHS
000226131127     C                   ELSE
000227131127     C                   MOVEL     MITSM         WHS
000228131127     C                   END
000229131127     C                   EXSR      CVTDAT
000230131127     C                   MOVE      W8            ZDAM
000231131127     C                   MOVE      W6            ZHEM
000232131127     C                   MOVEL     MIUSM         ZUSM
000233131127     C                   END
000234131127     C                   END
000235131127     C*
000236131127     C                   SETON                                        50
000237131127     C                   DOW       *IN50 = '1'
000238131127     C                   EXSR      TRTSCR
000239131127     C                   ENDDO
000240131127     C*
000241131127     C                   SETON                                        LR
000242131127     C********* les procédures
000243131127     C     TRTSCR        BEGSR
000244131127     C                   WRITE     WMGCTL
000245131127     C* On écrit l'écran
000246131127     C                   WRITE     FORE1
000247131127     C* On attend l'appui sur une touche
000248131127     C                   READ      FORE1                                  70
000249131127     C                   SETON                                          51
000250131127     C*
000251131127     C                   EXSR      DATHEU
000252131127     C                   IF        *INKC = '1' OR
000253131127     C                             *INKL = '1'
000254131127     C                   SETOFF                                       5051
000255131127     C                   END
000256131127     C*                  IF        POPT = 'SU'
000257131127     C*                  SETOFF                                         51
000258131127     C*                  END
000259131127     C                   IF        *IN85 = '1'
000260131127     C     *INKP         IFEQ      '1'
000261131127     C* touche F15 on supprime si indicateur *IN85
000262131127     C     WNREC         CHAIN     FIFF                               7090
000263131127     C  N70              DELETE    FIFF
000264131127     C                   SETOFF                                       5051
000265131127     C                   END
000266131127     C                   END
000267131127     C* contrôle des données saisies
000268131127     C                   IF        *IN51 = '1'
000269131127     C                   EXSR      CTLDTA
000270131127     C                   IF        *IN88 = '1'
000271131127     C* anomalie
000272131127     C                   EXSR      ENVMSG
000273131127     C                   SETOFF                                       88
000274131127     C                   ELSE
000275131127     C* pas d'anomalie, on valide
000276131127     C                   EXSR      VALID
000277131127     C                   SETOFF                                       5051
000278131127     C                   END
000279131127     C                   END
000280131127     C* fin procedure
000281131127     C                   ENDSR
000282131127     C******************
000283131127     C     CTLDTA        BEGSR
000284131127     C                   SETOFF                                       8885
000285131127     C* dans ce cas la seule vérification est en création/copie
000286131127     C                   IF         (POPT = 'CR' OR POPT = 'CO')
000287131127     C     KEY001        CHAIN     FIFF1                              7090
000288131127     C* pour éviter de s'auto verrouiller
000289131127     C                   IF        *IN70 = '0'
000290131127     C* le code fonction existe                           ZFCOD
000291131127     C                   SETON                                        12
000292131127     C                   MOVEL     'MSG0007'     PMGID
000293131127     C                   MOVEL     *BLANK        PMGDT
000294131127     C* top anomalie
000295131127     C                   SETON                                        88
000296131127     C                   END
000297131127     C                   END
000298131127     C* On ne fait la suite que si indicateur 88 à zéro
000299131127     C  N88              IF          POPT = 'SU'
000300131127     C* Suppression on prévient avant de supprimer
000301131127     C                   MOVEL     'MSG0004'     PMGID
000302131127     C                   MOVEL     *BLANK        PMGDT
000303131127     C                   SETON                                        8885
000304131127     C                   END
000305131127     C                   ENDSR
000306131127     C*
000307131127     C     VALID         BEGSR
000308131127     C* il n'y a eu aucune erreur on charge les zones communes
000309131127     C                   TIME                    WHS
000310131127     C     WNREC         CHAIN     FIFF                               7090
000311131127     C* c'est pas joli joli, on ne devrait le faire qu'en cas de modif.
000312131127     C                   MOVEL     ZFLIB         MILIB
000313131127     C                   MOVEL     WHS           MITSM
000314131127     C                   MOVEL     WUSER         MIUSM
000315131127     C                   IF        (POPT = 'MO')
000316131127     C* et on met à jour
000317131127     C                   UPDATE    FIFF
000318131127     C                   END
000319131127     C                   IF        (POPT = 'CO') OR
000320131127     C                             (POPT = 'CR')
000321131127     C* on rajoute le reste pour la création
000322131127     C                   MOVEL     ZFCOD         MIFON
000323131127     C                   MOVEL     MITSM         MITSC
000324131127     C                   MOVEL     WUSER         MIUSC
000325131127     C                   WRITE     FIFF
000326131127     C                   END
000327131127     C                   ENDSR
000328131127     C* mise à jour date et heure système
000329131127     C     DATHEU        BEGSR
000330131127     C                   TIME                    W14
000331131127     C                   MOVE      W14           WDAT
000332131127     C                   MOVEL     W14           WHEU
000333131127     C                   ENDSR
000334131127     C* conversion de la date
000335131127     C     CVTDAT        BEGSR
000336131127     C                   MOVEL     WHS           WASTA
000337131127     C* la DS découpe les valeurs que l'on concatène
000338131127     C                   EVAL      W8 = WJA+ WMA+ WSA
000339131127     C                   EVAL      W6 = WHA+ WIA+ WKA
000340131127     C                   ENDSR
000341131127     C*****Envoi d'un message programme
000342131127     C     ENVMSG        BEGSR
000343131127     C                   CALL      'PGM001CL'
000344131127     C                   PARM                    PTYP              1
000345131127     C                   PARM                    PFICM            10
000346131127     C                   PARM                    PMGID             7
000347131127     C                   PARM                    PMGDT            99
000348131127     C                   ENDSR
