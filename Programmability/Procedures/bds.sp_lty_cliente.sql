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
SELECT *
  FROM ods.LYTY_CLI_tmp4;

GO