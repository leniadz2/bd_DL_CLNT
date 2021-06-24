SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [bds].[sp_srv_v1]
AS
/***************************************************************************************************
Procedure:          [bds].[sp_srv]
Create Date:        20210524
Author:             dÁlvarez
Description:        Carga todas las tablas desde SRV
Call by:            none
Affected table(s):  bds.SRV_TABLON
                    bds.SRV_CLI
Used By:            BI
Parameter(s):       none
Log:                ctl.CONTROL
Prerequisites:      tbd
****************************************************************************************************
SUMMARY OF CHANGES
Date(YYYYMMDD)      Author              Comments
------------------- ------------------- ------------------------------------------------------------
20210524            dÁlvarez            creación
20210601            dÁlvarez            lógica dni valida cliente
20210617            dÁlvarez            se agrega CE y RUC

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

  --TABLON-----------------------------

  IF @iVar1 = 1
    BEGIN
      SET @s_fld1 = 'azure';
      EXEC stg.sp_srv_cargaAzure @prceso,@objtnm,@strgFT,@s_fld1,@s_fld2,@strgTim;
      EXEC ods.sp_srv_carga_v1 @prceso,@objtnm,@strgFT,@s_fld1,@s_fld2,@strgTim;
    END
  ELSE IF @iVar1 = 2
    BEGIN
      SET @s_fld1 = 'excel';
      EXEC stg.sp_srv_cargaExcel @prceso,@objtnm,@strgFT,@s_fld1,@s_fld2,@strgTim;
      EXEC ods.sp_srv_carga_v1 @prceso,@objtnm,@strgFT,@s_fld1,@s_fld2,@strgTim;
    END

--  EXEC bds.sp_srv_tablon_v1;
--
--  --CLIENTE-----------------------------
--
--  TRUNCATE TABLE bds.SRV_CLI;
--
--  INSERT INTO bds.SRV_CLI (DNI, RUC, CE, DUIval, NOMBRECLIENTE, DIRECCIONCLIENTE, BONUS)
--  SELECT DISTINCT 
--         DNI,
--         RUC,
--         CE,
--         DUIval,
--         NOMBRECLIENTE, 
--         DIRECCIONCLIENTE, 
--         BONUS
--    FROM bds.SRV_TABLON st;

GO