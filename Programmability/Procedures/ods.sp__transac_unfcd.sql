SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [ods].[sp__transac_unfcd]
AS
/***************************************************************************************************
Procedure:          [ods].sp__transac_unfcd
Create Date:        20210525
Author:             dÁlvarez
Description:        Carga la tabla de transacciones, unificando fuentes
Call by:            none
Affected table(s):  ods.ARA_TRANSAC
Used By:            BI
Parameter(s):       none
Log:                tbd
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

  TRUNCATE TABLE ods.ARA_TRANSAC;

  --LYTY-----------------------------

  INSERT INTO ods.ARA_TRANSAC (FUENTE,
                DNI,
                NUMTARJETABONUS      ,
                FECHA                ,
                HORA                 ,
                NOMBRETIENDA         ,
                UBICACION            ,
                CODIGOTIENDA_BONUS   ,
                PLU_BONUS            ,
                CANTIDADUNIDADESITEM ,
                PRECIOTOTALITEM      ,
                TOTALVALORVENTABRUTA)
      SELECT 'LYTY'        ,
              lc.NRODOCUMENTO,
              lt.NUMTARJETABONUS     ,
              lt.FECHATRANSACCION_CAB,
              lt.HORATRANSACCION_CAB ,
              lt.CODIGODELOCAL       ,
              lt.CODIGODEPARTICIPANTE,
              lt.CODIGODEPARTICIPANTE,
              lt.PLU                 ,
              lt.CANTIDADNUM         ,
              lt.MONTOPARCIALNUM     ,
              lt.MONTOTOTALNUM       
  FROM stg.LYTY_TRANSACCION lt LEFT JOIN bds.LYTY_CLI lc ON lt.NUMTARJETABONUS = lc.NUMTARJETABONUS;

  --ICG------------------------------

  INSERT INTO ods.ARA_TRANSAC (fuente,
                DNI,
                RUC,
                COD_CLIENTE_ICG,
                FECHA,
                NEGOCIO,
                NOMBRETIENDA,
                UBICACION,
                CODIGOCENTRO_ICG,
                CODARTICULO_ICG,
                DESCRIPCIONPRODUCTO,
                CANTIDADUNIDADESITEM,
                PRECIOTOTALITEM,
                TOTALVALORVENTANETA,
                MONTOTOTALIGV,
                TOTALVALORVENTABRUTA,
                MONEDA)
    SELECT 'ICG'
           ,IIF(LEN(c.cif) = 8, c.cif, NULL) AS d
           ,IIF(LEN(c.cif) = 11, c.cif, NULL) AS r
           ,t.COD_CLIENTE
           ,t.FECHA
           ,t.NEGOCIO
           ,t.NOM_TIENDA
           ,t.UBICACION
           ,t.centro
           ,t.CODARTICULO
           ,ai.DESCRIPCION
           ,t.UNIDADESTOTAL
           ,t.TOTAL_L
           ,t.BASE
           ,t.IMPUESTO
           ,t.TOTAL
           ,'PEN' AS m
      FROM stg.ICG_TRANSACCION AS t
             INNER JOIN stg.ICG_CLI AS c
               ON c.COD_CLIENTE = t.COD_CLIENTE
              AND c.COD_EMPRESA = t.COD_EMPRESA
             LEFT JOIN stg.ICG_ARTICULOS AS ai
               ON ai.COD_EMPRESA = t.COD_EMPRESA
              AND ai.CODARTICULO = t.CODARTICULO
     WHERE t.TVENTA = 'BASE'
       AND LEN(c.cif) = 8
        OR LEN(c.cif) = 11;

  --SRV------------------------------REVISAR cambio por bds!

--  INSERT INTO ods.ARA_TRANSAC (FUENTE,
--                DNI,
--                RUC,
--                FECHA,
--                HORA,
--                RAZONSOCIAL,
--                RUCEMISOR,
--                NOMBRETIENDA,
--                UBICACION,
--                CODIGOTIENDA_SRV,
--                CODIGOPRODUCTO_SRV,
--                DESCRIPCIONPRODUCTO,
--                CANTIDADUNIDADESITEM,
--                PRECIOVENTAUNITARIOITEM,
--                CARGODESCUENTOITEM,
--                PRECIOTOTALITEM,
--                TOTALVALORVENTANETA,
--                MONTOTOTALIGV,
--                DESCUENTOSGLOBAL,
--                TOTALVALORVENTABRUTA,
--                MONEDA)
--      SELECT 'SRV'
--             ,DNI
--             ,RUC
--             ,FECHA
--             ,HORA
--             ,RAZONSOCIAL
--             ,RUCEMISOR
--             ,NOMBRETIENDA
--             ,CODIGOMALL
--             ,CODIGOTIENDA
--             ,CODIGOPRODUCTO
--             ,DESCRIPCIONPRODUCTO
--             ,CONVERT(FLOAT, CANTIDADUNIDADESITEM)
--             ,CONVERT(FLOAT, PRECIOVENTAUNITARIOITEM)
--             ,CONVERT(FLOAT, CARGODESCUENTOITEM)
--             ,CONVERT(FLOAT, PRECIOTOTALITEM)
--             ,CONVERT(FLOAT, TOTALVALORVENTANETA)
--             ,CONVERT(FLOAT, MONTOTOTALIGV)
--             ,CONVERT(FLOAT, DESCUENTOSGLOBAL)
--             ,CONVERT(FLOAT, TOTALVALORVENTABRUTA)
--             ,MONEDA
--        FROM stg.SRV_TABLON;

  --MKT------------------------------

  --none

GO