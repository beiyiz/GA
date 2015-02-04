USE [DevSitecore_Custom]
GO

/****** Object:  StoredProcedure [dbo].[UpdateItemHistoryApprovalStatus]    Script Date: 2/1/2015 11:08:33 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateItemHistoryApprovalStatus]
	-- Add the parameters for the stored procedure here
	@ChangeId int, 	
	@ApprovalStatus varchar(10)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	UPDATE [dbo].[ItemChangeHistory]
	SET 
		ApprovalStatus = @ApprovalStatus
	WHERE 
		ItemChangeId = @ChangeId

END
 
GO


