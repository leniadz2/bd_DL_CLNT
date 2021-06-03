﻿CREATE TABLE [ods].[xLYTY_CLI_3] (
  [CODIGOPERSONA] [varchar](10) NOT NULL,
  [ORDTARJETABONUS] [int] NOT NULL,
  [NUMTARJETABONUS] [varchar](19) NOT NULL,
  [TIPOTARJETA] [varchar](20) NULL,
  [CODIGOTIPOPERSONA] [varchar](2) NULL,
  [CODIGOTIPOPERSONA_D] [varchar](8) NULL,
  [TIPODEDOCUMENTO] [varchar](4) NULL,
  [TIPODEDOCUMENTO_D] [varchar](11) NULL,
  [NRODOCUMENTO] [varchar](15) NULL,
  [NRORUC] [varchar](11) NULL,
  [DNI_cuentaLyty] [int] NULL,
  [NOMBRES] [varchar](100) NULL,
  [APELLIDOPATERNO] [varchar](50) NULL,
  [APELLIDOMATERNO] [varchar](50) NULL,
  [FECHANACIMIENTO] [varchar](8) NULL,
  [EDAD] [int] NULL,
  [EDAD_RANGO] [varchar](13) NULL,
  [SEXO_TIT] [varchar](1) NULL,
  [SEXO_TIT_D] [varchar](11) NULL,
  [FLAGESTADOCIVIL] [varchar](1) NULL,
  [FLAGESTADOCIVIL_D] [varchar](11) NULL,
  [FLAGTIENEHIJOS] [varchar](1) NULL,
  [FLAGTIENEHIJOS_D] [varchar](2) NULL,
  [FLAGTIENETELEFONO] [varchar](1) NULL,
  [FLAGTIENETELEFONO_D] [varchar](2) NULL,
  [FLAGTIENECORREO] [varchar](1) NULL,
  [FLAGTIENECORREO_D] [varchar](2) NULL,
  [FLAGCOMPARTEDATOS] [varchar](1) NULL,
  [FLAGCOMPARTEDATOS_D] [varchar](2) NULL,
  [FLAGAUTCANJE] [varchar](1) NULL,
  [FLAGAUTCANJE_D] [varchar](2) NULL,
  [FLAGCLTEFALLECIDO] [varchar](1) NULL,
  [FLAGCLTEFALLECIDO_D] [varchar](2) NULL,
  [RAZONSOCIAL] [varchar](50) NULL,
  [FECHACREACION_PER] [varchar](8) NULL,
  [HORACREACION_PER] [varchar](8) NULL,
  [FECHAULTMODIF_PER] [varchar](8) NULL,
  [FECHACARGAINICIAL_PER] [varchar](8) NULL,
  [FECHACARGAULTMODIF_PER] [varchar](8) NULL,
  [CODPOS] [varchar](6) NULL,
  [DIRECCION] [varchar](150) NULL,
  [DEPARTAMENTO] [varchar](25) NULL,
  [PROVINCIA] [varchar](25) NULL,
  [DISTRITO] [varchar](25) NULL,
  [FLAGULTIMO_DIR] [varchar](1) NULL,
  [REFERENCIA] [varchar](150) NULL,
  [ESTADO] [varchar](1) NULL,
  [ESTADO_D] [varchar](6) NULL,
  [COORDENADAX] [varchar](20) NULL,
  [COORDENADAY] [varchar](20) NULL,
  [FLAGCOORDENADA] [varchar](1) NULL,
  [NSE] [varchar](1) NULL,
  [TELEFONO] [varchar](10) NULL,
  [TELEFONO_D] [varchar](10) NULL,
  [FECHACREACION_TEL] [varchar](8) NULL,
  [EMAIL] [varchar](100) NULL,
  [FECHACREACION_EML] [varchar](8) NULL,
  [HIJ_AS] [int] NULL,
  [HIJ_OS] [int] NULL,
  [HIJ_NN] [int] NULL,
  [HIJ_TOT] [int] NULL
)
ON [PRIMARY]
GO