SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [bds].[sp_srvlty]
AS
  /***************************************************************************************************
  Procedure:          bds.sp_srvlty
  Create Date:        20210523
  Author:             dÁlvarez
  Description:        todo el proceso de tablas LTY/SRV/SRVLTY
  Call by:            none
  Affected table(s):  varias
  Used By:            BI
  Parameter(s):       none
  Log:                none
  Prerequisites:      varios
  ****************************************************************************************************
  SUMMARY OF CHANGES
  Date(YYYYMMDD)      Author              Comments
  ------------------- ------------------- ------------------------------------------------------------
  20210523            dÁlvarez            creación
  
  ***************************************************************************************************/

  ---SRV
  ------
  EXEC bds.sp_srv;
  /*
  stg.SRV_TABLON
  ods.SRV_TABLON
  ods.H_SRV_TABLON
  ods.SRV_TABLON_dlt
  bds.SRV_TABLON
  */
  
  ---LTY
  ------
  EXEC stg.sp_lty_lytyCli;
  /*
  stg.LYTY_CLI
  */
  EXEC ods.sp_lty_lytyCli;
  /*
  ods.LYTY_CLI_1
  ods.LYTY_CLI_2
  ods.LYTY_CLI_3
  */

  ---SRV/LTY
  ----------
  EXEC bds.sp_srvlty_SAC;
  /*
  bds.SRV_LYTY
  */
GO