000100130926     H debug decedit('0,') datedit(*dmy.)
000101140630      //****************************************************
000102140630      //                                                   *
000103140630      // Le compteur double                                *
000104140630      //                                                   *
000105140630      //****************************************************
000106130926     Ffcp01l    uf a e           k disk
000107140630
000108140630      * main function prototype
000109140630      * prototype fonction principale
000110140701     dP_pgmc01         PR                  extpgm('PGMC01')
000111150701     d pcod                                like(r_cod)
000112150701     d pcpt                                like(r_cpt)
000113150701     d pcp1                                like(r_cp6num)
000114150701     d pcp2                                like(r_cp10num)
000115140630
000116140701     dP_pgmc01         PI
000118150701     d pcod                                like(r_cod)
000119150701     d pcpt                                like(r_cpt)
000120150701     d pcp1                                like(r_cp6num)
000121150701     d pcp2                                like(r_cp10num)
000122140630      * external functions prototypes
000123140630      * prototype fonctions externes
000124140630
000125140630      * program status data structure
000126140630      * structure information programme
000127140630
000128140701     d/copy qcpysrc,psds
000129140630      * local functions prototypes
000130140630      * prototypes fonctions locales
000131140630
000132140630      * global variables
000133140630      * variables globales
000139140630
000140140630      * inherited variables
000141140630      * héritage des types
000142140701     d/copy QINHLESRC,INH32766
000143140630
000144140630      * constants
000145140630      * constantes
000146140630
000148140630
000149140630      * main function
000150140630      * fonction principale
000151140630
000153140630      // Incremente le compteur souhaité
000154140630      /FREE
000155140701       chain(E) pcod fcpf;
000158140630       // le début
000159140630       // au cas ou il serait utilisé ailleurs
000160140630       dow %error;
000161140701         chain(E) pcod fcpf;
000162140630
000164140630         // on boucle
000165140630       enddo;
000166150701       if not %error and %found;
000168140630         // le compteur existe
000169140630         if pcpt = '1';
000170140630           // on veut le compteur 1
000171140630           cpcp1+=1;
000173140630         else;
000174140630           // c'est le compteur 2
000176140630           cpcp2+=1;
000178140630         endif;
000181140630         cpdam=%date();
000182140630         cphem=%time();
000183140701         cpusm=user;
000184150701         update fcpf;
000186140630       else;
000187140630         // il y a un risque, c'est qu'un autre essaie de créer le même !!
000189140630         cpcod=pcod;
000191140630         if pcpt = '1';
000192140630           // on veut le compteur 1
000194140630            cpcp1=1;
000195140630            cpcp2=0;
000197140630         else;
000198140630           // c'est le compteur 2
000200140630            cpcp1=0;
000201140630            cpcp2=1;
000203140630         endif;
000206140630         cpdac=%date();
000207140630         cphec=%time();
000208140701         cpusc=user;
000209140630         cpdam=%date();
000210140630         cphem=%time();
000211140701         cpusm=user;
000213140630         write fcpf;
000214140630       endif;
000215140630         // et on retourne les valeurs
000217150701         pcp1=cpcp1;
000218150701         pcp2=cpcp2;
000220140630        // c'est fini il faut mettre LR   *ON
000222140630       *inlr = *on;
000234140630      /END-FREE
