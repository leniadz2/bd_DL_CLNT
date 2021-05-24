SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [stg].[sp_srv_cewDataExcel]
AS
/***************************************************************************************************
Procedure:          stg.sp_carga_cewDataExcel
Create Date:        20210520
Author:             dÁlvarez
Description:        carga el reporte cew_data (GVillacorta) del excel.
Call by:            none
Affected table(s):  bds.SRV_TABLON
Used By:            BI
Parameter(s):       none
Log:                ctl.CONTROL
Prerequisites:      En caso del archivo Excel, debe importarse previamente con dbforge
****************************************************************************************************
SUMMARY OF CHANGES
Date(YYYYMMDD)      Author              Comments
------------------- ------------------- ------------------------------------------------------------
20210520            dÁlvarez            creación

***************************************************************************************************/

  DECLARE @strgFec NVARCHAR(8);
  DECLARE @strgTim NVARCHAR(6);
  DECLARE @strgFT NVARCHAR(14);

  DECLARE @prceso NVARCHAR(50);
  DECLARE @objtnm NVARCHAR(50);
  DECLARE @s_fld1 NVARCHAR(50);
  DECLARE @s_fld2 NVARCHAR(14);
  DECLARE @i_fld1 INT;

  SET DATEFIRST 1;

  SET @strgFec = CONVERT(VARCHAR, GETDATE(), 112);
  SET @strgTim = REPLACE(CONVERT(VARCHAR, GETDATE(), 108), ':', '');
  --SET @strgFec = '20219988';
  --SET @strgTim = '242322';
  SET @strgFT  = CONCAT(@strgFec,@strgTim);

  SET @prceso = 'CARGATABLA';
  SET @objtnm = 'SRV_TABLON';
  SET @s_fld1 = 'excel';

  SELECT @s_fld2 = MAX(FECHOR) FROM ctl.CONTROL WHERE PRCESO = @prceso AND OBJTNM = @objtnm;

  INSERT INTO ctl.CONTROL(PRCESO, OBJTNM, FECHOR, S_FLD1, S_FLD2, S_FLD9)
  VALUES(@prceso,@objtnm,@strgFT,@s_fld1,@s_fld2 ,@strgTim);

  TRUNCATE TABLE stg.SRV_TABLON;

  INSERT INTO stg.SRV_TABLON (ID,
                              NOMBRE,
                              RAZONSOCIAL,
                              NOMBRETIENDA,
                              CODIGOMALL,
                              CODIGOTIENDA,
                              RUCEMISOR,
                              IDENTIFICADORTERMINAL,
                              NUMEROTERMINAL,
                              SERIE,
                              TIPOTRANSACCION,
                              NUMEROTRANSACCION,
                              FECHA,
                              HORA,
                              CAJERO,
                              VENDEDOR,
                              DNI,
                              RUC,
                              NOMBRECLIENTE,
                              DIRECCIONCLIENTE,
                              BONUS,
                              MONEDA,
                              MEDIOPAGO,
                              TOTALVALORVENTABRUTA,
                              DESCUENTOSGLOBAL,
                              MONTOTOTALIGV,
                              TOTALVALORVENTANETA,
                              ORDENITEM,
                              CANTIDADUNIDADESITEM,
                              CODIGOPRODUCTO,
                              DESCRIPCIONPRODUCTO,
                              PRECIOVENTAUNITARIOITEM,
                              CARGODESCUENTOITEM,
                              PRECIOTOTALITEM)
    SELECT
      CAST(cd.ID AS VARCHAR(30)) AS c01
     ,CAST(cd.[Nombre] AS VARCHAR(50)) AS c02
     ,CAST(cd.[Razón social] AS VARCHAR(50)) AS c03
     ,CAST(cd.NombreTienda AS VARCHAR(50)) AS c04
     ,CAST(cd.CodigoMall AS VARCHAR(2)) AS c05
     ,CAST(cd.CodigoTienda AS VARCHAR(4)) AS c06
     ,CAST(cd.RucEmisor AS VARCHAR(11)) AS c07
     ,CAST(cd.IdentificadorTerminal AS VARCHAR(10)) AS c08
     ,CAST(cd.NumeroTerminal AS VARCHAR(10)) AS c09
     ,CAST(cd.Serie AS VARCHAR(10)) AS c10
     ,CAST(cd.TipoTransaccion AS VARCHAR(4)) AS c11
     ,CAST(cd.NumeroTransaccion AS VARCHAR(10)) AS c12
     ,CAST(cd.Fecha AS VARCHAR(20)) AS c13
     ,CAST(cd.Hora AS VARCHAR(20)) AS c14
     ,CAST(cd.Cajero AS VARCHAR(20)) AS c15
     ,CAST(cd.Vendedor AS VARCHAR(20)) AS c16
     ,CAST(cd.DNI AS VARCHAR(11)) AS c17
     ,CAST(cd.RUC AS VARCHAR(11)) AS c18
     ,REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(cast(cd.[NombreCliente] as varchar(100)), '&amp;','&'), CHAR(13),';'), CHAR(10),';'), CHAR(9),';'), '|',' '), '"','') as c19
     ,REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(cast(cd.[DireccionCliente] as varchar(200)), CHAR(13),';'), CHAR(10),';'), CHAR(9),';'), '|',' '), '"','') as c20
     ,cast(cd.[Bonus]                 as varchar(10))  as c21
     ,cast(cd.Moneda                  as varchar(10))  as c22
     ,cast(cd.MedioPago               as varchar(10))  as c23
     ,CONVERT(DECIMAL(18,2),CONVERT(float,cd.TotalValorVentaBruta))         as c24
     ,CONVERT(DECIMAL(18,2),CONVERT(float,cd.[DescuentosGlobal]))           as c25
     ,CONVERT(DECIMAL(18,2),CONVERT(float,cd.MontoTotalIgv))                as c26
     ,CONVERT(DECIMAL(18,2),CONVERT(float,cd.TotalValorVentaNeta))          as c27
     ,cast(cd.[OrdenItem]             as varchar(20))  as c28
     ,CONVERT(DECIMAL(18,2),CONVERT(float,cd.CantidadUnidadesItem))         as c29
     ,cast(cd.CodigoProducto          as varchar(50))  as c30
     ,REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(cast(cd.DescripcionProducto as varchar(100)), CHAR(13),';'), CHAR(10),';'), CHAR(9),';'), '|',' '), '"','') as c31
     ,CONVERT(DECIMAL(18,2),CONVERT(float,cd.PrecioVentaUnitarioItem))      as c32
     ,CONVERT(DECIMAL(18,2),CONVERT(float,cd.CargoDescuentoItem))           as c33
     ,CONVERT(DECIMAL(18,2),CONVERT(float,cd.PrecioTotalItem))              as c34
    FROM [BD_SRV].tmp.[excel_cewData] cd;

  TRUNCATE TABLE ods.SRV_TABLON;

  INSERT INTO ods.SRV_TABLON
  SELECT IIF(ID                     ='',NULL,ID                     )
        ,IIF(NOMBRE                 ='',NULL,UPPER(NOMBRE)          )
        ,IIF(RAZONSOCIAL            ='',NULL,UPPER(RAZONSOCIAL)     )
        ,IIF(NOMBRETIENDA           ='',NULL,UPPER(NOMBRETIENDA)    )
        ,IIF(CODIGOMALL             ='',NULL,RIGHT(CONCAT('00',CODIGOMALL),2)             )
        ,IIF(CODIGOTIENDA           ='',NULL,RIGHT(CONCAT('0000',CODIGOTIENDA),4)         )
        ,IIF(RUCEMISOR              ='',NULL,RUCEMISOR              )
        ,IIF(IDENTIFICADORTERMINAL  ='',NULL,IDENTIFICADORTERMINAL  )
        ,IIF(NUMEROTERMINAL         ='',NULL,NUMEROTERMINAL         )
        ,IIF(SERIE                  ='',NULL,SERIE                  )
        ,IIF(TIPOTRANSACCION        ='',NULL,RIGHT(CONCAT('00',TIPOTRANSACCION),2)        )
        ,IIF(NUMEROTRANSACCION      ='',NULL,NUMEROTRANSACCION      )
        ,IIF(FECHA                  ='',NULL,LEFT(FECHA,10)         )
        ,IIF(HORA                   ='',NULL,HORA                   )
        ,IIF(CAJERO                 ='',NULL,CAJERO                 )
        ,IIF(VENDEDOR               ='',NULL,VENDEDOR               )
        ,IIF(DNI                    ='',NULL,DNI                    )
        ,IIF(RUC                    ='',NULL,RUC                    )
        ,IIF(NOMBRECLIENTE          ='',NULL,UPPER(NOMBRECLIENTE)   )
        ,IIF(DIRECCIONCLIENTE       ='',NULL,UPPER(DIRECCIONCLIENTE))
        ,IIF(BONUS                  ='',NULL,BONUS                  )
        ,IIF(MONEDA                 ='',NULL,MONEDA                 )
        ,IIF(MEDIOPAGO              ='',NULL,MEDIOPAGO              )
        ,TOTALVALORVENTABRUTA
        ,DESCUENTOSGLOBAL
        ,MONTOTOTALIGV
        ,TOTALVALORVENTANETA
        ,IIF(ORDENITEM              ='',NULL,ORDENITEM              )
        ,CANTIDADUNIDADESITEM
        ,IIF(CODIGOPRODUCTO         ='',NULL,CODIGOPRODUCTO         )
        ,IIF(DESCRIPCIONPRODUCTO    ='',NULL,UPPER(DESCRIPCIONPRODUCTO))
        ,PRECIOVENTAUNITARIOITEM
        ,CARGODESCUENTOITEM
        ,PRECIOTOTALITEM
        ,@strgFT
   FROM stg.SRV_TABLON;

  INSERT INTO ods.H_SRV_TABLON
  SELECT *, @s_fld1
    FROM ods.SRV_TABLON;

  SELECT @i_fld1 = COUNT(*) FROM ods.SRV_TABLON;

  UPDATE ctl.CONTROL
    SET S_FLD9 = REPLACE(CONVERT(VARCHAR, GETDATE(), 108), ':', ''),
        I_FLD1 = @i_fld1
  WHERE PRCESO = @prceso
    AND OBJTNM = @objtnm
    AND FECHOR = @strgFT
    AND S_FLD1 = @s_fld1;

  TRUNCATE TABLE ods.SRV_TABLON_dlt;

  INSERT INTO ods.SRV_TABLON_dlt
  SELECT t.*
  FROM (
  SELECT st.ID
        ,st.ORDENITEM
    FROM ods.SRV_TABLON st
  EXCEPT
  SELECT hst.ID
        ,hst.ORDENITEM
    FROM ods.H_SRV_TABLON hst INNER JOIN ctl.CONTROL AS c
      ON hst.FHCARGA = c.S_FLD2
   WHERE c.FECHOR = (SELECT MAX(FECHOR) FROM ctl.CONTROL WHERE PRCESO = 'CARGATABLA' AND OBJTNM = 'SRV_TABLON')
    ) AS t;

  INSERT INTO bds.SRV_TABLON
  SELECT st.*
    FROM ods.SRV_TABLON st INNER JOIN ods.SRV_TABLON_dlt std ON st.id = std.ID AND st.ORDENITEM = std.ORDENITEM;

GO