SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [bds].[sp_srvlty]
AS
  /***************************************************************************************************
  Procedure:          bds.sp_srvlty
  Create Date:        20210523
  Author:             dÁlvarez
  Description:        carga la tabla bds.SRV_LYTY
  Call by:            none
  Affected table(s):  bds.SRV_LYTY
  Used By:            BI
  Parameter(s):       none
  Log:                none
  Prerequisites:      stg.sp_srv_cewData*
                      stg.sp_lty_lytyCli
                      ods.sp_lty_lytyCli
                      bds.sp_srvlty_interfazSAC
  ****************************************************************************************************
  SUMMARY OF CHANGES
  Date(YYYYMMDD)      Author              Comments
  ------------------- ------------------- ------------------------------------------------------------
  20210523            dÁlvarez            creación
  
  ***************************************************************************************************/

  DECLARE @strgFec NVARCHAR(8);
  DECLARE @strgTim NVARCHAR(6);
  DECLARE @strgFT NVARCHAR(14);

  DECLARE @prceso NVARCHAR(50);
  DECLARE @objtnm NVARCHAR(50);
  DECLARE @s_fld1 NVARCHAR(50);
  DECLARE @s_fld2 NVARCHAR(14);
  DECLARE @i_fld1 INT;

  DECLARE @strgTable NVARCHAR(17);
  DECLARE @sqlCommand VARCHAR(5000)

  SET DATEFIRST 1;

  SET @strgFec = CONVERT(VARCHAR, GETDATE(), 112);
  SET @strgTim = REPLACE(CONVERT(VARCHAR, GETDATE(), 108), ':', '');
  SET @strgFT = CONCAT(@strgFec, @strgTim);

  SET @prceso = 'CARGATABLA';
  SET @objtnm = 'stg.LYTY_CLI';


--  ---SRV
--  ------
--  EXEC stg.sp_srv_cewDataAzure;
  EXEC stg.sp_srv_cewDataExcel;
  /*
  stg.SRV_TABLON
  ods.SRV_TABLON
  ods.H_SRV_TABLON
  ods.SRV_TABLON_dlt
  bds.SRV_TABLON
  */


  ---LTY
  ------
--  EXEC stg.sp_lty_lytyCli;
  /*
  stg.LYTY_CLI
  */

--  EXEC ods.sp_lty_lytyCli;
  /*
  ods.LYTY_CLI_1
  ods.LYTY_CLI_2
  ods.LYTY_CLI_3
  */

  ---SRV/LTY
  ----------
  EXEC bds.sp_srvlty_interfazSAC;
  /*
  bds.SRV_LYTY
  */

GO