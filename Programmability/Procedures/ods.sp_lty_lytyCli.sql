SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [ods].[sp_lty_lytyCli]
AS
  /***************************************************************************************************
  Procedure:          ods.sp_lty_lytyCli
  Create Date:        20210521
  Author:             dÁlvarez
  Description:        carga el maestro de clientes BONUS con las siguientes condiciones:
                       - Solo los que tienen la tarjeta BONUS más antigua
                       - Solo los que tienen número DNI válido.
                      Además crea un campo contador de DNI (muestra errores (mayores a uno))
  Call by:            none
  Affected table(s):  ods.LYTY_CLI_1
                      ods.LYTY_CLI_2
                      ods.LYTY_CLI_3
  Used By:            BI
  Parameter(s):       none
  Log:                none
  Prerequisites:      stg.sp_lty_lytyCli
  ****************************************************************************************************
  SUMMARY OF CHANGES
  Date(YYYYMMDD)      Author              Comments
  ------------------- ------------------- ------------------------------------------------------------
  20210521            dÁlvarez            creación
  
  ***************************************************************************************************/

TRUNCATE TABLE ods.LYTY_CLI_1;

INSERT INTO ods.LYTY_CLI_1
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
--      ,CASE
--        WHEN lc.NRODOCUMENTO IS NULL THEN '0'
--        WHEN lc.NRODOCUMENTO = '' THEN '0'
--        WHEN LEN(lc.NRODOCUMENTO) <> 8 THEN '0'
--        WHEN lc.NRODOCUMENTO like '00%' THEN '0'
--        WHEN (SUBSTRING(lc.NRODOCUMENTO,1,2)=SUBSTRING(lc.NRODOCUMENTO,3,2)) and (SUBSTRING(lc.NRODOCUMENTO,1,2)=SUBSTRING(lc.NRODOCUMENTO,5,2)) and (SUBSTRING(lc.NRODOCUMENTO,1,2)=SUBSTRING(lc.NRODOCUMENTO,7,2)) THEN '0'
--       ELSE '1'
--       END AS DNI_Valido
      ,ods.fc_validaDNI(lc.NRODOCUMENTO) AS DNI_Valido
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
  FROM stg.LYTY_CLI lc
 WHERE lc.ORDTARJETABONUS = 1;

TRUNCATE TABLE ods.LYTY_CLI_2;

INSERT INTO ods.LYTY_CLI_2
SELECT lc.NRODOCUMENTO                 
      ,COUNT(NRODOCUMENTO) AS DNI_cuentaLyty
  FROM ods.LYTY_CLI_1 lc
 WHERE lc.DNI_Valido = 1
 GROUP BY lc.NRODOCUMENTO;

  /*
  WITH t AS (
  SELECT lc.NRODOCUMENTO
        ,CASE
           WHEN lc.NRODOCUMENTO IS NULL THEN '0'
           WHEN lc.NRODOCUMENTO = '' THEN '0'
           WHEN LEN(lc.NRODOCUMENTO) <> 8 THEN '0'
           WHEN lc.NRODOCUMENTO like '00%' THEN '0'
           WHEN (SUBSTRING(lc.NRODOCUMENTO,1,2)=SUBSTRING(lc.NRODOCUMENTO,3,2)) and (SUBSTRING(lc.NRODOCUMENTO,1,2)=SUBSTRING(lc.NRODOCUMENTO,5,2)) and (SUBSTRING(lc.NRODOCUMENTO,1,2)=SUBSTRING(lc.NRODOCUMENTO,7,2)) THEN '0'
           ELSE '1'
         END AS DNI_Valido
        ,COUNT(NRODOCUMENTO) AS DNI_cuentaLyty
    FROM ods.LYTY_CLI_1 lc
   GROUP BY lc.NRODOCUMENTO)
  SELECT ld.* 
    FROM ods.LYTY_CLI_1 ld
   WHERE ld.NRODOCUMENTO IN (SELECT NRODOCUMENTO FROM t WHERE DNI_Valido = 1 AND DNI_cuentaLyty > 1)
   ORDER BY ld.NRODOCUMENTO;
  */

TRUNCATE TABLE ods.LYTY_CLI_3;

INSERT INTO ods.LYTY_CLI_3
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
  FROM ods.LYTY_CLI_1 lc LEFT JOIN ods.LYTY_CLI_2 ld 
       ON lc.NRODOCUMENTO = ld.NRODOCUMENTO
 WHERE lc.DNI_Valido = 1;


GO