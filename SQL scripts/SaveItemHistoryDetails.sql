USE [DevSitecore_Custom]
GO

/****** Object:  StoredProcedure [dbo].[SaveItemHistoryDetails]    Script Date: 2/1/2015 11:09:03 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SaveItemHistoryDetails]
	-- Add the parameters for the stored procedure here
	@ItemChangeID int, 
	@FieldName varchar(255), 
	@OldValue varchar(1000),
	@NewValue varchar(1000)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;



INSERT INTO [dbo].[ItemChangeDetails]
           ([ItemChangeId]
           ,[FieldName]
           ,[OldValue]
           ,[NewValue])
     VALUES
           (@ItemChangeId
           ,@FieldName
           ,@OldValue
           ,@NewValue)




END

GO


