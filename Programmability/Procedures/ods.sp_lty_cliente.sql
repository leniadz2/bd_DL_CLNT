SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [ods].[sp_lty_cliente]
AS
  /***************************************************************************************************
  Procedure:          ods.sp_lty_cliente
  Create Date:        20210521
  Author:             dÁlvarez
  Description:        carga el maestro de clientes BONUS con las siguientes condiciones:
                       - Solo los que tienen la tarjeta BONUS más antigua
                       - Solo los que tienen número DNI válido.
                      Además crea un campo contador de DNI (muestra errores (mayores a uno))
  Call by:            none
  Affected table(s):  ods.LYTY_CLI_tmp1
                      ods.LYTY_CLI_tmp2
  Used By:            BI
  Parameter(s):       none
  Log:                none
  Prerequisites:      stg.sp_lty_lytyCli
  ****************************************************************************************************
  SUMMARY OF CHANGES
  Date(YYYYMMDD)      Author              Comments
  ------------------- ------------------- ------------------------------------------------------------
  20210521            dÁlvarez            creación
  20210601            dÁlvarez            simplificacion lógica
  
  ***************************************************************************************************/

TRUNCATE TABLE ods.LYTY_CLI_tmp1;

INSERT INTO ods.LYTY_CLI_tmp1
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
      ,ods.fn_validaDNI(lc.NRODOCUMENTO) AS DNI_Valido
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

TRUNCATE TABLE ods.LYTY_CLI_tmp2;

INSERT INTO ods.LYTY_CLI_tmp2
SELECT lc.NRODOCUMENTO                 
      ,COUNT(NRODOCUMENTO) AS DNI_cuentaLyty
  FROM ods.LYTY_CLI_1 lc
 WHERE lc.DNI_Valido = 1
 GROUP BY lc.NRODOCUMENTO;

GO