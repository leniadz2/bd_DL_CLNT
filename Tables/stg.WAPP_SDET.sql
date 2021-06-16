﻿CREATE TABLE [stg].[WAPP_SDET] (
  [Message_Type] [varchar](50) NULL,
  [Ind_Store_Forward] [varchar](50) NULL,
  [Account_Number] [varchar](50) NULL,
  [Processing_Code] [varchar](50) NULL,
  [Transaction_Amount] [varchar](50) NULL,
  [Settlement_Amount] [varchar](50) NULL,
  [Card_Issuer_Amount] [varchar](50) NULL,
  [Transmission_Date] [varchar](50) NULL,
  [Transmission_Time] [varchar](50) NULL,
  [Conversion_Rate_Settlement] [varchar](50) NULL,
  [Conversion_Rate_Billing] [varchar](50) NULL,
  [TraceNumber] [varchar](50) NULL,
  [Local_Transaction_Time] [varchar](50) NULL,
  [Local_Transaction_Date] [varchar](50) NULL,
  [Expiry_Date] [varchar](255) NULL,
  [Setllement_Date] [varchar](50) NULL,
  [Conversion_Date] [varchar](50) NULL,
  [Capture_Date] [varchar](50) NULL,
  [Merchant_Type] [varchar](50) NULL,
  [Pos_Entry_Mode] [varchar](50) NULL,
  [Network_Identifier] [varchar](50) NULL,
  [Pos_Condition_Code] [varchar](50) NULL,
  [Sett_Amount_Transaction_Fee] [varchar](50) NULL,
  [Sett_Amount_Processing_Fee] [varchar](50) NULL,
  [Acquiring_Institution] [varchar](50) NULL,
  [Forwarding_Institution] [varchar](50) NULL,
  [Track2_Data] [varchar](50) NULL,
  [Reference_Number] [varchar](50) NULL,
  [Authorization_Code] [varchar](50) NULL,
  [Response_Code] [varchar](50) NULL,
  [Card_Acceptor_TermId] [varchar](50) NULL,
  [Card_Acceptor_Location] [varchar](100) NULL,
  [Transaction_Currency] [varchar](50) NULL,
  [Settlement_Currency] [varchar](50) NULL,
  [Billing_Currency] [varchar](50) NULL,
  [Original_Message_Type] [varchar](50) NULL,
  [Original_Trace_Number] [varchar](50) NULL,
  [Original_Date] [varchar](50) NULL,
  [Original_Time] [varchar](50) NULL,
  [Original_Adquiring_Inst] [varchar](50) NULL,
  [Original_Forwarding_Inst] [varchar](50) NULL,
  [Repla_Transaction_Amount] [varchar](50) NULL,
  [Repla_Settlement_Amount] [varchar](50) NULL,
  [Repla_Transaction_Fee] [varchar](50) NULL,
  [Repla_Settlement_Fee] [varchar](50) NULL,
  [Merchant] [varchar](50) NULL,
  [Requesting_Institution] [varchar](50) NULL,
  [Account_Identification1] [varchar](50) NULL,
  [Account_Identification2] [varchar](50) NULL,
  [CardC_ategory] [varchar](50) NULL,
  [TierII] [varchar](50) NULL,
  [Card_Acceptor_Id] [varchar](50) NULL,
  [Concilia_Autorizacion] [varchar](50) NULL,
  [Concilia_Log_Contable] [varchar](50) NULL,
  [Rol_Transaccion] [varchar](50) NULL,
  [Id_Clase_Servicio] [varchar](50) NULL,
  [Id_Membresia] [varchar](50) NULL,
  [Id_Origen] [varchar](50) NULL,
  [Id_Codigo_Transaccion] [varchar](50) NULL,
  [Id_Clase_Transaccion] [varchar](50) NULL,
  [Fecha_Proceso] [varchar](50) NULL,
  [Id_Cliente] [varchar](50) NULL,
  [Id_Empresa] [varchar](50) NULL,
  [Id_Proceso] [varchar](50) NULL,
  [Id_Canal] [varchar](50) NULL,
  [Id_BIN] [varchar](50) NULL,
  [Cuenta_From] [varchar](50) NULL,
  [Cuenta_To] [varchar](50) NULL,
  [Numero_Documento] [varchar](50) NULL,
  [Cuenta_Cargo] [varchar](50) NULL,
  [Cuenta_Abono] [varchar](50) NULL,
  [Codigo_Analitico] [varchar](50) NULL,
  [Contab_Fondos] [varchar](50) NULL,
  [Id_ATM] [varchar](50) NULL,
  [Fecha_Concilia_Log] [varchar](50) NULL,
  [Id_Sub_BIN] [varchar](50) NULL,
  [Id_Institucion] [varchar](50) NULL,
  [PAN_Entry_Mode] [varchar](50) NULL,
  [PIN_Entry_Capability] [varchar](50) NULL,
  [Institucion_Emisora] [varchar](50) NULL,
  [Institucion_Receptora] [varchar](50) NULL,
  [Secuencia_SIMP] [varchar](50) NULL,
  [Codigo_Seguimiento] [varchar](50) NULL
)
ON [PRIMARY]
GO