000100131126     H DEBUG DECEDIT('0,') DATEDIT(*DMY.)
000101131126     F*****************************************************
000102131126     F*                                                   *
000103131126     F* Edition liste du personnel                        *
000104131126     F*                                                   *
000105131126     F*****************************************************
000106131126     FPGMF20PR  O    E             PRINTER OFLIND(*IN99)
000107131126     F                                     INFDS(WPRT)
000108131126     FFIC01L    IF   E           K DISK
000109131126     FFIF01L    IF   E           K DISK
000110131126     DTA1              S              1    DIM(10)
000111131126     DTA2              S              1    DIM(10)
000112131126     DWTXT1            C                   'Détail fiche employé'
000113131126     DWTXT2            C                   'Liste du personnel'
000114131126     DPMATR            S             10
000115131126     DW14              S             14  0
000116131126     DI                S              2  0
000117131126     DJ                S              2  0
000118131126     DD                S              2  0
000119131126     DF                S              2  0
000120131126     DWDI              DS
000121131126     DWSSAI                    1      4  0
000122131126     DWMI                      5      6  0
000123131126     DWJI                      7      8  0
000124131126     DWDATI                    1      8  0
000125131126     DWDE              DS
000126131126     DWJE                      1      2  0
000127131126     DWME                      3      4  0
000128131126     DWSSAE                    5      8  0
000129131126     DWDATE                    1      8  0
000130131126
000131131126     DDSPROG          SDS
000132131126     DWNPROG                   1     10
000133131126     DWSTATP                  11     15  0
000134131126     DWSTAPR                  16     20  0
000135131126     DWSQSRC                  21     28
000136131126     DWSBROU                  29     36
000137131126     DWNPARM                  37     39  0
000138131126     DWTYEXC                  40     42
000139131126     DWNMSGM                  40     46
000140131126     DWNMEXC                  43     46
000141131126     DWINSMC                  47     50
000142131126     DWZOMSG                  51     80
000143131126     DWLBPGM                  81     90
000144131126     DWSFDTA                  91    170
000145131126     DWCDERR                 171    174
000146131126     DWLSFIL                 201    208
000147131126     DWLSINF                 209    243
000148131126     DWJOB                   244    253
000149131126     DWUSER                  254    263
000150131126     DWNJOB                  264    269  0
000151131126     DWPRT             DS
000152131126     DNUMLIG                 367    368I 0
000153131126     DNUMPAG                 369    372I 0
000154131126     C     *ENTRY        PLIST
000155131126     C                   PARM                    PMATR
000156131126     C* début du programme
000157131126     C     KEY001        KLIST
000158131126     C                   KFLD                    FIMAT
000159131126     C     KEY002        KLIST
000160131126     C                   KFLD                    FIFON
000161131126     C                   MOVEL     '1'           *IN85
000162131126     C* pour forcer le premier changement de page
000163131126     C                   MOVEL     '1'           *IN99
000164131126     C* les constantes
000165131126     C                   MOVEL     WNPROG        ZPGM
000166131126     C                   MOVEL     WUSER         ZUSR
000167131126     C                   TIME                    W14
000168131126     C                   MOVE      W14           ZDATE
000169131126     C                   IF        PMATR <> *BLANK
000170131126     C* il faut cadrer si mal saisi
000171131126     C                   MOVEA     PMATR         TA1
000172131126     C                   DOW       I < 10
000173131126     C     I             ADD       1             I
000174131126     C                   IF        D = 0
000175131126     C                   IF        TA1(I) <> ' ' AND TA1(I) <> '0'
000176131126     C                   Z-ADD     I             D
000177131126     C                   END
000178131126     C                   ELSE
000179131126     C                   IF        TA1(I) = ' '
000180131126     C     I             SUB       1             F
000182131126     C                   LEAVE
000183131126     C                   END
000184131126     C                   END
000185131126     C                   END
000186131126     C* on a le debut et la fin
000187131126     C                   Z-ADD     F             I
000188131126     C                   Z-ADD     10            J
000189131126     C                   IF        D > 0 AND F > 0
000190131126     C* on charge le deuxième tableau en commençant par la fin
000191131126     C                   DOW       I >= D
000192131126     C                   MOVEL     TA1(I)        TA2(J)
000193131126     C     J             SUB       1             J
000194131126     C     I             SUB       1             I
000195131126     C                   END
000196131126     C* et tout est cadré à droite
000197131126     C                   MOVEA     TA2           PMATR
000198131126     C                   MOVE      PMATR         FIMAT
000199131126     C                   END
000200131126     C* si n'importe quoi FIMAT = 0, la lecture n'aboutira pas
000201131126     C     KEY001        CHAIN     FICF                               7090
000202131126     C                   IF        *IN70 = '0'
000203131126     C                   MOVEL     '0'           *IN85
000204131126     C* edition 1 page
000205131126     C                   MOVEL     WTXT1         ZTITRE
000206131126     C* le détail
000207131126     C                   Z-ADD     FIMAT         ZMATR
000208131126     C                   MOVEL     FIFON         ZCODF
000209131126     C     KEY002        CHAIN     FIFF                               7090
000210131126     C                   MOVEL     MILIB         ZLIF
000211131126     C                   MOVEL     FINOM         ZNOM
000212131126     C                   MOVEL     FIPR1         ZPRE1
000213131126     C                   MOVEL     FIPR2         ZPRE2
000214131126     C                   MOVEL     FIAD1         ZAD1
000215131126     C                   MOVEL     FIAD2         ZAD2
000216131126     C                   MOVEL     FIAD3         ZAD3
000217131126     C                   MOVEL     FICPO         ZCPO
000218131126     C                   MOVEL     FIVIL         ZVIL
000219131126     C                   MOVEL     FITEL         ZTEL
000220131126     C                   MOVEL     FIPOR         ZPOR
000221131126     C                   Z-ADD     FIDAE         WDATI
000222131126     C                   EXSR      INVDAT
000223131126     C                   Z-ADD     WDATE         ZDAE
000224131126     C                   Z-ADD     FIDAS         WDATI
000225131126     C                   EXSR      INVDAT
000226131126     C                   Z-ADD     WDATE         ZDAS
000227131126     C                   Z-ADD     FIDAC         WDATI
000228131126     C                   EXSR      INVDAT
000229131126     C                   Z-ADD     WDATE         ZDAC
000230131126     C                   Z-ADD     FIHEC         ZHEC
000231131126     C                   MOVEL     FIUSC         ZUSC
000232131126     C                   Z-ADD     FIDAM         WDATI
000233131126     C                   EXSR      INVDAT
000234131126     C                   Z-ADD     WDATE         ZDAM
000235131126     C                   Z-ADD     FIHEM         ZHEM
000236131126     C                   MOVEL     FIUSM         ZUSM
000237131126     C   99              EXSR      CHGPAG
000238131126     C                   WRITE     DETGEN
000239131126     C                   Z-ADD     1             ZLIG
000240131126     C                   ELSE
000241131126     C                   MOVEL     '1'           *IN85
000242131126     C                   END
000243131126     C                   END
000244131126     C                   IF        *IN85 = '1'
000245131126     C                   MOVEL     WTXT2         ZTITRE
000246131126     C* on édite tout
000247131126     C                   READ      FICF                                 9070
000248131126     C                   DOW       *IN70 = '0'
000249131126     C* le détail
000250131126     C                   Z-ADD     FIMAT         ZMATR
000251131126     C                   MOVEL     FINOM         ZNOMC
000252131126     C                   MOVEL     FIPR1         ZPRE1C
000253131126     C                   MOVEL     FIAD1         ZADR1C
000254131126     C                   MOVEL     FICPO         ZCPO
000255131126     C                   MOVEL     FIVIL         ZVILC
000256131126     C   99              EXSR      CHGPAG
000257131126     C                   WRITE     DETLIG
000258131126     C     ZLIG          ADD       1             ZLIG
000259131126     C                   READ      FICF                                 9070
000260131126     C                   END
000261131126     C                   END
000262131126     C   99              EXSR      CHGPAG
000263131126     C                   WRITE     FIN
000264131126     C* fin du programme
000265131126     C                   SETON                                        LR
000266131126     C****** inversion de la date
000267131126     C     INVDAT        BEGSR
000268131126     C                   Z-ADD     WSSAI         WSSAE
000269131126     C                   Z-ADD     WMI           WME
000270131126     C                   Z-ADD     WJI           WJE
000271131126     C                   ENDSR
000272131126     C****** changement de page
000273131126     C     CHGPAG        BEGSR
000274131126     C                   SETOFF                                       99
000275131126     C****** un aurait pu utiliser la variable info splf
000276131126     C*                  Z-ADD     NUMPAG        ZPAG
000277131126     C     ZPAG          ADD       1             ZPAG
000278131126     C                   WRITE     ENTETE
000279131126     C                   IF        *IN85 = '1'
000280131126     C                   WRITE     COLON
000281131126     C                   END
000282131126     C                   ENDSR
