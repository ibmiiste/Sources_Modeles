000100150721     h debug decedit('0,') datedit(*dmy.) bnddir('SERVICES')
000101150721     h option(*srcstmt)
000102150713     h/if defined(*crtbndrpg)
000103150713     h DFTACTGRP(*no) actgrp(*caller)
000104150713     h/Endif
000105131128      //*********************************************************************
000106150721      // OD 21/07/2015
000107131128      // liste du personnel
000108131128      //*********************************************************************
000109131128      // déclaration des fichiers
000110150710     fpgmf01fm  cf   e             workstn
000111150710     f                                     sfile(sfl01 :wran01)
000112150710     f                                     infds(dssfl1)
000113150713     f                                     indds(IndDS)
000114150710     ffic02l    if   e           k disk
000115150710     f                                     infds(fic)
000116150710
000117150710      // main function prototype
000118150710      // prototype fonction principale
000119150713     dliste_personnel  pr                  extpgm('PGMF01')
000120150713     dliste_personnel  pi
000121150710
000122150710      // external functions prototypes
000123150710      // prototype fonctions externes
000124150713      * Gestion des messages
000125150713     dgst_message      pr                  extpgm('PGM001CL')
000126150713     d a_typ                               like(r_typmsg)
000127150713     d a_fim                               like(r_nomobj)
000128150713     d a_mid                               like(r_msgid)
000129150713     d a_mdt                               like(r_msgdta)
000130150713
000131150713      * Appel de l'écran détail du personnel
000132150713     ddetail_personnel...
000133150713     d                 pr                  extpgm('PGMF02')
000134150713     d a_chx                               like(r_operation)
000135150721     d a_nrec                              like(r_matricule)
000136150713
000137150713     d* Impression
000138150713     dimpression       pr                  extpgm('PGMF2SCL')
000139150713     d a_mat                               like(r_matricule)
000140150713
000141150713      // Gestion des erreurs non prévues
000142150713     d gest_erreur     pr
000143150713
000157150710      // program status data structure
000158150710      // structure information programme
000159150713     d/copy qcpysrc,psds
000160150710
000161150710      // local functions prototypes
000162150710      // prototypes fonctions locales
000163150710
000164150710      // global variables
000165150710      // variables globales
000167150713     dg_snom           s                   like(r_nom)
000168150713     dg_wsnop          s                   like(r_nom)
000169150713
000170150713     dg_nblis1         s                   like(r_nblign)
000171150713     dg_lstlig         s                   like(r_nblign)
000172150713     dg_nbrlig         s                   like(r_nblign)
000173150713     dg_i              s              3p 0
000174150713     dg_xnom           s                   like(r_nom)
000175150713     da_typ            s                   like(r_typmsg)
000176150713     da_fim            s                   like(r_nomobj)
000177150713     da_mid            s                   like(r_msgid)
000178150713     da_mdt            s                   like(r_msgdta)
000179150713
000180150713     d a_chx           s              2a
000181150722     d a_nrec          s                   like(r_matricule)
000182150713     d a_mat           s                   like(r_matricule)
000183150713
000184150713      // Indicateurs
000185150713     d g_sortie        s               n
000186150713     d g_trt_opt       s               n
000187150713     d g_selection     s               n
000188150713     d g_alimsfl       s               n
000189150713     d g_filtre        s               n
000190150713
000191150713      // Touches de fonction
000192150713      /copy qcpysrc,fonction
000193150710
000194150713      // data-structures
000195150713      // structures de données
000196150713      // Indicateurs renommés avec Indara et INDDS
000197150713     D IndDS           ds
000198150713     D  ROLLUP                         N   Overlay(IndDS:2)
000199150713     D  SFLDSP                         N   Overlay(IndDS:4)
000200150713     D  SFLDSPCTL                      N   Overlay(IndDS:5)
000201150713     D  SFLCLR                         N   Overlay(IndDS:6)
000202150713     d  SFLEND                         N   Overlay(IndDS:7)
000203150713     d  SFLNXTCHG                      N   Overlay(IndDS:8)
000204150713     d  SFLENDMSG                      N   Overlay(IndDS:9)
000205150713     D  SFLINZ                         N   Overlay(IndDS:10)
000206150713     D  PROTECT                        N   Overlay(IndDS:20)
000207150713     D  ROUGE                          N   Overlay(IndDS:30)
000208150713
000209150713      // la ds du sous=fichier
000210150713     ddssfl1           ds
000211150713     dwposc                  370    371b 0
000212150713     dwrrng                  376    377b 0
000213150713     dwrngp                  378    379b 0
000214150713     dwnbrsf                 380    381b 0
000215150713
000216150713      // la ds du fichier
000217150713     dfic              ds
000218150713     dwnrc01                 397    400b 0
000219150713     dwdsfic           ds
000220150713     dwcdfil                   1      8
000221150713     dwopenf                   9      9
000222150713     dwstsfi                  11     15  0
000223150713     dwopcod                  16     21
000224150713     dwrpgsq                  30     37
000225150713     dwrpgnr                  38     45
000226150713     dwerrfi                  46     52
000227150713     dwnfich                  83     92
000228150713     dwnlibr                  93    102
000229150713     dwspnam                 103    112
000230150713     dwsplib                 113    122
000231150713     dwspnum                 123    124b 0
000232150713     dwlimbr                 129    138
000233150713     dwnbput                 243    246b 0
000234150713     dwnbget                 247    250b 0
000235150713     dwnbpg                  251    254b 0
000236150713     dwnbio                  255    258b 0
000237150713     dwrcdft                 261    270
000238150713     dwnbrcd                 283    286b 0
000239150713     dwnrcfi                 397    400b 0
000240150713
000241150710      // inherited variables
000242150710      // héritage des types
000243150713     d/copy QINHLESRC,INH32766
000244150710
000245150710      // constants
000246150710      // constantes
000247150710
000266131129      * main function
000267131129      * fonction principale
000268131129      /free
000269150713       monitor;
000270131129       // le nombre de lignes affichables, déclaration à la volée
000271150713         g_nblis1=14;
000272150713         // initialisation des variables générales
000273150713         zpgm=PROCEDURE;
000274150713         zdate=%dec(%date():*eur);
000275150713         zheur=%dec(%time():*eur);
000276150713         zuser=USER;
000277150713         zjob=JOB_NAME;
000278150713         // initialisation du sous fichier des messages
000279150713         wpgmq='*  ';
000280150713         wmgkey='CC01';
000281150713         sflendmsg = *on;
000282150713         sflinz = *on;
000283150713         // indicateur fin
000284150713         g_sortie = *off;
000285150713         // début du traitement,
000286150713         exsr initsf;
000287150713         // boucle d'attente de sortie
000288150721         dow not g_sortie;
000289150713           exsr trtsfl;
000290150713         enddo;
000291150713
000292150713         on-error;
000293150713           dump(a);
000294150713           gest_erreur();
000295150713         endmon;
000296150713
000297131128       // indicateur de fin de programme
000298131128       *inlr = *on;
000299131128       // les procédures
000300131128       // traitement de l'écran
000301131128       begsr trtsfl;
000302131128         // effacement du sous=fichier de messages
000303131129          a_typ='3';
000304131129          a_fim=*blank;
000305131129          a_mid=*blank;
000306131129          gst_message(  a_typ
000307131129                      : a_fim
000308131129                      : a_mid
000309131129                      : a_mdt);
000310131128         write wsfctl;
000311131128         // ecriture de l'écran
000312150713         sfldsp = *on;
000313150713         sfldspctl = *on;
000314131128         write fore1;
000315150713
000316131128         write forb1;
000317131128         // attente lecture
000318131128         read fore1;
000319150713
000320131128         // une touche a été actionnée
000321131128         // chargement de l'heure
000322131129         zheur=%dec(%time());
000323131129         // indicateur pour ne pas tester d'autres actions
000324150713         g_trt_opt = *on;
000325150721         if rollup;
000326131128           // page suivante
000327131128           exsr chgpag;
000328150713           g_trt_opt = *off;
000329131128         endif;
000330131128         //
000331150713         if g_wsnop <> zsnom
000332150713         and g_trt_opt;
000333131129         // test si selection/ si changé on initialise
000334131129           exsr initsf;
000335150713           g_trt_opt = *off;
000336131128         endif;
000337131128         // touches f3 et f12
000338150721         if sortie or
000339150721               cancel;
000340131128           // on met l'indicateur  off = fin du programme
000341150713           g_sortie = *on;
000342150713           g_trt_opt = *off;
000343131128         endif;
000344131128         //
000345150721         if refresh;
000346131128           // f5 rafraichissement de l'écran
000347131128           exsr initsf;
000348150713           g_trt_opt = *off;
000349131128         endif;
000350131128         //
000351150721         if creer;
000352131128           // f6 création d'un nouveau matricule
000353131129            a_chx='CR';
000354150713            a_nrec=*zero;
000355131129            detail_personnel(a_chx:a_nrec);
000356131129            exsr initsf;
000357150713           g_trt_opt = *off;
000358131128         endif;
000359150721         if imprimer;
000360131128           // f8 impression du fichier
000361150713            a_mat=*zero;
000362131129            // on appelle le cl de routage sans soumission, sinon pgmf20cl
000363131129            impression(a_mat);
000364150713            g_trt_opt = *off;
000365131128         endif;
000366131128         // on ne fait ceci que s'il n'y a eu rien d'autre
000367150721         if g_trt_opt;
000368131128           exsr trtopt;
000369131128         endif;
000370131128         // on recommence la boucle d'attente
000371131128       endsr;
000372131128       // initialisation du sous-fichier
000373131128       begsr initsf;
000374131128         //    l'indicateur 20 conditionne la zone opt (protection)
000375150713         protect = *off;
000376131128         // initialisation de la variable de sélection
000377150713         g_wsnop=zsnom;
000378131129         g_snom=*blank;
000379131129         // initialisation de la clé pour positionnement
000380131129         fifon=*blank;
000381131129         finom=*blank;
000382150713         g_selection = *off;
000383150713         g_filtre = *off;
000384131128         if zsnom <> *blank;
000385131128           // si différent de blank il y a sélection
000386150713           g_selection = *on;
000387150713           g_i=0;
000388150713           g_i=%scan('*':zsnom);
000389131129
000390150713           if g_i > 0;
000391150713              g_filtre=*on;
000392150713              g_i=g_i-1;
000393150713              g_snom=%subst(zsnom:1:g_i);
000394131129              // on est dans le cas d'une sélection générique
000395131128             // on se positionnera juste au bon endroit dans le fichier
000396131129              finom=g_snom;
000397131128           endif;
000398131128         endif;
000399131128         // la dernière ligne écrite
000400131129
000401150713         g_lstlig=0;
000402131129         // le compteur de ligne par page
000403150713         g_nbrlig=0;
000404131129         // le fameux wran01
000405150713         wran01=0;
000406131129         // effacement du sous=fichier
000407150713         sflclr = *on;
000408150713         sflend = *on;
000409150713         sfldsp = *off;
000410150713         sfldspctl = *off;
000411131128         write fore1;
000412150713         sflclr = *off;
000413150713         sfldsp = *on;
000414150713         sfldspctl = *on;
000415131128         // positionnement en début de fichier
000416150713         setll ( fifon: finom) fic02l;
000417131128         // chargement de la première page
000418131128         exsr chgpag;
000419131128       endsr;
000420131128       // traitement des options, on ne lit que les enregistrements modifiés
000421131128       begsr trtopt;
000422131128         // lecture des enregistrements modifiés
000423150721          wran01=1;
000424131129          // top pour rafrachir l'écran, si besoin
000425150713         g_alimsfl = *off;
000426131129         readc sfl01;
000427131129         dow not %eof;
000428131129             a_nrec=hnrec;
000429150721             if htout='1';
000430131129                if zopt='2' or zopt='3' or zopt='4' or zopt='5';
000431131128               // si l'employé  quitté on ne peut plus rien modifier
000432131129                   zopt='5';
000433131129                endif;
000434131129             endif;
000435150713             g_filtre = *on;
000436131129             // selection en fonction du choix saisi
000437131129             select;
000438131129             when (zopt = '2') or (zopt = ' 2');
000439131129                a_chx='MO';
000440131129             when (zopt = '3') or (zopt = ' 3');
000441131129                a_chx='CO';
000442131129             when (zopt = '4') or (zopt = ' 4');
000443131129                a_chx='SU';
000444131129             when (zopt = '5') or (zopt = ' 5');
000445131129                a_chx='AF';
000446131129             when (zopt = '6') or (zopt = ' 6');
000447150713                a_mat=hmatr;
000448131129                impression(a_mat);
000449150713                g_filtre = *off;
000450131129             when (zopt = '99');
000451131129                a_chx='PE';
000452131129             other;
000453131128             // la saisie ne correspond  rien
000454150713                g_filtre = *off;
000455131128             // envoyer un message pour dire que l'option n'existe pas
000456131129                a_typ='1';
000457131129                a_fim='FICMSG   ';
000458131129                a_mid='MSG0002';
000459131129                gst_message(  a_typ
000460131129                            : a_fim
000461131129                            : a_mid
000462131129                            : a_mdt);
000463131129             endsl;
000464150721             if htout = '0';
000465131128             // pour ne pas perdre l'attribut couleur
000466150721               rouge = *off;
000467131129             else;
000468150721               rouge = *on;
000469131129             endif;
000470131129             // nettoyage
000471131129             zopt=*blanks;
000472131129             update(e) sfl01;
000473131129             // on aurait pu aussi faire if..., en tout cas le choix est bon
000474131129             detail_personnel(  a_chx
000475131129                              : a_nrec);
000476150713             g_alimsfl=*on;
000477131129             // on continue de boucler si autre option
000478131128           readc(e) sfl01;
000479131128         enddo;
000480131128         // potentiellement il y a eu mise  jour, on pourrait affiner
000481150713         if g_alimsfl;
000482131129            exsr initsf;
000483131129         ENDIF;
000484131128       endsr;
000485131128       // chargement d'une page
000486131128       begsr chgpag;
000487131128         // il faut positionner correctement les indicateurs et les variables
000488150713         sflnxtchg = *off;
000489131128         //                  seton                                        04
000491150713         wran01=g_lstlig;
000492131129         // lecture de l'enregistrement suivant
000494150713         read fic02l;
000495150713
000496131129         // remise à zéro du compteur de ligne, mais on pourrait faire autrement
000498150713         g_nbrlig=0;
000499131129
000501150713         dow not %eof(fic02l)
000502150713         and g_nbrlig < 14;
000503131128           // remplissage des zones écran
000504150713           g_alimsfl = *on;
000505131128           // test s'il y a sélection
000506150721           if g_selection or g_filtre;
000507150721             if g_selection and not g_filtre;
000508131128               // on recherche la stricte égalité de nom
000509131128               if finom <> zsnom;
000510150713                 g_alimsfl = *off;
000511131128               endif;
000512131128             else;
000513131129                // on recherche si le nom commence par la valeur avant le '*'
000515150713                g_xnom=%subst( finom:1:g_i);
000518131129                if g_xnom <> g_snom;
000519150713                 g_alimsfl = *off;
000520131128               endif;
000521131128             endif;
000522131128           endif;
000523131128           // l'indicateur est  '1' si sélection ok ou pas de sélection
000524150721           if g_alimsfl;
000526131129              znom=finom;
000527131129              zpr1=fipr1;
000528131129              zfonc=fifon;
000529131129              zmatr=fimat;
000530131129              zcpo=ficpo;
000531131129              wdsfic=fic;
000532131129              hnrec=wnrcfi;
000533131129              hmatr=fimat;
000535131129              if fidas = 0;
000536131128               // top salarié licencié
000538150721              htout = *off;
000540150721              rouge = *off;
000541131129            else;
000543150721              htout = *on;
000545150721              rouge = *on;
000546131128             endif;
000547131128             // les compteurs, attention au wran01
000549150713             g_nbrlig+=1;
000550150713             g_lstlig+=1;
000551131129             wran01+=1;
000552131129             // ecriture de la ligne
000554131128             write sfl01;
000555131128           endif;
000556131128           // lecture du suivant
000557150713           read fic02l;
000558150713
000559131128         enddo;
000560131128         // on quitte la boucle soit en fin de page
000561131128         //                     soit en fin de fichier
000562150721         if %eof(fic02l);
000563131128           // le caractère de suite, on est en fin de fichier
000564150713           sflend = *on;
000565131128         else;
000566150713           sflend = *off;
000567131128         endif;
000568131128         // si le fichier est vide
000569131128         if wran01 = 0;
000571150713            g_nbrlig=1;
000572150713            g_lstlig=1;
000573131129            // un petit message
000574131129            wran01=1;
000575131129            // pas de saisie d'option
000577150713           protect = *on;
000578131128           if zsnom = *blank;
000585131128             znom = 'sélection vide';
000586150721           else;
000587150721             znom = 'Fichier vide';
000588131128           endif;
000589131128           // ne pas oublier de remettre  blanc
000590131129           zpr1=*blank;
000591131129           zfonc=*blank;
000592131129           zmatr=0;
000593131129           zcpo=*blank;
000594131129           wdsfic=*blank;
000595131129           hnrec=0;
000596131129           // ecriture du message sur la première ligne
000597131128           write sfl01;
000598131128         endif;
000601131128       endsr;
000602131129      /end-free
