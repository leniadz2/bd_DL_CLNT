SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [ods].[sp__cliente_unico]
AS
/***************************************************************************************************
Procedure:          [ods].sp__cliente_unico
Create Date:        20210525
Author:             dÁlvarez
Description:        Carga la tabla del cliente, unificando fuentes
Call by:            none
Affected table(s):  ods.ADI_CLIENTE
Used By:            BI
Parameter(s):       none
Log:                ctl.CONTROL
Prerequisites:      tbd
****************************************************************************************************
SUMMARY OF CHANGES
Date(YYYYMMDD)      Author              Comments
------------------- ------------------- ------------------------------------------------------------
20210525            dÁlvarez            creación

***************************************************************************************************/

  DECLARE @strgFec NVARCHAR(8);
  DECLARE @strgTim NVARCHAR(6);
  DECLARE @strgFT NVARCHAR(14);
  DECLARE @iVar1 INT;

  --control
  DECLARE @prceso NVARCHAR(50);
  DECLARE @objtnm NVARCHAR(50);
  DECLARE @s_fld1 NVARCHAR(50);
  DECLARE @s_fld2 NVARCHAR(14);
  DECLARE @i_fld1 INT;

  SET DATEFIRST 1;

  SET @strgFec = CONVERT(VARCHAR, GETDATE(), 112);
  SET @strgTim = REPLACE(CONVERT(VARCHAR, GETDATE(), 108), ':', '');
  /*--carga manual de fechas
  SET @strgFec = '20219988';
  SET @strgTim = '242322';
  */
  SET @strgFT  = CONCAT(@strgFec,@strgTim);

  SET @prceso = 'CARGATABLA';
  SET @objtnm = 'SRV_TABLON';

  --SET @iVar1 = 1;-- valor 1 = la carga proviende de azure
  SET @iVar1 = 2;-- valor 2 = la carga proviende de excel

  TRUNCATE TABLE ods.ADI_CLIENTE;

  --LYTY-----------------------------

  INSERT INTO ods.ADI_CLIENTE( FUENTE,
                               NUMTARJETABONUS    ,
                               TIPOTARJETA        ,
                               ORDTARJETABONUS    ,
                               CODIGOTIPOPERSONA  ,
                               CODIGOTIPOPERSONA_D,
                               TIPODEDOCUMENTO    ,
                               TIPODEDOCUMENTO_D  ,
                               RUC                ,
                               NRODOCUMENTO       ,
                               RAZONSOCIAL_BONUS  ,
                               APELLIDOPATERNO    ,
                               APELLIDOMATERNO    ,
                               NOMBRES            ,
                               FECHANACIMIENTO_S  ,
                               DIRECCION1         ,
                               REFERENCIA         ,
                               DISTRITO           ,
                               PROVINCIA          ,
                               DEPARTAMENTO       ,
                               LATITUD            ,
                               LONGITUD           ,
                               TELEFONO1          ,
                               TELEFONO_D         ,
                               HIJ_AS             ,
                               HIJ_OS             ,
                               HIJ_NN             ,
                               HIJ_TOT            ,
                               NIVELSOCIOECONOMICO,
                               COD_SUBR_FUENTE)
  SELECT 'LYTY',
         NUMTARJETABONUS      ,
         TIPOTARJETA          ,
         ORDTARJETABONUS      ,
         CODIGOTIPOPERSONA    ,
         CODIGOTIPOPERSONA_D  ,
         TIPODEDOCUMENTO      ,
         TIPODEDOCUMENTO_D    ,
         NRORUC               ,
         NRODOCUMENTO         ,
         RAZONSOCIAL          ,
         APELLIDOPATERNO      ,
         APELLIDOMATERNO      ,
         NOMBRES              ,
         FECHANACIMIENTO      ,
         DIRECCION            ,
         REFERENCIA           ,
         DISTRITO             ,
         PROVINCIA            ,
         DEPARTAMENTO         ,
         COORDENADAX          ,
         COORDENADAY          ,
         TELEFONO             ,
         TELEFONO_D           ,
         HIJ_AS               ,
         HIJ_OS               ,
         HIJ_NN               ,
         HIJ_TOT              ,
         NSE                  ,
         CODIGOPERSONA
    FROM bds.LYTY_CLI
   WHERE ods.fn_validaDNI(NRODOCUMENTO) = 1;

  --ICG------------------------------

  INSERT INTO ods.ADI_CLIENTE(FUENTE,
                              NRODOCUMENTO       ,
                              NOMBRECOMERCIAL_ICG,
                              NOMBRECLIENTE      ,
                              DIRECCION1         ,
                              POBLACION          ,
                              PROVINCIA          ,
                              PAIS               ,
                              CODPOSTAL          ,
                              TELEFONO1          ,
                              TELEFONO2          ,
                              CORREO             ,
                              ALIAS              ,
                              PERSONACONTACTO    ,
                              CODCONTABLE        ,
                              COD_SUBR_FUENTE    ,
                              COD_EMPRESA_DMVTAS)
  SELECT 'ICG',
         CIF            ,
         NOMBRECOMERCIAL,
         NOMBRECLIENTE  ,
         DIRECCION1     ,
         POBLACION      ,
         PROVINCIA      ,
         PAIS           ,
         CODPOSTAL      ,
         TELEFONO1      ,
         TELEFONO2      ,
         E_MAIL         ,
         ALIAS          ,
         PERSONACONTACTO,
         CODCONTABLE    ,
         COD_CLIENTE,
         COD_EMPRESA
    FROM stg.ICG_CLI
   WHERE ods.fn_validaDNI(CIF) = 1;

  --SRV------------------------------

  INSERT INTO ods.ADI_CLIENTE(
                FUENTE,
                NUMTARJETABONUS  ,
                RUC              ,
                NRODOCUMENTO     ,
                NOMBRECLIENTE_SRV,
                DIRECCION1)
  SELECT 'SRV',
         BONUS        ,
         RUC          ,
         DNI          ,
         NOMBRECLIENTE,
         DIRECCIONCLIENTE
    FROM bds.SRV_CLI
   WHERE ods.fn_validaDNI(DNI) = 1;

  --MKT------------------------------

  INSERT INTO ods.ADI_CLIENTE( FUENTE,
                               NRODOCUMENTO     ,
                               APELLIDOS        ,
                               NOMBRES          ,
                               NOMBRECLIENTE    ,
                               FECHANACIMIENTO_D,
                               SEXO             ,
                               DIRECCION1       ,
                               DISTRITO         ,
                               TELEFONO1        ,
                               CORREO           ,
                               NIVELSOCIOECONOMICO )
  SELECT 'MKT',
         DOCUMENTOIDENTIFICACION,
         APELLIDOS              ,
         NOMBRE                 ,
         NOMBRECOMPLETO         ,
         FECHANACIMIENTO        ,
         SEXO                   ,
         DIRECCION              ,
         DISTRITO               ,
         TELEFONO               ,
         CORREO                 ,
         NIVELSOCIOECONOMICO
    FROM stg.MKT_CLI
   WHERE ods.fn_validaDNI(DOCUMENTOIDENTIFICACION) = 1;

  --SAP------------------------------

  INSERT INTO ods.ADI_CLIENTE( FUENTE,
                               NRODOCUMENTO     ,
                               NOMBRECLIENTE    ,
                               DIRECCION1       ,
                               DISTRITO         ,
                               TELEFONO1        )
SELECT 'SAP'
      ,NIF
      ,NOMBRE
      ,CALLE
      ,DISTRITO
      ,TELEFONO
  FROM ods.SAP_CLI
 WHERE ods.fn_validaDNI(NIF) = 1;

GO