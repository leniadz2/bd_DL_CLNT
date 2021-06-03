SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [bds].[sp_lty_cliente]
AS
  /***************************************************************************************************
  Procedure:          bds.[sp_lty_cliente]
  Create Date:        20210601
  Author:             dÁlvarez
  Description:        carga en bds el cliente Bonus
  Call by:            none
  Affected table(s):  bds.LYTY_CLI
  Used By:            tbd
  Parameter(s):       none
  Log:                none
  Prerequisites:      ods.sp_lty_lytyCli
  ****************************************************************************************************
  SUMMARY OF CHANGES
  Date(YYYYMMDD)      Author              Comments
  ------------------- ------------------- ------------------------------------------------------------
  20210601            dÁlvarez            creación
  
  ***************************************************************************************************/

TRUNCATE TABLE bds.LYTY_CLI;

INSERT INTO bds.LYTY_CLI
SELECT lc.CODIGOPERSONA
      ,lc.ORDTARJETABONUS
      ,lc.NUMTARJETABONUS
      ,lc.TIPOTARJETA                  
      ,lc.CODIGOTIPOPERSONA            
      ,lc.CODIGOTIPOPERSONA_D          
      ,lc.TIPODEDOCUMENTO              
      ,lc.TIPODEDOCUMENTO_D            
      ,lc.NRODOCUMENTO                 
      ,lc.NRORUC
      ,ld.DNI_cuentaLyty
      ,lc.NOMBRES                      
      ,lc.APELLIDOPATERNO              
      ,lc.APELLIDOMATERNO              
      ,lc.FECHANACIMIENTO              
      ,lc.EDAD                         
      ,lc.EDAD_RANGO                   
      ,lc.SEXO_TIT                     
      ,lc.SEXO_TIT_D                   
      ,lc.FLAGESTADOCIVIL              
      ,lc.FLAGESTADOCIVIL_D            
      ,lc.FLAGTIENEHIJOS               
      ,lc.FLAGTIENEHIJOS_D             
      ,lc.FLAGTIENETELEFONO            
      ,lc.FLAGTIENETELEFONO_D          
      ,lc.FLAGTIENECORREO              
      ,lc.FLAGTIENECORREO_D            
      ,lc.FLAGCOMPARTEDATOS            
      ,lc.FLAGCOMPARTEDATOS_D          
      ,lc.FLAGAUTCANJE                 
      ,lc.FLAGAUTCANJE_D               
      ,lc.FLAGCLTEFALLECIDO            
      ,lc.FLAGCLTEFALLECIDO_D          
      ,lc.RAZONSOCIAL                  
      ,lc.FECHACREACION_PER            
      ,lc.HORACREACION_PER             
      ,lc.FECHAULTMODIF_PER            
      ,lc.FECHACARGAINICIAL_PER        
      ,lc.FECHACARGAULTMODIF_PER       
      ,lc.CODPOS                       
      ,lc.DIRECCION                    
      ,lc.DEPARTAMENTO                 
      ,lc.PROVINCIA                    
      ,lc.DISTRITO                     
      ,lc.FLAGULTIMO_DIR               
      ,lc.REFERENCIA                   
      ,lc.ESTADO                       
      ,lc.ESTADO_D                     
      ,lc.COORDENADAX                  
      ,lc.COORDENADAY                  
      ,lc.FLAGCOORDENADA               
      ,lc.NSE                          
      ,lc.TELEFONO                     
      ,lc.TELEFONO_D                   
      ,lc.FECHACREACION_TEL            
      ,lc.EMAIL                        
      ,lc.FECHACREACION_EML            
      ,lc.HIJ_AS                       
      ,lc.HIJ_OS                       
      ,lc.HIJ_NN                       
      ,lc.HIJ_TOT
  FROM ods.LYTY_CLI_tmp1 lc LEFT JOIN ods.LYTY_CLI_tmp2 ld 
       ON lc.NRODOCUMENTO = ld.NRODOCUMENTO
 WHERE lc.DNI_Valido = 1;

GO