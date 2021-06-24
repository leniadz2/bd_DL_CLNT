﻿CREATE TABLE [bds].[SRVLYTY_FAIL] (
  [srv_ID] [varchar](30) NULL,
  [srv_NOMBRE] [varchar](50) NULL,
  [srv_RAZONSOCIAL] [varchar](50) NULL,
  [srv_NOMBRETIENDA] [varchar](50) NULL,
  [srv_CODIGOMALL] [varchar](2) NULL,
  [srv_CODIGOTIENDA] [varchar](4) NULL,
  [srv_RUCEMISOR] [varchar](11) NULL,
  [srv_IDENTIFICADORTERMINAL] [varchar](10) NULL,
  [srv_NUMEROTERMINAL] [varchar](10) NULL,
  [srv_SERIE] [varchar](10) NULL,
  [srv_TIPOTRANSACCION] [varchar](4) NULL,
  [srv_NUMEROTRANSACCION] [varchar](10) NULL,
  [srv_FECHA] [varchar](20) NULL,
  [srv_HORA] [varchar](20) NULL,
  [srv_CAJERO] [varchar](20) NULL,
  [srv_VENDEDOR] [varchar](20) NULL,
  [srv_DNI] [varchar](11) NULL,
  [srv_RUC] [varchar](11) NULL,
  [srv_CE] [varchar](11) NULL,
  [srv_DUIval] [varchar](1) NULL,
  [DUI] [varchar](11) NULL,
  [srv_NOMBRECLIENTE] [varchar](100) NULL,
  [srv_DIRECCIONCLIENTE] [varchar](200) NULL,
  [srv_BONUS] [varchar](20) NULL,
  [srv_MONEDA] [varchar](10) NULL,
  [srv_MEDIOPAGO] [varchar](10) NULL,
  [srv_TOTALVALORVENTABRUTA] [decimal](18, 2) NULL,
  [srv_DESCUENTOSGLOBAL] [decimal](18, 2) NULL,
  [srv_MONTOTOTALIGV] [decimal](18, 2) NULL,
  [srv_TOTALVALORVENTANETA] [decimal](18, 2) NULL,
  [srv_ORDENITEM] [varchar](20) NULL,
  [srv_CANTIDADUNIDADESITEM] [decimal](18, 2) NULL,
  [srv_CODIGOPRODUCTO] [varchar](50) NULL,
  [srv_DESCRIPCIONPRODUCTO] [varchar](100) NULL,
  [srv_PRECIOVENTAUNITARIOITEM] [decimal](18, 2) NULL,
  [srv_CARGODESCUENTOITEM] [decimal](18, 2) NULL,
  [srv_PRECIOTOTALITEM] [decimal](18, 2) NULL,
  [lty_CODIGOPERSONA] [varchar](10) NULL,
  [lty_ORDTARJETABONUS] [int] NULL,
  [lty_NUMTARJETABONUS] [varchar](19) NULL,
  [lty_TIPOTARJETA] [varchar](20) NULL,
  [lty_CODIGOTIPOPERSONA] [varchar](2) NULL,
  [lty_CODIGOTIPOPERSONA_D] [varchar](8) NULL,
  [lty_TIPODEDOCUMENTO] [varchar](4) NULL,
  [lty_TIPODEDOCUMENTO_D] [varchar](11) NULL,
  [lty_NRODOCUMENTO] [varchar](15) NULL,
  [lty_NRORUC] [varchar](11) NULL,
  [lty_NOMBRES] [varchar](100) NULL,
  [lty_APELLIDOPATERNO] [varchar](50) NULL,
  [lty_APELLIDOMATERNO] [varchar](50) NULL,
  [lty_FECHANACIMIENTO] [varchar](8) NULL,
  [lty_EDAD] [int] NULL,
  [lty_EDAD_RANGO] [varchar](13) NULL,
  [lty_SEXO_TIT] [varchar](1) NULL,
  [lty_SEXO_TIT_D] [varchar](11) NULL,
  [lty_FLAGESTADOCIVIL] [varchar](1) NULL,
  [lty_FLAGESTADOCIVIL_D] [varchar](11) NULL,
  [lty_FLAGTIENEHIJOS] [varchar](1) NULL,
  [lty_FLAGTIENEHIJOS_D] [varchar](2) NULL,
  [lty_FLAGTIENETELEFONO] [varchar](1) NULL,
  [lty_FLAGTIENETELEFONO_D] [varchar](2) NULL,
  [lty_FLAGTIENECORREO] [varchar](1) NULL,
  [lty_FLAGTIENECORREO_D] [varchar](2) NULL,
  [lty_FLAGCOMPARTEDATOS] [varchar](1) NULL,
  [lty_FLAGCOMPARTEDATOS_D] [varchar](2) NULL,
  [lty_FLAGAUTCANJE] [varchar](1) NULL,
  [lty_FLAGAUTCANJE_D] [varchar](2) NULL,
  [lty_FLAGCLTEFALLECIDO] [varchar](1) NULL,
  [lty_FLAGCLTEFALLECIDO_D] [varchar](2) NULL,
  [lty_RAZONSOCIAL] [varchar](50) NULL,
  [lty_FECHACREACION_PER] [varchar](8) NULL,
  [lty_HORACREACION_PER] [varchar](8) NULL,
  [lty_FECHAULTMODIF_PER] [varchar](8) NULL,
  [lty_FECHACARGAINICIAL_PER] [varchar](8) NULL,
  [lty_FECHACARGAULTMODIF_PER] [varchar](8) NULL,
  [lty_CODPOS] [varchar](6) NULL,
  [lty_DIRECCION] [varchar](150) NULL,
  [lty_DEPARTAMENTO] [varchar](25) NULL,
  [lty_PROVINCIA] [varchar](25) NULL,
  [lty_DISTRITO] [varchar](25) NULL,
  [lty_FLAGULTIMO_DIR] [varchar](1) NULL,
  [lty_REFERENCIA] [varchar](150) NULL,
  [lty_ESTADO] [varchar](1) NULL,
  [lty_ESTADO_D] [varchar](6) NULL,
  [lty_COORDENADAX] [varchar](20) NULL,
  [lty_COORDENADAY] [varchar](20) NULL,
  [lty_FLAGCOORDENADA] [varchar](1) NULL,
  [lty_NSE] [varchar](1) NULL,
  [lty_TELEFONO] [varchar](10) NULL,
  [lty_TELEFONO_D] [varchar](10) NULL,
  [lty_FECHACREACION_TEL] [varchar](8) NULL,
  [lty_EMAIL] [varchar](100) NULL,
  [lty_FECHACREACION_EML] [varchar](8) NULL,
  [lty_HIJ_AS] [int] NULL,
  [lty_HIJ_OS] [int] NULL,
  [lty_HIJ_NN] [int] NULL,
  [lty_HIJ_TOT] [int] NULL,
  [modTipoNegocio] [varchar](16) NOT NULL,
  [modFECHA] [varchar](8) NOT NULL,
  [modANO] [varchar](4) NULL,
  [modMES] [varchar](2) NULL,
  [modPERIODO] [varchar](6) NOT NULL,
  [modDIA] [varchar](2) NULL,
  [modMES_NOM] [nvarchar](30) NULL,
  [modSEMANA_NRO] [int] NULL,
  [modSEMANA_DIA] [int] NULL,
  [modDIA_NOM] [varchar](9) NULL,
  [modDIA_NOM_I] [varchar](1) NULL,
  [modDIA_PARTE] [varchar](20) NULL,
  [com_ContratoRE] [varchar](10) NULL,
  [com_denContrato] [varchar](100) NULL,
  [com_VigContrato] [varchar](50) NULL,
  [com_NomComercial] [varchar](100) NULL,
  [com_ObjAlquiler] [varchar](100) NULL,
  [com_Gafo] [varchar](100) NULL,
  [com_SubGafo] [varchar](100) NULL
)
ON [PRIMARY]
GO